const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const qrticketRoutes = require('./QRTicket');
const { Sequelize } = require('sequelize');

// Database connection configuration
const sequelize = new Sequelize({
  dialect: 'mysql',
  host: '192.168.1.4',
  username: 'root',
  password: '12345',
  database: 'concertdb',
});

const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.json());

// Use qrticket routes
app.use('/api', qrticketRoutes);

// Serve static files from the 'dist' directory
app.use(express.static(path.join(__dirname, 'dist')));

// Route for serving the index.html file for all requests
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist', 'index.html'));
});


// Sync database models and start the server
sequelize.sync().then(() => {
  app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
  });
}).catch(err => {
  console.error('Unable to connect to the database:', err);
});
