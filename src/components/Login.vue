<template>
  <div class="login-container">
    <h2>Login</h2>
    <!-- Your login form fields -->
    <form @submit.prevent="login" class="login-form">
      <label for="username">Username:</label>
      <input v-model="username" type="text" id="username" name="username" placeholder="Enter your username">

      <label for="password">Password:</label>
      <input v-model="password" type="password" id="password" name="password" placeholder="Enter your password">

      <button :disabled="isLoggingIn">
        <span v-if="isLoggingIn">Logging in...</span>
        <span v-else>Login</span>
      </button>
    </form>

    <!-- Display error message if login fails -->
    <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>

    <!-- Registration button -->
    <router-link v-if="!isAuthenticated" to="/register" class="register-link">Don't have an account? Register here</router-link>
    <router-link v-if="isAuthenticated" to="/ticket" class="register-link">Go to Ticket Page</router-link>
  </div>
</template>

<script>
export default {
  name: 'Login',
  data() {
    return {
      username: '',
      password: '',
      errorMessage: '',
      isLoggingIn: false
    };
  },
  computed: {
    isAuthenticated() {
      // Check if the user is authenticated
      // You may need to implement this logic based on your authentication mechanism
      return false; // Placeholder logic
    }
  },
  methods: {
    login() {
      this.isLoggingIn = true; // Set loading state
      const userData = {
        username: this.username,
        password: this.password
      };

      fetch('/api/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(userData)
      })
        .then(response => {
          if (!response.ok) {
            throw new Error('Login failed');
          }
          return response.json();
        })
        .then(data => {
          // Login successful
          // Navigate to the Ticket.vue component
          this.$router.push('/ticket');
        })
        .catch(error => {
          console.error('Login failed:', error);
          // Display error message to the user
          this.errorMessage = 'Username or password incorrect';
        })
        .finally(() => {
          this.isLoggingIn = false; // Reset loading state
        });
    }
  }
};
</script>


<style scoped>
/* Add styles for your login form */
.login-container {
  max-width: 350px;
  margin: 50px auto 0; /* Adjust margin-top for spacing from the header */
  padding: 20px;
  background-image: url('https://media.istockphoto.com/id/967486898/vector/studio-black-mockup.jpg?s=612x612&w=0&k=20&c=YN9LpbeGu-Kb1uTchJE6EKUqaSDRsEH7vqSkcVwVTOg=');
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h2 {
  text-align: center;
  margin-bottom: 20px; /* Add margin-bottom for spacing from the form */
  color: #ffffff; /* Set text color to contrast with dark background */
}

.login-form {
  display: flex;
  flex-direction: column;
}

label {
  margin-bottom: 10px;
  color: #ffffff; /* Set label text color to contrast with dark background */
}

input[type="text"],
input[type="password"],
button {
  padding: 10px;
  margin-bottom: 15px;
  border-radius: 5px;
  border: 1px solid #ccc;
  background-color: rgb(255, 255, 255); /* Semi-transparent white background */
}

button {
  background-color: #42b983;
  color: white;
  border: none;
  cursor: pointer;
}

button:hover {
  background-color: #359e72;
}

.register-link {
  text-align: center;
  color: #ffffff; /* Set text color to contrast with dark background */
  text-decoration: none;
}

.error-message {
  color: red;
  margin-top: 10px;
  text-align: center;
}
</style>