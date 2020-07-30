import Recipe, { RecipeDocument } from "../../models/Recipe";
import { Request, Response } from "express";

const create = async (req: Request, res: Response) => {
  const {
    title,
    image_url,
    instructions,
    duration,
  }: {
    title: string;
    image_url: string;
    instructions: string;
    duration: number;
  } = req.body;

  const recipe: RecipeDocument = await Recipe.create({
    title,
    image_url,
    instructions,
    duration,
  });

  if (recipe) {
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

export default { create };
