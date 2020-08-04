import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:recipesaver/model/recipe.dart';
import 'package:recipesaver/model/user.dart';
class FirestoreService{
  final CollectionReference _usersCollectionReference = Firestore.instance.collection("users");
  final CollectionReference _recipeCollectionReference = Firestore.instance.collection("recipe");
  final CollectionReference _discoverrecipeCollectionReference = Firestore.instance.collection("discoverrecipe");
  final CollectionReference _saveCollectionReference = Firestore.instance.collection("save");

  Future create(User user) async{
    try{
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    }catch(e){
      return e.message;
    }
  }
  Future update(User user) async{
    try{
      await _usersCollectionReference.document(user.id).updateData(user.toJson());
    }catch(e){
      return e.message;
    }
  }

  Future getUser(String uid) async{
    try{
      var userData = await _usersCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    }catch(e){
      return e.message;
    }
  }

  Future addRecipe(Recipe recipe) async{
    try{
      await _recipeCollectionReference.document(recipe.postid).setData(recipe.toJson());
    }catch(e){
      return e.message;
    }
  }
  Future addDiscoverRecipe(Recipe recipe) async{
    try{
      await _discoverrecipeCollectionReference.document(recipe.postid).setData(recipe.toJson());
    }catch(e){
      return e.message;
    }
  }
  Future saveRecipe(Recipe recipe, String uid, String postid) async{
    try{
      await _saveCollectionReference.document(uid).collection("myrecipe").document(postid).setData(recipe.toJson());
    }catch(e){
      return e.message;
    }
  }

  Future getRecipeOnceOff() async{
    try{
      var postDocumentSnapshot = await _recipeCollectionReference.orderBy("time").getDocuments();
      if(postDocumentSnapshot.documents.isNotEmpty){
        return postDocumentSnapshot.documents.map((snapshot)=> Recipe.fromData(snapshot.data)).toList();
      }
    }catch(e){
      if(e is PlatformException){
        return e.message;
      }
      return e.toString();
    }
  }
  Future getDiscoverRecipeOnceOff() async{
    try{
      var postDocumentSnapshot = await _discoverrecipeCollectionReference.orderBy("time").getDocuments();
      if(postDocumentSnapshot.documents.isNotEmpty){
        return postDocumentSnapshot.documents.map((snapshot)=> Recipe.fromData(snapshot.data)).toList();
      }
    }catch(e){
      if(e is PlatformException){
        return e.message;
      }
      return e.toString();
    }
  }
  Future getRecipeuserOnceOff(uid) async{
    try{
      var postDocumentSnapshot = await _recipeCollectionReference.orderBy("time").getDocuments();
      if(postDocumentSnapshot.documents.isNotEmpty){
        return postDocumentSnapshot.documents.map((snapshot)=> Recipe.fromData(snapshot.data)).toList();
      }
    }catch(e){
      if(e is PlatformException){
        return e.message;
      }
      return e.toString();
    }
  }
  Future getSaveRecipeOnceOff(String uid) async{
    try{
      var postDocumentSnapshot = await _saveCollectionReference.document(uid).collection("myrecipe").orderBy("time").getDocuments();
      if(postDocumentSnapshot.documents.isNotEmpty){
        return postDocumentSnapshot.documents.map((snapshot)=> Recipe.fromData(snapshot.data)).toList();
      }
    }catch(e){
      if(e is PlatformException){
        return e.message;
      }
      return e.toString();
    }
  }

}