import Recipe, { RecipeDocument } from "../../models/Recipe";
import Review, { ReviewDocument } from "../../models/Review";
import { Request, Response } from "express";
import { dataUri } from "../../middleware/multer";
import { uploader, cloudinaryConfig } from "../../config/cloudinary.config";

/**
 * This function creates a new recipe
 * @param req - Request object
 * @param res - Response object
 */
const create = async (req: Request, res: Response) => {
  const {
    title,
    instructions,
    duration,
  }: {
    title: string;
    instructions: string;
    duration: number;
  } = req.body;

  let image: string;

  if (req.file) {
    const file = dataUri(req).content;
    const result = await uploader.upload(file);
    image = result.url;
  }

  const recipe: RecipeDocument = await Recipe.create({
    title,
    instructions,
    duration,
    image,
  });

  if (recipe && image) {
    return res.status(200).json({
      status: 200,
      recipe,
      message: "Successfully created a new recipe.",
    });
  }

  return res.status(500).json({
    status: 500,
    error: "Something went wrong. Could not create recipe.",
  });
};

/**
 * This method gets all the recipes in the database
 * @param req - Request object
 * @param res - Response object
 */
const getAll = async (req: Request, res: Response) => {
  const recipes: RecipeDocument[] = await Recipe.find({});

  if (recipes) {
    return res.status(200).json({
      status: 200,
      recipes,
      message: "Successfully got all recipes.",
    });
  }

  return res.status(500).json({
    status: 500,
    error: "Something went wrong. Could not get all recipe.",
  });
};

/**
 * This method gets a single recipe by ID
 * @param req - Request object
 * @param res - Response object
 */
const getOne = (req: Request, res: Response) => {
  const id: string = req.params.id;
  Recipe.findOne({ _id: id })
    .populate("reviews")
    .then((recipe) => {
      return res.status(200).json({
        status: 200,
        recipe,
        message: "Successfully got a recipe.",
      });
    })
    .catch((e) => {
      return res.status(500).json({
        status: 500,
        error: "Something went wrong. Could not get the recipe.",
      });
    });
};

/**
 * Given a recipe id, this method creates a review for it
 * @param req - Request object
 * @param res - Response object
 */
const createReview = async (req: Request, res: Response) => {
  const { stars, review } = req.body;

  const id: string = req.params.id;
  // first create the review
  const createdReview: ReviewDocument = await Review.create({ stars, review });

  if (createdReview) {
    // find the recipe
    const updatedRecipe: RecipeDocument = await Recipe.findOneAndUpdate(
      { _id: id },
      { $push: { reviews: createdReview._id } },
      // {new: true} to return the updated document, by default it returns the original
      { new: true }
    );

    // return the updated recipe
    if (updatedRecipe) {
      return res.status(200).json({
        status: 200,
        updatedRecipe,
        message: "Successfully reviewed recipe.",
      });
    }
  }

  return res.status(500).json({
    status: 500,
    error: "Something went wrong. Could not review recipe.",
  });
};
export default { create, getAll, getOne, createReview };
