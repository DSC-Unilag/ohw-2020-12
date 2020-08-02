import mongoose from "mongoose";

const { Schema } = mongoose;

export interface RecipeDocument extends mongoose.Document {
  title: string;
  description: string;
  time: number;
  ownerId?: string;
  user?: string;
  cusine: string;
  utensils: string;
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
  time: Number,
  ownerId: Schema.Types.ObjectId,
  user: String,
  cusine: String,
  utensils: String,
  title: String,
  image: String,
  createdAt: {
    type: Date,
    default: Date.now,
  },
  description: String,
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
