import 'package:recipesaver/viewmodel/base_model.dart';
import 'package:recipesaver/model/recipe.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GetRecipeViewModel extends BaseModel{
  List<Recipe> _recipe;
  List<Recipe> _savedrecipe;

  List<Recipe> get recipe => _recipe;
  List<Recipe> get savedrecipe => _savedrecipe;

  Future fetchRecipe() async{
    setBusy(true);
    var recipeResult = await firestoreService.getRecipeOnceOff();
    if(recipeResult is List<Recipe>){
      setBusy(false);
      _recipe = recipeResult;
      notifyListeners();
    }else{
      setBusy(false);
      Fluttertoast.showToast(msg: recipeResult);
    }
  }
  Future saveRecipe(Recipe recipes) async{
    var result  = await firestoreService.saveRecipe(recipes, currentUser.id, recipes.postid);

    if(result is String){
      Fluttertoast.showToast(msg: result, backgroundColor: Colors.red);
    }else{
      Fluttertoast.showToast(msg: "Recipe Saved", backgroundColor: Colors.red);
    }
  }
  Future fetchSavedRecipe() async{
    setBusy(true);
    var recipeResult = await firestoreService.getSaveRecipeOnceOff(currentUser.id);
    if(recipeResult is List<Recipe>){
      setBusy(false);
      _savedrecipe = recipeResult;
      notifyListeners();
    }else{
      setBusy(false);
      Fluttertoast.showToast(msg: recipeResult);
    }
  }
}