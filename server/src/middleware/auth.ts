import jwt from "jsonwebtoken";
import { Response, Request, NextFunction } from "express";
import { UserDocument } from "../models/User";
import configuration from "../config/config";

// get the key based on environment, handy when testing
const { JWT_KEY } = configuration(process.env.NODE_ENV);

const checkAuth = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const token = await req.headers?.authorization?.split(" ")[1];
    const decoded = jwt.verify(token, JWT_KEY);
    req.currentUser = decoded as UserDocument;
    next();
  } catch (err) {
    return res.status(401).json({
      status: 401,
      errors: ["Authentication Failed"],
    });
  }
};

export default checkAuth;
