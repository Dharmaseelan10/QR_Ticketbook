<template>
  <nav class="navbar">
    <div class="logo" @click="navigate('/')">
      <img src="https://static.vecteezy.com/system/resources/thumbnails/022/119/121/small/ticket-icon-line-raffle-ticket-symbol-trendy-flat-outline-ui-sign-design-thin-linear-graphic-pictogram-for-web-site-mobile-application-logo-illustration-eps10-free-vector.jpg" alt="Site Logo">
      <span class="app-name">QR Concert Booking System</span>
    </div>
    <div class="nav-links">
      <!-- Show Concerts dropdown menu -->
      <div v-if="showloginLink" class="dropdown">
        <button class="nav-button dropdown-btn">Concerts ⇓</button>
        <div class="dropdown-content">
          <router-link to="/ticket" class="dropdown-item">All concerts</router-link>
          <router-link to="/concert1" class="dropdown-item">Ed Sheeran: + - = ÷ × Tour</router-link>
          <router-link to="/concert2" class="dropdown-item">Music of the Spheres World Tour</router-link>
          <router-link to="/concert3" class="dropdown-item">Tom Jones Ages & Stages Tour</router-link>
        </div>
      </div>
      
      <!-- Show Scan Ticket dropdown menu -->
      <div v-if="showloginLink" class="dropdown">
        <button class="nav-button dropdown-btn">Scan Tickets ⇓</button>
        <div class="dropdown-content">
          <router-link to="/QRScan" class="dropdown-item">Scan Ticket</router-link>
          <router-link to="/QRScanner" class="dropdown-item">Camera Scanning</router-link>
          <router-link to="/QRScannerFile" class="dropdown-item">Choose from device</router-link>
          <router-link to="/QRScannerMachine" class="dropdown-item">QR Machine</router-link>
        </div>
      </div>

      <!-- Other navigation links -->
      <router-link v-if="showloginLink" to="/ticketbooking" class="nav-button">Book Ticket</router-link>
      <router-link v-if="showloginLink" to="/user-qrcode" class="nav-button">Profile</router-link>
      
      <!-- Replace Logout text with icon -->
      <router-link v-if="showloginLink" to="/" class="nav-button" @mouseover="showLogoutIcon = true" @mouseleave="showLogoutIcon = false">
        <span v-if="!showLogoutIcon">Logout</span>
        <img v-if="showLogoutIcon" src="https://cdn-icons-png.freepik.com/512/1053/1053364.png" alt="Logout Icon" class="logout-icon">
      </router-link>

      <router-link v-if="showSignInLink" to="/login" class="nav-button">SignIn</router-link>
      
    </div>
  </nav>
</template>


<script>
export default {
  name: 'Navbar',
  data() {
    return {
      showLogoutIcon: false,
      showSignInIcon: false
    };
  },
  computed: {
    // Conditionally show the Concerts link based on the current route
    showloginLink() {
      // Define an array of paths where you want to show the Sign In link
      const allowedPaths = ['/ticket', '/ticketbooking', '/user-qrcode', '/QRScan', '/QRScanner', '/QRScannerMachine', '/QRScannerFile', '/concert1','/concert2', '/concert3', '/Chatbot' ];
      // Return true if the current route is included in the allowed paths
      return allowedPaths.includes(this.$route.path);
    },
   
    // Conditionally show the Sign In link based on the current route
    showSignInLink() {
      // Define an array of paths where you want to show the Sign In link
      const allowedPaths = [ '/', '/login','/register' ];
      // Return true if the current route is included in the allowed paths
      return allowedPaths.includes(this.$route.path);
    },
  },
  methods: {
    navigate(route) {
      // Programmatically navigate to the specified route
      this.$router.push(route);
    }
  }
}
</script>

<style scoped>
/* Your existing styles for navbar */

.navbar {
  position: fixed; /* Set navbar position to fixed */
  top: 0; /* Position it at the top */
  left: 0; /* Position it at the left */
  right: 0; /* Position it at the right */
  z-index: 1000; /* Ensure it stays on top */
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 20px;
  background-color: #00000095;
  box-shadow:  0 0 5px #ffffff;        
}

.logo {
  display: flex;
  align-items: center;
  cursor: pointer;
}

.logo img {
  height: 40px;
  width: auto;
  margin-right: 10px;
  border-radius: 80%;
  /* overflow: hidden; */
}

.app-name {
  font-size: 25px;
  color: white;
}
.app-name:hover{
  color: rgb(255, 255, 255);
    text-shadow: 0 0 5px #ffffff, /* Add shadow effect */
               0 0 25px #03e9f4;
             
}

.nav-links {
  display: flex;
  align-items: center;
}

.nav-button {
  margin-left: 20px;
  color: white;
  background-color: transparent;
  border: none;
  cursor: pointer;
  transition: color 0.3s ease;
  text-decoration: none; /* Remove underline */
}

.nav-button:hover {
  background: none; /* Remove the background color */
  color: #ffffff; /* Set text color */
  text-shadow: 0 0 5px #03e9f4, /* Add shadow effect */
               0 0 25px #03e9f4,
               0 0 50px #03e9f4,
               0 0 200px #03e9f4;
}

.logout-icon,
.sign-in-icon {
  height: 30px; /* Adjust size as needed */
  width: 30px; /* Adjust size as needed */
  border-radius: 50%;
  cursor: pointer;
}

.nav-button:hover .logout-icon,
.nav-button:hover .sign-in-icon {

  background: none; /* Remove the background color */
  color: #ffffff; /* Set text color */
  text-shadow: 0 0 5px #03e9f4, /* Add shadow effect */
               0 0 25px #03e9f4,
               0 0 50px #03e9f4,
               0 0 200px #03e9f4;
}

/* Dropdown styles */
.dropdown {
  position: relative;
}

.dropdown-btn {
  background-color: #00000000;
  border: none;
  cursor: pointer;
  color: white;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #00000095;
  min-width: 160px;
  z-index: 1;
}

.dropdown-content .dropdown-item {
  color: white;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  background-color: #00000095;
}

.dropdown-content .dropdown-item:hover {
  background-color: #555;
}

.dropdown:hover .dropdown-content {
  display: block;
}
</style>
