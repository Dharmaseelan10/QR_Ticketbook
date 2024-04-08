const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const { createBundleRenderer } = require('vue-server-renderer');
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

// Create a renderer for the server bundle
const renderer = createBundleRenderer(path.resolve(__dirname, 'dist', 'vue-ssr-server-bundle.json'), {
  runInNewContext: false, // Recommended
  template: fs.readFileSync(path.resolve(__dirname, 'dist', 'index.html'), 'utf-8'), // Load HTML template
});

// Route for serving the Vue.js application
app.get('*', (req, res) => {
  const context = { url: req.url };

  // Render Vue app to string
  renderer.renderToString(context, (err, html) => {
    if (err) {
      console.error(err);
      res.status(500).end('Internal Server Error');
      return;
    }
    res.end(html);
  });
});

// Sync database models and start the server
sequelize.sync().then(() => {
  app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
  });
}).catch(err => {
  console.error('Unable to connect to the database:', err);
});
