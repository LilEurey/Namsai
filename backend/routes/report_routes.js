import { Router } from 'express';
const router = Router();
import { createReport, getAllReports, updateReportStatus, deleteReportById, getReportsByCurrentUser } from '../controllers/report_controller.js';
import { verifyToken } from '../middleware/authMiddleware.js';

//for user
router.post('/', createReport);
router.get('/', getAllReports);
router.get('/myreports', verifyToken, getReportsByCurrentUser);
// router.get('/user/:userId', getReportsByUserId);

//for admin
router.patch('/:id/status', updateReportStatus);
router.delete('/:id', deleteReportById);

export default router;