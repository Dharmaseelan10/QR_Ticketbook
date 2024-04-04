const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const mysql = require('mysql');
const session = require('express-session');
const QRCode = require('qrcode');
const axios = require('axios');
const path = require('path');

const pool = mysql.createPool({
  connectionLimit: 10,
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'concertdb'
});

router.use(session({
  secret: process.env.SESSION_SECRET || 'ticket',
  resave: false,
  saveUninitialized: true
}));

// Middleware to check if the user is authenticated
const isAuthenticated = (req, res, next) => {
  if (!req.session.userId) {
    return res.status(401).json({ error: 'Unauthorized' });
  }
  next();
};

router.get('/check-authentication', (req, res) => {
  // Assuming you have a users table in your database
  const userId = req.query.userId; // Assuming you pass userId as a query parameter

  // Query the database to check if the user exists
  const sql = 'SELECT * FROM users WHERE userId = ?';
  pool.query(sql, [userId], (err, results) => {
    if (err) {
      console.error('Error checking authentication:', err);
      return res.status(500).json({ error: 'Internal server error' });
    }

    if (results.length > 0) {
      // User is authenticated
      res.json({ authenticated: true });
    } else {
      // User is not authenticated
      res.json({ authenticated: false });
    }
  });
});

// Registration endpoint
router.post('/register', (req, res) => {
  const { username, password, email } = req.body;

  // Check if the username or email already exists
  const checkUserQuery = 'SELECT * FROM users WHERE username = ? OR email = ?';
  pool.query(checkUserQuery, [username, email], (err, results) => {
    if (err) {
      console.error('Error checking user existence:', err);
      return res.status(500).json({ error: 'Internal server error' });
    }

    if (results.length > 0) {
      return res.status(409).json({ error: 'Username or email already exists' });
    }

    // Username and email are unique, proceed with registration
    bcrypt.hash(password, 10, (err, hash) => {
      if (err) {
        console.error('Error hashing password:', err);
        return res.status(500).json({ error: 'Internal server error' });
      }

      const insertUserQuery = 'INSERT INTO users (username, password, email) VALUES (?, ?, ?)';
      const values = [username, hash, email];

      pool.query(insertUserQuery, values, (err, result) => {
        if (err) {
          console.error('Error inserting user into database:', err);
          return res.status(500).json({ error: 'Failed to register user' });
        }
        console.log('User registered successfully');
        res.status(201).json({ message: 'User registered successfully' });
      });
    });
  });
});

