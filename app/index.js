const express = require('express');
const winston = require('winston');

const db = require('./db');

const app = express();
const HOSTNAME = process.env.HOSTNAME || 'localhost';
const PORT = process.env.PORT || '8888';
const LOGLEVEL = process.env.LOGLEVEL || 'info';

const logger = winston.createLogger({
  level: LOGLEVEL,
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [
    new winston.transports.File({ filename: 'logs/error.log', level: 'error' }),
    new winston.transports.File({ filename: 'logs/combined.log' }),
    new winston.transports.Console()
  ],
})


// Routes
app.get('/notes', async (req, res, next) => {
  const { author } = req.query;
  
  try {
    if (!author) {
      const err = new Error('Bad Request');
      err.statusCode = 400;
      throw err;
    }
    const notes = await db.models.note.findAll({
      where: {
        author_id: author,
      },
      include: [
        { model: db.models.member },
      ],
    });
    res.json({ notes });
  } catch (e) {
    next(e);
  }
});

app.use((err, req, res, next) => {
  logger.error(err);
  res.status(err.statusCode || 400).json(err);
});

app.listen(PORT);
logger.info(`App listening on ${HOSTNAME}:${PORT}`);
