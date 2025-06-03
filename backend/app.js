import dotenv from 'dotenv';
import express from 'express';
import mongoose from 'mongoose';
import cors from 'cors';

import userRoutes from './routes/user_routes.js';
import reportRoutes from './routes/report_routes.js';


dotenv.config();

const app = express();
app.use(express.json());
app.use(cors()); // Allow all origins

app.use('/api/users', userRoutes);
app.use('/api/reports', reportRoutes);


// Connect to MongoDB Atlas
mongoose.connect(process.env.DATABASE_URL)
    .then(() => console.log('✅ Connected to MongoDB Atlas'))
    .catch(err => console.error('❌ MongoDB connection error:', err));

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`🚀 Server is running at http://localhost:${PORT}`);
});