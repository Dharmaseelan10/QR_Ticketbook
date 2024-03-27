<template>
  <div class="ticket-booking">
    <div class="form-container">
      <h2>Book Ticket</h2>
      
      <!-- Dropdown menu to choose concert -->
      <select v-model="selectedConcert" @change="selectConcert" class="select-concert">
        <option value="">Choose Concert</option>
        <option v-for="concert in concerts" :value="concert.id">{{ concert.name }}</option>
      </select>
      
      <!-- Display selected concert's poster -->
      <div v-if="selectedPoster" class="concert-poster">
        <img :src="selectedPoster" alt="Concert Poster">
      </div>
      
      <!-- Form for booking ticket -->
      <div v-if="selectedConcert" class="booking-form">
        <label for="name">Name:</label>
        <input type="text" id="name" v-model="name">
        
        <label for="phoneNumber">Phone Number:</label>
        <input type="text" id="phoneNumber" v-model="phoneNumber">
        
        <label for="seat">Choose Seat:</label>
        <select v-model="selectedSeat" class="select-seat">
          <option v-for="seat in availableSeats" :value="seat">{{ seat }}</option>
        </select>
        
        <button @click="bookTicket" class="book-button">Book Ticket</button>
        <button @click="resetForm" class="book-another-button">Book Another Ticket for this Concert</button>
      
      </div>
      
      <!-- Success message -->
      <div v-if="successMessage" class="success-message">
        {{ successMessage }}
      </div>
      
      <!-- Display QR code -->
      <div v-if="qrData">
        <img :src="qrData" alt="QR Code">
        <p>QR code successfully saved in device</p>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import QRCode from 'qrcodejs2';

export default {
  data() {
    return {
      concerts: [
        { 
          id: 1, 
          name: 'Concert 1 (30th March 2024) Ed Sheeran Tour', 
          image: 'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/01/2023/11/03/F95m-ZSaQAAW8fT-3228084999.jpg',
          concertName: 'Ed Sheeran Tour',
          buttonText: 'Book Tickets',
          seats: Array.from({ length: 10 }, (_, i) => i + 1)
        },
        { 
          id: 2, 
          name: 'Concert 2 (31st March 2024) Music of the Spheres World Tour', 
          image: 'https://media.karousell.com/media/photos/products/2023/6/21/cold_play_malaysia_concert_202_1687310359_38d9eece_progressive.jpg',
          concertName: 'Music of the Spheres World Tour',
          buttonText: 'Book Tickets',
          seats: Array.from({ length: 10 }, (_, i) => i + 1)
        },
        { 
          id: 3, 
          name: 'Concert 3 (10th June 2024) Tom Jones Ages & Stages Tour', 
          image: 'https://images.lifestyleasia.com/wp-content/uploads/sites/5/2024/01/10170711/Snapinsta.app_401095539_17939237780745883_6301259909790717595_n_1080.jpg',
          concertName: 'Tom Jones Ages & Stages Tour',
          buttonText: 'Book Tickets',
          seats: Array.from({ length: 10 }, (_, i) => i + 1)
        }
      ],
      selectedConcert: '',
      selectedPoster: '',
      name: '',
      phoneNumber: '',
      selectedSeat: '',
      successMessage: '',
      qrData: ''
    };
  },
  methods: {
  selectConcert() {
    const selectedConcert = this.concerts.find(concert => concert.id === parseInt(this.selectedConcert));
    if (selectedConcert) {
      this.selectedPoster = selectedConcert.image;
      axios.get(`/api/bookings/${selectedConcert.id}/seats`)
        .then(response => {
          const bookedSeats = response.data.bookedSeats;
          console.log('Booked Seats:', bookedSeats);
          console.log('All Seats:', selectedConcert.seats);
          // Filter out booked seats from availableSeats
          if (Array.isArray(bookedSeats)) {
            this.availableSeats = selectedConcert.seats.filter(seat => !bookedSeats.includes(seat));
          } else {
            this.availableSeats = selectedConcert.seats;
          }
          console.log('Available Seats:', this.availableSeats);
        })
        .catch(error => {
          console.error('Error fetching booked seats:', error);
        });
    }
  },

    bookTicket() {
      const selectedConcert = this.concerts.find(concert => concert.id === parseInt(this.selectedConcert));
      if (selectedConcert) {
        const bookingInfo = {
          concertId: selectedConcert.id,
          concertName: selectedConcert.name,
          poster: selectedConcert.image,
          name: this.name,
          phoneNumber: this.phoneNumber,
          selectedSeat: this.selectedSeat
        };
        axios.post('/api/book-ticket', bookingInfo)
          .then(response => {
            this.successMessage = response.data.message;
            this.qrData = response.data.qrData;
            const qr = new QRCode('qrCode', {
              text: JSON.stringify(bookingInfo),
              width: 200,
              height: 200
            });
          })
          .catch(error => {
            if (error.response && error.response.status === 400) {
              this.errorMessage = error.response.data.error;
            } else {
              this.errorMessage = 'Failed to book ticket. Please try again later.';
            }
          });
      }
    },
    resetForm() {
      this.name = '';
      this.phoneNumber = '';
      this.selectedSeat = '';
      this.successMessage = '';
      this.qrData = '';
      this.errorMessage = '';
    }
  },
  computed: {
    computed: {
  availableSeats() {
    const selectedConcert = this.concerts.find(concert => concert.id === parseInt(this.selectedConcert));
    if (selectedConcert) {
      const bookedSeats = this.bookedSeats; // Assuming this.bookedSeats contains the booked seats
      if (Array.isArray(selectedConcert.seats) && Array.isArray(bookedSeats)) {
        return selectedConcert.seats.filter(seat => !bookedSeats.includes(seat));
        
      } else {
        console.error('Error: Seats data is not properly defined');
        return [];
      }
    } else {
      return [];
    }
  }
}
  }
};
</script>



