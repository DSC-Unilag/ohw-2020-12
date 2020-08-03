import multer from "multer";
import DatauriParser from "datauri/parser";
import path from "path";
import { Request } from "express";

const storage: multer.StorageEngine = multer.memoryStorage();

// single("image") - specifies name of the form field to process
const multerUploads = multer({ storage }).single("image");

const dUri: DatauriParser = new DatauriParser();

const dataUri = (req: Request) =>
  dUri.format(path.extname(req.file.originalname).toString(), req.file.buffer);

export { multerUploads, dataUri };
