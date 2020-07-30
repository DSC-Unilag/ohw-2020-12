import Recipe, { RecipeDocument } from "../../models/Recipe";
import { Request, Response } from "express";
import { dataUri } from "../../middleware/multer";
import { uploader, cloudinaryConfig } from "../../config/cloudinary.config";

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

  let image;

  if (req.file) {
    const file = dataUri(req).content;
    uploader
      .upload(file)
      .then((result) => {
        image = result.url;
      })
      .catch((e) => console.log(`Error while uploading: `, e));
  }

  const recipe: RecipeDocument = await Recipe.create({
    title,
    instructions,
    duration,
  });

  if (recipe && image) {
    return res.status(200).json({
      status: 200,
      recipe,
      message: "Successfully created a new recipe.",
      image,
    });
  }

  return res.status(500).json({
    status: 500,
    error: "Something went wrong. Could not create recipe.",
  });
};

export default { create };
