import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipesaver/constants.dart';
import 'package:recipesaver/model/recipe.dart';
import 'package:recipesaver/model/web_recipe.dart';
import 'package:recipesaver/viewmodel/base_model.dart';

class WebRecipeViewModel  extends BaseModel{

  List<Recipe> _recipe;
  List<Recipe> _savedrecipe;

  List<Recipe> get recipe => _recipe;
  List<Recipe> get savedrecipe => _savedrecipe;

  Future fetchRecipe() async{
    setBusy(true);
    var recipeResult = await firestoreService.getDiscoverRecipeOnceOff();
    if(recipeResult is List<Recipe>){
      setBusy(false);
      _recipe = recipeResult;
      notifyListeners();
    }else{
      setBusy(false);
      Fluttertoast.showToast(msg: recipeResult);
    }
  }
  Future signout() async{
    await authenticationService.signout();
    navigationService.pop();
    navigationService.navigateTo(StartUpVieRoute);
  }
}
