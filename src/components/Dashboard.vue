<template>
  <div class="homepage">
    <div class="welcome-container">
      <h1 class="header">Welcome to Concert Ticket Booking</h1>
      <img src="https://virtualbarcodereader.orpalis.com/img/content/Visual_header_home.gif" alt="Barcode Scanner GIF" class="banner-image">
      <!-- Buttons for login and register -->
      <div class="auth-buttons">
        <router-link to="/login" class="button">Login</router-link>
        <router-link to="/register" class="button">Register</router-link>
      </div>
      <h2 class="sub-header">Explore and Book Your Favorite Concerts</h2>
      <p class="description">
        Discover upcoming concerts, book tickets conveniently, and enjoy seamless entry using our QR Ticket Booking System. 
        Whether you're a music enthusiast or just looking for a fun night out, we have something for everyone!
      </p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Homepage'
}
</script>

<style scoped>
/* Add styles for the dashboard page */
.homepage {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  color: #333333; /* Changed text color for better contrast */
  padding: 20px;
  background-image: url('https://img.freepik.com/premium-vector/abstract-geometric-square-white-background-light-shadow_51543-426.jpg?w=1060'); /* Updated background image URL */
  background-size: cover;
  background-position: center;
}

.welcome-container {
  max-width: 600px;
}

.header {
  font-size: 36px;
  font-weight: bold;
  margin-bottom: 20px;
}

.sub-header {
  font-size: 24px;
  font-weight: bold;
  margin-top: 20px;
}

.description {
  font-size: 18px;
  margin-bottom: 30px;
}

.banner-image {
  width: 60%; /* Reduced image size */
  max-width: 300px;
  margin-bottom: 20px;
}

.auth-buttons {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

.button {
  padding: 12px 50px; /* Adjusted button padding */
  font-size: 18px;
  background-color: #5d25de;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  margin: 0 10px;
  text-decoration: none;
}

.button:hover {
  background-color: #359e72;
  transform: scale(1.1);
}
</style>
