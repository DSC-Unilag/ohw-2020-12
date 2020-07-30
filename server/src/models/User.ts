import mongoose from "mongoose";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import configuration from "../config/config";

const { JWT_KEY } = configuration(process.env.NODE_ENV);
const { Schema } = mongoose;

export interface UserDocument extends mongoose.Document {
  name: string;
  username: string;
  email: string;
  password: string;
  saved_recipes?: [{}];
  favorite_recipes?: [{}];
  createdAt?: string;
  emailConfirmedAt?: string;
  emailConfirmCode?: string;
  comparePassword?: (password: string) => {};
  generateToken?: () => {};
}

const UserSchema: mongoose.Schema = new Schema({
  email: String,
  password: String,
  createdAt: {
    type: Date,
    default: Date.now,
  },
  emailConfirmedAt: Date,
  emailConfirmCode: String,
  saved_recipes: [
    {
      type: Schema.Types.ObjectId,
      ref: "Recipe",
    },
  ],
  favorite_recipes: [
    {
      type: Schema.Types.ObjectId,
      ref: "Recipe",
    },
  ],
});

// before saving a new user document, hash the password
UserSchema.pre<UserDocument>("save", function hashPassword(next) {
  this.password = bcrypt.hashSync(this.password, 4);
  next();
});

UserSchema.methods.comparePassword = function passwordComparer(
  plainPassword: string
) {
  return bcrypt.compareSync(plainPassword, this.password);
};

UserSchema.methods.generateToken = function tokenGenerator() {
  return jwt.sign({ _id: this._id, username: this.username }, JWT_KEY, {
    expiresIn: "24h",
  });
};

const User: mongoose.Model<UserDocument> = mongoose.model("User", UserSchema);

export default User;
