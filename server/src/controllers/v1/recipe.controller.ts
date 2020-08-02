import Recipe, { RecipeDocument } from "../../models/Recipe";
import { Request, Response } from "express";
import { dataUri } from "../../middleware/multer";
import { uploader } from "../../config/cloudinary.config";
import Category from "../../models/Category";

/**
 * This function creates a new recipe
 * @param req - Request object
 * @param res - Response object
 */
const create = async (req: Request, res: Response) => {
  const {
    title,
    description,
    time,
    category,
    cusine,
    utensils,
  }: RecipeDocument = req.body;

  let image: string;

  if (req.file) {
    const file = dataUri(req).content;
    const result = await uploader.upload(file);
    image = result.url;
  }

  const recipe: RecipeDocument = await Recipe.create({
    title,
    description,
    time,
    image,
    category,
    ownerId: req.currentUser._id,
    cusine,
    utensils,
    user: req.currentUser.username,
  });

  if (recipe) {
    try {
      const createdCategory = await Category.findOneAndUpdate(
        { title: category },
        { $push: { recipes: recipe._id } },
        { new: true, upsert: true }
      );
      if (!createdCategory) {
        res.status(500).json({
          status: 500,
          error: "Something went wrong. Could not add recipe to the category.",
        });
      }
    } catch (error) {
      console.log(error);
    }
  }

  if (recipe && image) {
    return res.status(201).json({
      status: 201,
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
    return res.status(302).json({
      status: 302,
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
      return res.status(302).json({
        status: 302,
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

export default { create, getAll, getOne };
