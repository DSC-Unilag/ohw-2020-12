import 'package:recipesaver/model/web_recipe.dart';

class WebRecipeViewModel {
  WebRecipe _webRecipe;

  WebRecipeViewModel({WebRecipe webRecipe}) : _webRecipe = webRecipe;

  List<String> get ingredients {
    return _webRecipe.ingredients;
  }

  List<String> get reviews {
    return _webRecipe.reviews;
  }

  String get id {
    return _webRecipe.id;
  }

  String get title {
    return _webRecipe.title;
  }

  String get instructions {
    return _webRecipe.instructions;
  }

  String get image {
    return _webRecipe.image;
  }
  String get createdAt {
    return _webRecipe.createdAt;
  }

}
