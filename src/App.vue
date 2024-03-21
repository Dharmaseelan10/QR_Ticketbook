<template>
  <div id="app">
    <!-- Render the Navbar component -->
    <Navbar />

    <!-- Main content area -->
    <router-view></router-view>
  </div>
</template>

<script>
import Navbar from './components/Navbar.vue';

export default {
  name: 'App',
  components: {
    Navbar
  }
}
</script>

<style>
/* Add your CSS styles for the app */
body {
  margin: 0; /* Remove default body margin */
  overflow: auto; /* Allow scrollbars */
}

#app {
  background-image: url('https://img.freepik.com/premium-vector/abstract-geometric-square-white-background-light-shadow_51543-426.jpg?w=1060');
  background-size: cover;
  background-position: center;
  min-height: 100vh; /* Set minimum height to full viewport height */
  min-width: 99vw; /* Set minimum width to full viewport width */
  overflow: auto; /* Allow scrollbars */
}
</style>
