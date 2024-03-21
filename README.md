QR Concert Booking System

Prerequisites
Before you begin, ensure that you have the following prerequisites installed on your system:
- Node.js (version 14 or above)
- npm (Node.js package manager) or Yarn
To verify the installation, open a terminal or command prompt and run the following commands:
node -v
npm -v
Ensure that Node.js and npm are installed and properly configured.

Installation

1. Clone the Repository
Clone the QR Concert Booking System repository to your local machine:
git clone <repository-url>
Replace <repository-url> with the URL of the repository.

2. Backend Setup

- Navigate to the backend directory:
cd backend
- Install backend dependencies:
npm install
- Set up the MySQL database using the provided SQL schema.
- Configure the database connection in backend/QRTicket.js and backend/server.js.
- Start the backend server:
node server.js

3. Frontend Setup

- Navigate to the frontend directory:
cd ../frontend
- Install frontend dependencies:
npm install
- Edit components if necessary.
- Build the frontend application:
npm run build

4. Serve the Application

- Copy the contents of the dist directory generated in the frontend folder.
- Paste the copied contents into the backend directory, replacing any existing files.
- Change directory to the backend:
cd ../backend
- Start the backend server to serve the frontend files:
node server.js

5. Access the Application

- Open your web browser and navigate to http://localhost:3000 or the specified port where the backend server is running.

Features

- User Authentication: Users can register, login, and logout securely.
- Ticket Booking: Users can book tickets for concerts by providing their details and selecting seats.
- QR Code Generation: Upon successful booking, a unique QR code is generated for each ticket.
- Ticket Management: Users can view their booked tickets and cancel them if needed.
- Concert Information: Information about upcoming concerts is available, including concert names and dates.

Technologies Used

- Frontend: Vue.js, Axios, QRCode.js
- Backend: Node.js, Express.js, MySQL, Sequelize
- Other: bcrypt (password hashing), express-session (session management)

Contributing

Contributions are welcome! If you'd like to contribute to this project, please fork the repository and create a pull request. Feel free to open an issue for any bugs, feature requests, or questions.

Contact

For any inquiries or support, please contact dseelan563@gmail.com
