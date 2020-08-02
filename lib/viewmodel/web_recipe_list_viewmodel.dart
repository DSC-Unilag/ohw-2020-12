import 'package:flutter/cupertino.dart';
import 'package:recipesaver/model/web_recipe.dart';
import 'package:recipesaver/services/web_services.dart';
import 'package:recipesaver/viewmodel/base_model.dart';
import 'package:recipesaver/viewmodel/web_recipe_viewmodel.dart';

enum LoadingStatus{
  completed,
  searching,
  empty
}
class WebRecipeListViewModel extends BaseModel{
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<WebRecipeViewModel> recipes = List<WebRecipeViewModel>();

  void getRecipes() async{
    List<WebRecipe> webRecipes = await WebServices().fetchRecipe();
    loadingStatus = LoadingStatus.searching;
    notifyListeners();
    this.recipes = webRecipes.map((recip) => WebRecipeViewModel(webRecipe: recip)).toList();

    if(this.recipes.isEmpty){
      this.loadingStatus = LoadingStatus.empty;
    }else{
      this.loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }
}