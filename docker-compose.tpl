version: '3.7'
services:
  editor:
    image: "__IMAGE__"
    container_name: editor
    ports:
      - "8088:3000"
    env_file:
      - .env
    volumes:
      - ./logs:/app/logs
    working_dir: /app
