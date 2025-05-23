<template>
  <div class="user-qrcode">
    <h2>Your Bookings</h2>
    <div v-if="bookings.length === 0">
      <p class="info">No bookings found, Do grab your tickets now!</p>
      <router-link to="/ticket" class="button ticketbutton">Explore concerts</router-link>
      <router-link to="/ticketbooking" class="button ticketbutton">Book Tickets Now</router-link>
    </div>
    <div v-else>
      <table>
        <thead>
          <tr>
            <th>Concert Name</th>
            <th>Seat</th>
            <th>QR Code</th>
            <th>Actions</th> <!-- New column for actions -->
          </tr>
        </thead>
        <tbody>
          <tr v-for="(booking, index) in bookings" :key="index" class="booking">
            <td>{{ booking.concertName }}</td>
            <td>{{ booking.selectedSeat }}</td>
            <td>
              <div class="qr-code-container">
                <img :src="booking.qrCodeUrl" alt="QR Code" class="qr-code-img" @click="downloadQRCode(booking.qrCodeUrl)">
              </div>
            </td>
            <td>
              <button @click="confirmCancelBooking(booking)">Cancel Booking</button> <!-- Cancel booking button with confirmation -->
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'UserQRCode',
  data() {
    return {
      bookings: [] // Initialize bookings array
    };
  },
  mounted() {
    // Fetch current user's bookings data from backend server
    this.fetchUserBookings();
  },
  methods: {
    fetchUserBookings() {
      // Make an HTTP request to fetch user's bookings data
      axios.get('/api/user/bookings')
        .then(response => {
          this.bookings = response.data;
        })
        .catch(error => {
          console.error('Error fetching user bookings:', error);
          // Handle error
        });
    },
    confirmCancelBooking(booking) {
      if (window.confirm('Are you sure you want to cancel this booking?')) {
        this.cancelBooking(booking);
      }
    },
    cancelBooking(booking) {
      // Make an HTTP request to cancel the booking
      axios.delete(`/api/bookings/${booking.id}`)
        .then(response => {
          // Remove the booking from the array
          const index = this.bookings.indexOf(booking);
          if (index !== -1) {
            this.bookings.splice(index, 1);
          }
          console.log('Booking cancelled successfully');
        })
        .catch(error => {
          console.error('Error cancelling booking:', error);
          // Handle error
        });
    },
    downloadQRCode(qrCodeUrl) {
      // Create a link element
      const link = document.createElement('a');
      link.href = qrCodeUrl;
      link.download = 'qr_code.png'; // Set the filename for the downloaded image
      document.body.appendChild(link); // Append the link to the DOM
      link.click(); // Simulate a click event to trigger the download
      document.body.removeChild(link); // Remove the link from the DOM after download
    }
  }
}
</script>


<style scoped>
/* Styles for the QR code image */
.qr-code-img {
  max-width: 100px; /* Original size */
  transition: max-width 0.3s ease; /* Add transition for smoother effect */
  cursor: pointer; /* Change cursor to pointer */
}

/* Hover effect for the QR code image */
.qr-code-img:hover {
  max-width: 200px; /* Increased size on hover */
}

h2 {
  text-align: center;
  margin-top: 75px;
  margin-bottom: 5px; /* Add margin-bottom for spacing from the form */
  color: #ffffff; /* Set text color to contrast with dark background */
}

.info {
  font-size: 15px;
  color: #ffffff; /* Set text color to contrast with white */
  font-family: Arial, sans-serif;
  margin-bottom: 10px;
  margin-top: 10px;
}

.ticketbutton {
  background-color: #007bff; /* Set button background color */
  display: inline-block;
  padding: 10px 15px;
  color: white;
  text-decoration: none;
  margin: 10px;
  border-radius: 10px;
  font-size: 15px;
  transition: background-color 0.3s ease;
}

.user-qrcode {
  padding: 15px;
}

.booking {
  margin-bottom: 20px;
  border: 1px solid #333333; /* Adjust border color */
  padding: 10px;
  border-radius: 5px;
}

table {
  width: 65%; /* Adjusted width */
  border-collapse: collapse;
  margin: 20px auto; /* Center the table */
  background-color: #00000074; /* Set background color to white */
  color: #ffffff; /* Text color */
}

th {
  background-color: #56006578; /* Set header background color */
  color: #ffffff; /* Header text color */
  padding: 10px;
  text-align: left;
}

th, td {
  border: 1px solid #ccc;
  padding: 10px;
}

.qr-code-container {
  position: relative;
}
</style>

