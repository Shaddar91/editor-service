const express = require('express');
const logger = require('./log/logger');

const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  logger.info('Handling request to root route');
  res.send('Hello, world!');
});

app.listen(port, () => {
  logger.info(`Server running on port ${port}`);
});

