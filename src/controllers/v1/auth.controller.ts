import bcrypt from "bcrypt";
import User, { UserDocument } from "../../models/User";
import { Request, Response } from "express";

export const login = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  const user: UserDocument = await User.findOne({ email });

  if (user) {
    if (user.comparePassword(password)) {
      const token = user.generateToken();

      return res.status(200).json({
        status: 200,
        user,
        token,
      });
    }
  }
  return res.status(400).json({
    status: 400,
    error: "These credentials do not match our records.",
  });
};

export const register = async (req: Request, res: Response) => {
  const { name, username, email, password } = req.body;

  const userExists: UserDocument = await User.findOne({ email });

  if (userExists) {
    return res.status(400).json({
      status: 400,
      error: "User with the given email already exist. Please login.",
    });
  }

  const user = await User.create({
    name,
    username,
    email,
    password,
  });

  const token = user.generateToken();
  delete user.password;

  return res.status(200).json({
    status: 200,
    token,
    user,
    message: "Successfully created a new account.",
  });
};
