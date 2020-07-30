import mongoose from "mongoose";

const { Schema } = mongoose;

export interface CategoryDocument extends mongoose.Document {
  title: string;
}

const CategorySchema: mongoose.Schema = new Schema({
  title: {
    type: String,
    required: true,
  },
});

const Category: mongoose.Model<CategoryDocument> = mongoose.model(
  "Category",
  CategorySchema
);

export default Category;
