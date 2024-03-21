<template>
  <nav class="navbar">
    <div class="logo" @click="navigate('/')">
      <img src="https://www.shutterstock.com/image-vector/ticket-vector-icon-600nw-691375591.jpg" alt="Site Logo">
      <span class="app-name">QR Concert Booking System</span>
    </div>
    <div class="nav-links">
      <!-- Show Concerts link -->
      <router-link v-if="showloginLink" to="/ticket" class="nav-button"@mouseover="showConcertsIcon = true" @mouseleave="showConcertsIcon = false">
        <span v-if="!showConcertsIcon">Concerts</span>
        <img v-if="showConcertsIcon" src="https://toppng.com/uploads/preview/music-concert-hall-comments-concert-icon-11563061580gvxq0uuf6r.png" alt="Concerts Icon" class="icon concerts-icon">
      </router-link>
      <!-- Show Book Ticket link -->
      <router-link v-if="showloginLink" to="/ticketbooking" class="nav-button"@mouseover="showBookTicketIcon = true" @mouseleave="showBookTicketIcon = false">
        <span v-if="!showBookTicketIcon">Book Ticket</span>
        <img v-if="showBookTicketIcon" src="data:image/png;base64,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" alt="Book Ticket Icon" class="icon book-ticket-icon">
      </router-link>
      <!-- Show Scan Tickets link -->
      <router-link v-if="showloginLink" to="/QRScan" class="nav-button"@mouseover="showScanTicketsIcon = true" @mouseleave="showScanTicketsIcon = false">
        <span v-if="!showScanTicketsIcon">Scan Tickets</span>
        <img v-if="showScanTicketsIcon" src="data:image/png;base64,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"alt="Scan qr Icon" class="icon scan-tickets-icon">
      </router-link>
      <!-- Show Profile link -->
      <router-link v-if="showloginLink" to="/user-qrcode" class="nav-button"@mouseover="showProfileIcon = true" @mouseleave="showProfileIcon = false">
        <span v-if="!showProfileIcon">Profile</span>
        <img v-if="showProfileIcon" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZCbcIQ6M9vh8koj6HwC-6wLHh2E0Wc_xYHAqPOqryngQk9S6Vx_FvjSpTiVeNz8Ce5CE&usqp=CAU" alt="Profile Icon" class="icon profile-icon">
      </router-link>
      <!-- Replace Logout text with icon -->
      <router-link v-if="showloginLink" to="/" class="nav-button" @mouseover="showLogoutIcon = true" @mouseleave="showLogoutIcon = false">
        <span v-if="!showLogoutIcon">Logout</span>
        <img v-if="showLogoutIcon" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMl-ZWsNx4-ztV8WwvXZ-bkkvecSPGG1JlxkcnU9tnnK-cchbULX_Tw-z8kxqvuGO2bn4&usqp=CAU" alt="Logout Icon" class="icon logout-icon">
      </router-link>
      <!-- Replace Sign In text with icon -->
      <router-link v-if="showSignInLink" to="/login" class="nav-button" @mouseover="showSignInIcon = true" @mouseleave="showSignInIcon = false">
        <span v-if="!showSignInIcon">Sign In</span>
        <img v-if="showSignInIcon" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMl-ZWsNx4-ztV8WwvXZ-bkkvecSPGG1JlxkcnU9tnnK-cchbULX_Tw-z8kxqvuGO2bn4&usqp=CAU" alt="Sign In Icon" class="icon sign-in-icon">
      </router-link>
    </div>
  </nav>
</template>

<script>
export default {
  name: 'Navbar',
  data() {
    return {
      showLogoutIcon: false,
      showSignInIcon: false,
      showConcertsIcon: false,
      showBookTicketIcon: false,
      showScanTicketsIcon: false,
      showProfileIcon: false
    };
  },
  computed: {
    // Conditionally show the Concerts link based on the current route
    showloginLink() {
      // Define an array of paths where you want to show the Sign In link
      const allowedPaths = ['/ticket', '/ticketbooking', '/QRScan', '/QRScanner', '/QRScannerFile', '/concert1','/concert2', '/concert3', '/user-qrcode' ];
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
/* Add your CSS styles for the navbar */
.navbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 30px;
  background-image: url('https://media.istockphoto.com/id/967486898/vector/studio-black-mockup.jpg?s=612x612&w=0&k=20&c=YN9LpbeGu-Kb1uTchJE6EKUqaSDRsEH7vqSkcVwVTOg=');
  color: white;
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
  border-radius: 50%;
  overflow: hidden;
}

.app-name {
  font-size: 25px;
  color:
  white;
  font-family: 'Arial Black', sans-serif;
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
  transition: color 0.2s ease;
  text-decoration: none; /* Remove underline */
}

.nav-button:hover {
  color: #42b983;
}

.icon {
  height: 35px; /* Adjust size as needed */
  width: 35px; /* Adjust size as needed */
  border-radius: 50%;
  cursor: pointer;
  transition: transform 0.3s ease;
}

.nav-button:hover .icon {
  transform: translateY(5px); /* Move icon downwards */
}

.logout-icon,
.sign-in-icon,
.concerts-icon,
.book-ticket-icon,
.scan-tickets-icon,
.profile-icon {
  border-radius: 10%; /* Change to box shape */
  height: 30px; /* Adjust size as needed */
  width: 30px; /* Adjust size as needed */
  cursor: pointer;
}

.nav-button:hover .logout-icon,
.nav-button:hover .sign-in-icon,
.nav-button:hover .concerts-icon,
.nav-button:hover .book-ticket-icon,
.nav-button:hover .scan-tickets-icon,
.nav-button:hover .profile-icon {
  filter: brightness(100%);
}
</style>
