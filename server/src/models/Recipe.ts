import mongoose from "mongoose";

const { Schema } = mongoose;

export interface RecipeDocument extends mongoose.Document {
  title: string;
  instructions: string;
  duration: number;
  stars?: number;
  createdAt?: string;
  image?: string;
}

const RecipeSchema: mongoose.Schema = new Schema({
  title: String,
  image: String,
  createdAt: {
    type: Date,
    default: Date.now,
  },
  instructions: String,
  stars: Number,
});

const Recipe: mongoose.Model<RecipeDocument> = mongoose.model(
  "Recipe",
  RecipeSchema
);

export default Recipe;
