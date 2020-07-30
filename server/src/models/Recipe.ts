import mongoose from "mongoose";

const { Schema } = mongoose;

export interface RecipeDocument extends mongoose.Document {
  title: string;
  instructions: string;
  duration: number;
  category: string;
  createdAt?: string;
  image?: string;
  ingredient?: [
    {
      type: string;
      quantity: string;
    }
  ];
  review?: [{}];
}

const RecipeSchema: mongoose.Schema = new Schema({
  title: String,
  image: String,
  createdAt: {
    type: Date,
    default: Date.now,
  },
  instructions: String,
  ingredients: [
    {
      type: String,
      ingredient: String,
    },
  ],
  reviews: [
    {
      type: Schema.Types.ObjectId,
      ref: "Review",
    },
  ],
  category: String,
});

const Recipe: mongoose.Model<RecipeDocument> = mongoose.model(
  "Recipe",
  RecipeSchema
);

export default Recipe;
