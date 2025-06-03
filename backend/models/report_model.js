import { Schema, model } from 'mongoose';

const reportSchema = new Schema(
  {
    water_type: {
      type: String,
      required: true,
      enum: ['Canal', 'River', 'Lake', 'Pond', 'Drain', 'Other'],
    },
    custom_water_type: {
      type: String,
      required: function () {
        return this.water_type === 'Other';
      },
    },
    location_description: {
      type: String,
      required: false,
      trim: true,
    },
    coordinates: {
      type: {
        type: String,
        enum: ['Point'],
        default: 'Point',
      },
      coordinates: {
        type: [Number],
        required: true,
      },
    },
    detail: {
      type: String,
      required: true,
      trim: true,
    },
    status: {
      type: String,
      enum: ['Pending', 'In Progress', 'Completed'],
      default: 'Pending',
    },
    createdBy: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
  },
  {
    timestamps: true,
    collection: 'reports',
  }
);

export default model('Report', reportSchema);