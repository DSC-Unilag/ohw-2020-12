import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipesaver/model/user.dart';

import '../constants.dart';
import 'base_model.dart';

class EditProfileViewModel extends BaseModel{
  String downloadurl;
  final StorageReference storageReference = FirebaseStorage.instance.ref().child("user images");
  Future<String> uploadPhoto(mfile) async {
    StorageUploadTask mstorageUploadTask =
    storageReference.child("post_${currentUser.id}.jpg").putFile(mfile);
    notifyListeners();
    StorageTaskSnapshot storageTaskSnapshot =
    await mstorageUploadTask.onComplete;
    String downloadURL = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }
  Future uploadData({@required User recipe, File mfile}) async{
    if(recipe.bio == ""){
      Fluttertoast.showToast(msg: "Recipe Title can't be empty", backgroundColor: Colors.red);
    }else {
      setBusy(true);
      if(mfile == null){
        recipe.imageurl = currentUser.imageurl;
      }else {
        recipe.imageurl = await uploadPhoto(mfile);
      }
      await updateUserData(recipe);
    }
  }
  Future updateUserData(User user) async{

    var result = await firestoreService.update(user);
    if(result is String){
      Fluttertoast.showToast(msg: result, backgroundColor: Colors.red);
    }else{
      Fluttertoast.showToast(msg: "Success", backgroundColor: Colors.red);
    }
    setBusy(false);
    navigationService.pop();
    navigationService.navigateTo(HomeViewRoute);
  }
}