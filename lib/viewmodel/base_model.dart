import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipesaver/model/recipe.dart';
import 'package:recipesaver/model/user.dart';
import 'package:recipesaver/services/authentication_service.dart';
import 'package:recipesaver/services/firestore_service.dart';
import 'package:recipesaver/services/navigation_service.dart';

import '../locator.dart';

class BaseModel extends ChangeNotifier {

  final AuthenticationService authenticationService = locator<AuthenticationService>();
  NavigationService navigationService = locator<NavigationService>();
  FirestoreService firestoreService = locator<FirestoreService>();
  List<Recipe> _recipe;
  List<Recipe> _savedrecipe;
  List<Recipe> get recipe => _recipe;
  List<Recipe> get savedrecipe => _savedrecipe;

  User get currentUser => authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  Future fetchRecipe() async{
    setBusy(true);
    fetchRecipe();
    var recipeResult = await firestoreService.getRecipeuserOnceOff(currentUser.id);
    if(recipeResult is List<Recipe>){
      setBusy(false);
      _recipe = recipeResult;
      notifyListeners();
    }else{
      setBusy(false);
      Fluttertoast.showToast(msg: recipeResult);
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
