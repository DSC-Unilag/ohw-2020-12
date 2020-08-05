import jwt from "jsonwebtoken";
import { Response, Request, NextFunction } from "express";
import { UserDocument } from "../models/User";

const checkAuth = async (req: Request, res: Response, next: NextFunction) => {
  try {
    const token = await req.headers?.authorization?.split(" ")[1];
    const decoded = jwt.verify(token, process.env.JWT_KEY);
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