// Login endpoint
router.post('/login', (req, res) => {
  const { username, password } = req.body;

  // Retrieve user from database based on username
  const getUserQuery = 'SELECT * FROM users WHERE username = ?';
  pool.query(getUserQuery, [username], (err, results) => {
    if (err) {
      console.error('Error fetching user from database:', err);
      return res.status(500).json({ error: 'Internal server error' });
    }

    if (results.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    const user = results[0];
    // Compare hashed password
    bcrypt.compare(password, user.password, (err, result) => {
      if (err) {
        console.error('Error comparing passwords:', err);
        return res.status(500).json({ error: 'Internal server error' });
      }

      if (result) {
        req.session.userId = user.userId;
        res.status(200).json({ message: 'Login successful', user: { id: user.userId, username: user.username } });
      } else {
        res.status(401).json({ error: 'Incorrect password' });
      }
    });
  });
});


router.post('/book-ticket', isAuthenticated, (req, res) => {
  const { concertId, name, phoneNumber, selectedSeat } = req.body;
  const userId = req.session.userId;

  const checkAvailabilityQuery = 'SELECT * FROM bookings WHERE concertId = ? AND selectedSeat = ?';
  pool.query(checkAvailabilityQuery, [concertId, selectedSeat], (err, results) => {
    if (err) {
      console.error('Error checking seat availability:', err);
      return res.status(500).json({ error: 'Internal server error' });
    }

    if (results.length > 0) {
      return res.status(400).json({ error: 'Seat already booked for this concert. Please choose another seat.' });
    }
   

    const insertBookingQuery = 'INSERT INTO bookings (userId, concertId, name, phoneNumber, selectedSeat) VALUES (?, ?, ?, ?, ?)';
    pool.query(insertBookingQuery, [userId, concertId, name, phoneNumber, selectedSeat], (err, result) => {
      if (err) {
        console.error('Error inserting booking into database:', err);
        return res.status(500).json({ error: 'Failed to book ticket' });
      }

      const bookingId = result.insertId;
      // Retrieve concert details including the image URL
      const getConcertQuery = 'SELECT image AS poster, name AS concertName FROM concerts WHERE id = ?';
      pool.query(getConcertQuery, [concertId], (err, concertResult) => {
        if (err || concertResult.length === 0) {
          console.error('Error fetching concert details:', err);
          return res.status(500).json({ error: 'Failed to retrieve concert details' });
        }

        const concertDetails = concertResult[0];
        const qrData = JSON.stringify({
          bookingId: bookingId,
          concertId: concertId,
          name: name,
          phoneNumber: phoneNumber,
          selectedSeat: selectedSeat,
          concertName: concertDetails.concertName,
          poster: concertDetails.poster,
          message: '<<<<Booking exists>>>>'
        });

         // Generate a unique filename for the QR code
         const qrFileName = `qr_code_${concertDetails.concertName}_${bookingId}.png`;
         console.log(qrFileName);
        
          const os = require('os');

        // Get the path to the user's downloads directory
          const userDownloadsDirectory = path.join(os.homedir(), 'Downloads');
          const qrFilePath1 = path.join(userDownloadsDirectory, qrFileName);

          QRCode.toFile(qrFilePath1, qrData, (err) => {
           if (err) {
            console.error('Error saving QR code to the first path:', err);
              } else {
            console.log('QR code saved to user\'s downloads directory');
            }
          });

          const baseUrl = `dist/qr_code/`;
          const qrFilePath2 = `${baseUrl}${qrFileName}`;
          QRCode.toFile(qrFilePath2, qrData, (err) => {
            if (err) {
              console.error('Error generating QR code:', err);
              return res.status(500).json({ error: 'Failed to generate QR code' });
            }
          
          const qrCodePath = `http://localhost:3000/qr_code/${qrFileName}`;
          const updateBookingQuery = 'UPDATE bookings SET qrCodeUrl = ? WHERE id = ?';
          pool.query(updateBookingQuery, [qrCodePath, bookingId], (err) => {
            if (err) {
              console.error('Error updating booking with QR code URL:', err);
              return res.status(500).json({ error: 'Failed to update booking' });
            }
            res.status(201).json({ message: 'Ticket booked successfully', qrData: qrCodePath });
          });
        });
      });
    });
  });
});

router.get('/bookings/:concertId/seats', isAuthenticated, (req, res) => {
  const concertId = req.params.concertId;

  const getBookedSeatsQuery = 'SELECT selectedSeat FROM bookings WHERE concertId = ?';
  pool.query(getBookedSeatsQuery, [concertId], (err, results) => {
    if (err) {
      console.error('Error fetching booked seats:', err);
      return res.status(500).json({ error: 'Internal server error' });
    }

    const bookedSeats = results.map(result => result.selectedSeat);
    res.status(200).json({ bookedSeats: bookedSeats });
  });
});


router.get('/user/bookings', isAuthenticated, (req, res) => {
  const userId = req.session.userId; // Retrieve user ID from the session

  // Query to fetch bookings for the logged-in user
  const getBookingsQuery = 'SELECT * FROM bookings WHERE userId = ?';

  pool.query(getBookingsQuery, [userId], (err, results) => {
    if (err) {
      console.error('Error fetching user bookings:', err);
      return res.status(500).json({ error: 'Internal server error' });
    }

    const bookings = results;
    const promises = [];

    // Fetch concertName for each booking
    bookings.forEach(booking => {
      const getConcertQuery = 'SELECT concertName FROM concerts WHERE id = ?';
      const promise = new Promise((resolve, reject) => {
        pool.query(getConcertQuery, [booking.concertId], (err, concertResult) => {
          if (err) {
            reject(err);
          } else {
            booking.concertName = concertResult[0].concertName;
            resolve();
          }
        });
      });
      promises.push(promise);
    });

    Promise.all(promises)
      .then(() => {
        res.status(200).json(bookings);
      })
      .catch(error => {
        console.error('Error fetching concert names for bookings:', error);
        res.status(500).json({ error: 'Internal server error' });
      });
  });
});
router.delete('/bookings/:id', isAuthenticated, (req, res) => {
  const bookingId = req.params.id;

  // Query to delete the booking from the database
  const deleteBookingQuery = 'DELETE FROM bookings WHERE id = ?';

  pool.query(deleteBookingQuery, [bookingId], (err, result) => {
    if (err) {
      console.error('Error cancelling booking:', err);
      return res.status(500).json({ error: 'Failed to cancel booking' });
    }

    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'Booking not found' });
    }

    // Booking successfully cancelled
    res.status(200).json({ message: 'Booking cancelled successfully' });
  });
});

// Logout endpoint
router.post('/logout', isAuthenticated, (req, res) => {
  // Clear the session
  req.session.destroy(err => {
    if (err) {
      console.error('Error logging out:', err);
      return res.status(500).json({ error: 'Failed to logout' });
    }
    // Successfully logged out
    res.status(200).json({ message: 'Logout successful' });
  });
});


module.exports = router;