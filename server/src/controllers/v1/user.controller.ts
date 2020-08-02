import Recipe, { RecipeDocument } from "../../models/Recipe";
import { Request, Response } from "express";
import User, { UserDocument } from "../../models/User";
import Review, { ReviewDocument } from "../../models/Review";

/**
 * this method allows saving a recipe by an authenticated user
 * @param req
 * @param res
 */
const saveRecipe = async (req: Request, res: Response) => {
  const recipeId: string = req.params.id;
  const userId: string = req.currentUser._id;

  // find the recipe document
  const recipe: RecipeDocument = await Recipe.findOne({ _id: recipeId });
  if (recipe) {
    // update the user
    const updatedUser: UserDocument = await User.findOneAndUpdate(
      { _id: userId },
      { $push: { saved_recipes: recipeId } },
      // {new: true} to return the updated document, by default it returns the original
      { new: true }
    );
    // delete updatedUser.password;
    // return the updated recipe
    if (updatedUser) {
      updatedUser.password = undefined;
      return res.status(200).json({
        status: 200,
        user: updatedUser,
        message: "Successfully saved recipe.",
      });
    }
  }

  return res.status(500).json({
    status: 500,
    error: "Something went wrong. Could not save recipe.",
  });
};

/**
 * Add a recipe to favorites
 * @param req
 * @param res
 */
const favorite = async (req: Request, res: Response) => {
  const recipeId: string = req.params.id;
  const userId: string = req.currentUser._id;

  // find the recipe document
  const recipe: RecipeDocument = await Recipe.findOne({ _id: recipeId });

  if (recipe) {
    // update the user
    const updatedUser: UserDocument = await User.findOneAndUpdate(
      { _id: userId },
      { $push: { favorite_recipes: recipeId } },
      // {new: true} to return the updated document, by default it returns the original
      { new: true }
    );
    // return the updated recipe
    if (updatedUser) {
      updatedUser.password = undefined;
      return res.status(200).json({
        status: 200,
        user: updatedUser,
        message: "Successfully added recipe to favorites.",
      });
    }
  }

  return res.status(500).json({
    status: 500,
    error: "Something went wrong. Could not add recipe to favorites.",
  });
};

/**
 * This method gets all the registered users
 * @param req - Request object
 * @param res - Response object
 */

const getAll = async (req: Request, res: Response) => {
  const users: UserDocument[] = await User.find({});

  const protectedUsers = users.map((user) => {
    // I don't know why delete user.password does not work
    user.password = undefined;
    return user;
  });

  if (users) {
    return res.status(200).json({
      status: 200,
      users: protectedUsers,
      message: "Successfully got all users.",
    });
  }

  return res.status(500).json({
    status: 500,
    error: "Something went wrong. Could not get all users.",
  });
};

/**
 * This method gets a single user by ID alongside their saved recipes
 * @param req - Request object
 * @param res - Response object
 */
const getOne = (req: Request, res: Response) => {
  const id: string = req.params.id;
  User.findOne({ _id: id })
    .populate("saved_recipes")
    .populate("favorite_recipes")
    .then((user) => {
      user.password = undefined;
      return res.status(200).json({
        status: 200,
        user,
        message: "Successfully got user details.",
      });
    })
    .catch((e) => {
      return res.status(500).json({
        status: 500,
        error: "Something went wrong. Could not get the user.",
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
  const user: string = req.currentUser.username;

  const id: string = req.params.id;
  // first create the review
  const createdReview: ReviewDocument = await Review.create({
    stars,
    review,
    author: user,
  });

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

export default { getAll, getOne, saveRecipe, createReview, favorite };
