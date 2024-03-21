<template>
  <div class="registration-container">
    <h2>Register</h2>
    <form @submit.prevent="register" class="registration-form">
      <div class="form-group">
        <label for="name" class="form-label">Name:</label>
        <input type="text" id="name" v-model="formData.name" class="form-input" required>
      </div>
      <div class="form-group">
        <label for="email" class="form-label">Email:</label>
        <input type="email" id="email" v-model="formData.email" class="form-input" required>
      </div>
      <div class="form-group">
        <label for="phone" class="form-label">Phone Number:</label>
        <input type="text" id="phone" v-model="formData.phoneNumber" class="form-input" required>
      </div>
      <div class="form-group">
        <label for="username" class="form-label">Username:</label>
        <input type="text" id="username" v-model="formData.username" class="form-input" required>
      </div>
      <div class="form-group">
        <label for="password" class="form-label">Password:</label>
        <input type="password" id="password" v-model="formData.password" class="form-input" required>
      </div>
      <div class="form-group">
        <label for="confirmPassword" class="form-label">Confirm Password:</label>
        <input type="password" id="confirmPassword" v-model="confirmPassword" class="form-input" required>
      </div>
      <button type="submit" class="submit-button">Register</button>
      <router-link v-if="!isAuthenticated" to="/login" class="login-button">Already have an account? Login</router-link>
    </form>

    <!-- Error message -->
    <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
    <!-- Success message -->
    <p v-if="registrationSuccess" class="success-message">Registration successful! Please login.</p>
  </div>
</template>

<script>
export default {
  name: 'Register',
  data() {
    return {
      formData: {
        name: '',
        email: '',
        phoneNumber: '',
        username: '',
        password: ''
      },
      confirmPassword: '',
      registrationSuccess: false,
      errorMessage: ''
    }
  },
  methods: {
    register() {
      // Check if all fields are filled
      if (!this.formData.name || !this.formData.email || !this.formData.phoneNumber || !this.formData.username || !this.formData.password || !this.confirmPassword) {
        this.errorMessage = 'Please fill in all fields';
        return;
      }

      // Check if passwords match
      if (this.formData.password !== this.confirmPassword) {
        this.errorMessage = 'Passwords do not match';
        return;
      }

      // Send the form data to the server (actual registration process)
      fetch('/api/register', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(this.formData),
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json();
      })
      .then(data => {
        console.log('Registration successful:', data);
        this.registrationSuccess = true;
        this.errorMessage = ''; // Clear any previous error message
        
        // Redirect to login page after successful registration
        this.$router.push('/login');
      })
      .catch(error => {
        console.error('Error during registration:', error);
        this.errorMessage = 'Registration failed. Please try again later.';
      });
    }
  }
}
</script>


<style scoped>
/* Add styles for your registration form */
.registration-container {
  max-width: 400px;
  margin: 20px auto; /* Add margin to create space between header and form */
  padding: 10px 20px;
  background-color: rgba(248, 248, 248, 0.9); /* Adjust opacity here */
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.registration-form {
  width: 100%;
}

.form-group {
  display: flex;
  flex-direction: column;
  margin-bottom: 7px;
}

.form-label {
  font-weight: bold;
  margin-bottom: 5px;
}

.form-input {
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  width: 90%;
  background-color: rgb(255, 255, 255); 
}

.submit-button {
  padding: 10px 20px;
  background-color: #42b983;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  margin-bottom: 10px;
}

.login-button {
  text-align: center;
  color: #007bff;
  text-decoration: none;
  cursor: pointer;
}

.error-message {
  color: red;
}

.success-message {
  color: green;
}
</style>
