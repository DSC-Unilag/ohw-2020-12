import User, { UserDocument } from "../../models/User";
import { Request, Response } from "express";
import { validationResult } from "express-validator";
import sendValidationError from "../../utils/errorReporter";

const login = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return sendValidationError(res, errors);
  }

  // have they registered?
  const user: UserDocument = await User.findOne({ email });

  // yes? check their password and generate a token if password is correct
  if (user) {
    if (user.comparePassword(password)) {
      const token = user.generateToken();
      user.password = undefined;
      return res.status(200).json({
        status: 200,
        user,
        token,
        message: "Successfully logged in.",
      });
    }
  }
  // did not register | did not give correct password
  return res.status(400).json({
    status: 400,
    errors: ["These credentials do not match our records."],
  });
};

const register = async (req: Request, res: Response) => {
  // request to touch my body
  const {
    name,
    username,
    email,
    password,
  }: {
    name: string;
    username: string;
    email: string;
    password: string;
  } = req.body;

  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return sendValidationError(res, errors);
  }

  const emailExists: UserDocument = await User.findOne({ email });

  // registered before? What are they looking for again?
  if (emailExists) {
    return res.status(400).json({
      status: 400,
      errors: ["User with the given email already exist. Please login."],
    });
  }

  const usernameExists: UserDocument = await User.findOne({ username });
  if (usernameExists) {
    return res.status(400).json({
      status: 400,
      errors: ["User with the given username already exist. Please login."],
    });
  }

  // fresh user here!
  const user: UserDocument = await User.create({
    name,
    username,
    email,
    password,
  });

  const token = user.generateToken();
  // don't expose thy user
  user.password = undefined;

  return res.status(201).json({
    status: 201,
    token,
    user,
    message: "Successfully created a new account.",
  });
};

export default {
  login,
  register,
};
