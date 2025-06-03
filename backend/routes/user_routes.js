import { Router } from 'express';
const router = Router();
import { getAllUsers, getUserById, getUserReports, registerUser, loginUser } from '../controllers/user_controller.js';
import authMiddleware from '../middleware/authMiddleware.js';

// Routes mapped to controller functions
router.get('/', getAllUsers);
router.get('/:id', getUserById);
router.get('/:id/reports', authMiddleware, getUserReports);
router.post('/register', registerUser);
router.post('/login', loginUser);

export default router;