<style scoped>
.ticket-booking {
  margin: 20px;
}

.form-container {
  max-width: 410px;
  margin: 100px auto;
  padding: 20px;
  background-color:#0000007a;
  /* background-image: url('https://media.istockphoto.com/id/967486898/vector/studio-black-mockup.jpg?s=612x612&w=0&k=20&c=YN9LpbeGu-Kb1uTchJE6EKUqaSDRsEH7vqSkcVwVTOg='); */
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  color: #000000; /* Text color */
}

p {
        color: white;
    }

h2 {
  text-align: center;
  margin-bottom: 20px;
  color: #ffffff; /* Text color */
} 


.select-concert,
.select-seat {
  width: 100%;
  margin-bottom: 10px;
  padding: 8px;
  border: 1px solid #555555; /* Adjust border color */
  border-radius: 5px;
  background-color: #ffffff; /* Adjust background color */
  color: #000000; /* Text color */
}

.concert-poster img {
  width: 100%;
  height: auto;
  margin-top: 10px;
  border: 1px solid #ffffff; /* Adjust border color */
  border-radius: 5px;
}

.booking-form label {
  display: block;
  margin-bottom: 5px;
  color: #ffffff; /* Text color */
}

.booking-form input,
.booking-form select {
  width: 100%;
  padding: 8px;
  margin-bottom: 10px;
  border: 1px solid #555555; /* Adjust border color */
  border-radius: 5px;
  background-color: #ffffff; /* Adjust background color */
  color: #000000; /* Text color */
}

.book-button,
.book-another-button {
  width: 100%;
  padding: 10px;
  background-color: #007bff;
  color: #ffffff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.book-another-button {
  margin-top: 10px;
  background-color: #28a745;
}

.success-message {
  margin-top: 10px;
  color: #28a745;
  font-weight: bold;
  text-align: center;
}

#qr-code {
  margin-top: 20px;
  display: block;
  text-align: center;
}
</style>
