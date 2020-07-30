import mongoose from "mongoose";

const { Schema } = mongoose;

export interface ReviewDocument extends mongoose.Document {
  stars: number;
  review: string;
}

const ReviewSchema: mongoose.Schema = new Schema({
  stars: {
    type: Number,
    required: true,
  },
  review: {
    type: String,
  },
});

const Review: mongoose.Model<ReviewDocument> = mongoose.model(
  "Review",
  ReviewSchema
);

export default Review;
