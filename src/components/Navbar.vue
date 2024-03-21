<template>
  <nav class="navbar">
    <div class="logo" @click="navigate('/')">
      <img src="https://www.shutterstock.com/image-vector/ticket-vector-icon-600nw-691375591.jpg" alt="Site Logo">
      <span class="app-name">QR Concert Booking System</span>
    </div>
    <div class="nav-links">
      <!-- Show Concerts link -->
      <router-link v-if="showloginLink" to="/ticket" class="nav-button">Concerts</router-link>
      <router-link v-if="showloginLink" to="/ticketbooking" class="nav-button">Book Ticket</router-link>
      <router-link v-if="showloginLink" to="/QRScan" class="nav-button">Scan Tickets</router-link>
      <router-link v-if="showloginLink" to="/user-qrcode" class="nav-button">Profile </router-link>
      <!-- Replace Logout text with icon -->
      <router-link v-if="showloginLink" to="/" class="nav-button" @mouseover="showLogoutIcon = true" @mouseleave="showLogoutIcon = false">
        <span v-if="!showLogoutIcon">Logout</span>
        <img v-if="showLogoutIcon" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMl-ZWsNx4-ztV8WwvXZ-bkkvecSPGG1JlxkcnU9tnnK-cchbULX_Tw-z8kxqvuGO2bn4&usqp=CAU" alt="Logout Icon" class="logout-icon">
      </router-link>
      <!-- Replace Sign In text with icon -->
      <router-link v-if="showSignInLink" to="/login" class="nav-button" @mouseover="showSignInIcon = true" @mouseleave="showSignInIcon = false">
        <span v-if="!showSignInIcon">Sign In</span>
        <img v-if="showSignInIcon" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMl-ZWsNx4-ztV8WwvXZ-bkkvecSPGG1JlxkcnU9tnnK-cchbULX_Tw-z8kxqvuGO2bn4&usqp=CAU" alt="Sign In Icon" class="sign-in-icon">
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
      showSignInIcon: false
    };
  },
  computed: {
    // Conditionally show the Concerts link based on the current route
    showloginLink() {
      // Define an array of paths where you want to show the Sign In link
      const allowedPaths = ['/ticket', '/ticketbooking', '/user-qrcode', '/QRScan', '/QRScanner', '/QRScannerFile', '/concert1','/concert2', '/concert3' ];
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
  padding: 10px 20px;
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
  font-size: 20px;
  color: white;
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
  color: #42b983;
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
  filter: brightness(70%);
}
</style>
