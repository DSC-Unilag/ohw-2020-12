# Recipe Saver

A application where users can share and save recipes.

# Technologies

### UI/UX

- Figma

Contributors(s):[Emmbrik](https://github.com/emmbrik)

### Backend REST API

- Node.js
- TypeScript
- Express
- Jest
- MongoDB
- Mongoose
- JWT
- Multer
- Express Validator
- Bcrypt

Contributor(s): [Olusamimaths](https://github.com/Olusamimaths/)

### Frontend Web App

- HTML/CSS
- Javascript fetch api
- Local Storage


Contributor(s): [HERITAGEALABI](https://github.com/HERITAGEALABI), [MirakleDdev](https://github.com/MirakleDdev), [Adekomi-Abdulhaleem](https://github.com/Adekomi-Abdulhaleem)

### Android and iOS Apps

- Dart
- Flutter





![ezgif com-optimize-min](https://user-images.githubusercontent.com/32166619/89283925-df8f0100-d645-11ea-95f1-d2eaa719d284.gif)
download Android app [here](https://drive.google.com/file/d/1HY10UdhI_YM819OrmN7LITKe2e0DjWSd/view?usp=drivesdk)

Contributor(s): [Yczar](https://github.com/Yczar),
                [Oyalekephilip](https://github.com/oyalekephilip)
                

# Features

Users can:

- create a new account if they are not registered already
- login to use the accessible features provided
- create and post recipes
- add recipes posted by other users to their favorite recipe list
- save recipes created by other users.
- view recipes posted in the application
- review a recipe with a star rating and a comment
- search for a recipe by providing a search string
- view all the categories of recipes in the application
- view all the recipes under a category

## Endpoints

_Base Url_: https://recipe-saver-backend.herokuapp.com

| Request | End Points                | Functionality                                                           |
| ------- | ------------------------- | ----------------------------------------------------------------------- |
| POST    | /api/v1/auth/register     | Creates an account for a user.                                          |
| POST    | /api/v1/auth/login        | Logs a user in.                                                         |
| POST    | /api/v1/recipe/create     | Creates a a new recipe                                                  |
| POST    | /api/v1/user/review/:id   | Allows a user to review a recipe with the given id.                     |
| POST    | /api/v1/user/save/:id     | Allows a user to save a recipe with the given id.                       |
| POST    | /api/v1/user/favorite/:id | Allows a user to add a recipe with the given id to their favorite list. |
| POST    | /api/v1/recipe/search     | Allows a user to search for a recipe by providing a search string       |
| GET     | /api/v1/recipe/all        | Gets all recipes in the application                                     |
| GET     | /api/v1/category/all      | Gets all categoris of recipes in the application                        |
| GET     | /api/v1/category/id       | Gets all the recipes under a category with the id in the application    |
| GET     | /api/v1/recipe/id         | Gets a single recipe by its id                                          |
| GET     | /api/v1/user/id           | Gets user information including their saved and favorite recipes        |
