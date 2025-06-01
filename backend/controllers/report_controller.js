import Report from '../models/report_model.js';
import mongoose from 'mongoose';

// Create a new report
export const createReport = async (req, res) => {
  try {
    const {
      water_type,
      custom_water_type,
      location_description,
      coordinates,
      detail,
      createdBy,
    } = req.body;

    // ✅ Validate coordinates
    if (
      !coordinates ||
      coordinates.type !== 'Point' ||
      !Array.isArray(coordinates.coordinates) ||
      coordinates.coordinates.length !== 2
    ) {
      return res.status(400).json({ error: 'Invalid coordinates format' });
    }

    // ✅ Ensure createdBy is converted to ObjectId
    const userId = new mongoose.Types.ObjectId(createdBy);

    // 🔁 Check for duplicate report
    const existingReport = await Report.findOne({
      createdBy: userId,
      location_description: { $regex: `^${location_description.trim()}$`, $options: 'i' },
    });


    if (existingReport) {
      return res.status(400).json({
        error: 'Duplicate report: You have already submitted this report.',
      });
    }

    // ✅ Save report
    const report = new Report({
      water_type,
      custom_water_type,
      location_description,
      coordinates,
      detail,
      createdBy: userId,
    });

    const savedReport = await report.save();

    res.status(201).json({
      message: '✅ Report created successfully',
      report: savedReport,
    });

  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};

// Get all reports with user info
export const getAllReports = async (req, res) => {
  try {
    const reports = await Report.find().populate('createdBy');
    res.status(200).json(reports);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// Get a single report by ID
export const getReportById = async (req, res) => {
  try {
    const report = await Report.findById(req.params.id).populate('createdBy');
    if (!report) return res.status(404).json({ error: 'Report not found' });
    res.json(report);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};


export const updateReportStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    // Ensure valid status
    const allowedStatuses = ['Pending', 'In Progress', 'Completed'];
    if (!allowedStatuses.includes(status)) {
      return res.status(400).json({ error: 'Invalid status value' });
    }

    const updatedReport = await Report.findByIdAndUpdate(
      id,
      { status },
      { new: true }
    );

    if (!updatedReport) {
      return res.status(404).json({ error: 'Report not found' });
    }

    res.status(200).json({ message: 'Report status updated', report: updatedReport });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const getReportsByUserId = async (req, res) => {
  try {
    const { userId } = req.params;

    // Convert to ObjectId (important to prevent cast error)
    if (!mongoose.Types.ObjectId.isValid(userId)) {
      return res.status(400).json({ error: 'Invalid user ID format' });
    }

    const reports = await Report.find({ createdBy: new mongoose.Types.ObjectId(userId) });
    res.status(200).json(reports);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const getReportsByCurrentUser = async (req, res) => {
  try {
    const userId = req.user.userId; // ✅ from decoded token
    const reports = await Report.find({ createdBy: userId }).populate('createdBy', 'name');;
    res.status(200).json(reports);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

export const deleteReportById = async (req, res) => {
  try {
    const { id } = req.params;

    if (!mongoose.Types.ObjectId.isValid(id)) {
      return res.status(400).json({ error: 'Invalid report ID format' });
    }

    const deleted = await Report.findByIdAndDelete(id);
    if (!deleted) return res.status(404).json({ error: 'Report not found' });

    res.status(200).json({ message: 'Report deleted successfully', report: deleted });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};