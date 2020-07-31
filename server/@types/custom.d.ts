import { UserDocument } from "../src/models/User";

declare global {
  namespace Express {
    interface Request {
      currentUser: UserDocument;
    }
  }
}
