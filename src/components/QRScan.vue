<template>
  <div class="qr-scan-container">
    <!-- Welcome message -->
    <div class="welcome">
      <h1 class="title">Redeem Your Ticket Now ! </h1>
      <h2 class="title">Scan Your Ticket Here</h2>
      <p class="info">Scan your ticket to gain access. </p>
      <p class="info">This scanner will display information about the ticket and allow entry.</p>
    </div>
    
    <!-- QR Scanner buttons -->
    <div class="button-container">
      <router-link to="/QRScanner" class="button qr-button">Scan QR Ticket from Camera</router-link>
      <router-link to="/QRScannerFile" class="button qr-button">Scan QR Ticket from File</router-link>
    </div>
  </div>
</template>

<script>
export default {
  name: 'QRScan'
}
</script>

<style scoped>
/* Add your scoped styles for the QR scan page */

.qr-scan-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.welcome {
  width: 100%;
  padding: 20px;
  text-align: center;
}

.title {
  font-size: 50px;
  font-weight: bold;
  color: rgb(0, 0, 0);
  font-family: 'Arial Black', sans-serif;
}

.info {
  font-size: 35px;
  color: rgb(0, 0, 0);
  font-family: Arial, sans-serif;
  margin-bottom: 0px;
  margin-top: 0px;
}

.button-container {
  margin-top: 30px;
}

.button {
  display: inline-block;
  padding: 20px 40px;
  background-color: #42b983;
  color: white;
  text-decoration: none;
  margin: 10px;
  border-radius: 10px;
  font-size: 25px;
  font-weight: bold;
  transition: background-color 0.3s ease;
}

.qr-button {
  background-color: #00bfff;
}

.button:hover {
  background-color: #359e72;
}
</style>
