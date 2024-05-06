#!/bin/bash
REGISTRY=$(aws sts get-caller-identity | jq -r .Account).dkr.ecr.$AWS_REGION.amazonaws.com
IMAGE="$REGISTRY/editor:master"
sed "s|__IMAGE__|$IMAGE|" docker-compose.tpl > docker-compose.yml
echo "Docker Compose file has been created."

read -p "Do you want to run docker-compose up and fetch secrets from Vault? (yes/no): " response

if [[ "$response" == "yes" ]]; then
    vault kv get -format=json editor_service/secrets | jq -r 'if .data.data then .data.data else .data end | to_entries | .[] | "\(.key)=\(.value)"' >> .env
    echo "Secrets added to .env file."
    docker-compose up
else
    echo "Skipping docker-compose up and Vault secrets fetch."
fi
