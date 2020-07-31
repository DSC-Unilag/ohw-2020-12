import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipesaver/model/recipe.dart';
import 'package:recipesaver/viewmodel/base_model.dart';
import 'package:uuid/uuid.dart';

import '../constants.dart';

class AddRecipeViewModel extends BaseModel{
  String downloadurl;
  final StorageReference storageReference = FirebaseStorage.instance.ref().child("Recipe images");
  String postid = Uuid().v4();

  Future<String> uploadPhoto(mfile) async {
    StorageUploadTask mstorageUploadTask =
    storageReference.child("post_$postid.jpg").putFile(mfile);
    notifyListeners();
    StorageTaskSnapshot storageTaskSnapshot =
    await mstorageUploadTask.onComplete;
    String downloadURL = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }
  Future uploadRecipe({@required Recipe recipe, File mfile}) async{
    if(recipe.title.isEmpty){
      Fluttertoast.showToast(msg: "Recipe Title can't be empty", backgroundColor: Colors.red);
    }else if(recipe.utensils.isEmpty){
      Fluttertoast.showToast(msg: "Recipe Utensils can't be empty", backgroundColor: Colors.red);
    }else if(recipe.ingredients.isEmpty){
      Fluttertoast.showToast(msg: "Recipe Ingredients can't be empty", backgroundColor: Colors.red);
    }else if(recipe.description.isEmpty){
      Fluttertoast.showToast(msg: "Recipe Description can't be empty", backgroundColor: Colors.red);
    }else {
      setBusy(true);
      recipe.url = await uploadPhoto(mfile);
      await addRecipe(recipe);
    }
  }

  Future addRecipe(Recipe recipe) async{
      var result  = await firestoreService.addRecipe(recipe);

      if(result is String){
        Fluttertoast.showToast(msg: result, backgroundColor: Colors.red);
      }else{
        setBusy(false);
        Fluttertoast.showToast(msg: "Recipe created", backgroundColor: Colors.red);
      }
      setBusy(false);
      navigationService.pop();
      navigationService.navigateTo(HomeViewRoute);
  }
}