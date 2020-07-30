import mongoose from "mongoose";

const { Schema } = mongoose;

export interface ReviewDocument extends mongoose.Document {
  stars: number;
  review: string;
  author: string;
}

const ReviewSchema: mongoose.Schema = new Schema({
  stars: {
    type: Number,
    required: true,
  },
  review: {
    type: String,
  },
  author: Schema.Types.ObjectId,
});

const Review: mongoose.Model<ReviewDocument> = mongoose.model(
  "Review",
  ReviewSchema
);

export default Review;
