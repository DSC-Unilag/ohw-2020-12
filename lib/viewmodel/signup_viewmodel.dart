import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipesaver/constants.dart';
import 'package:recipesaver/services/authentication_service.dart';
import 'package:recipesaver/viewmodel/base_model.dart';

import '../locator.dart';

class SignUpVIewModel extends BaseModel{
  AuthenticationService _authenticationService = locator<AuthenticationService>();

  Future SignUpWithEmailAndPassword({@required String email, @required String password, @required String fullname, @required String username}) async{
    if(email == ""){
      Fluttertoast.showToast(msg: "Email field can't be empty", backgroundColor: Colors.red);
      return;
    }else if(password.isEmpty){
      Fluttertoast.showToast(msg: "Password field can't be empty", backgroundColor: Colors.red);
      return;
    }else if(fullname.isEmpty){
      Fluttertoast.showToast(msg: "Fullname field can't be empty", backgroundColor: Colors.red);
      return;
    }else if(username.isEmpty){
      Fluttertoast.showToast(msg: "username field can't be empty", backgroundColor: Colors.red);
      return;
    }
    setBusy(true);

    var result = await _authenticationService.signupWithEmail(email: email, password: password, fullname: fullname, username: username);


    if (result is bool) {
      if (result) {
        setBusy(false);
        navigationService.pop();
        navigationService.navigateTo(HomeViewRoute);
      } else {
        setBusy(false);
        print("Not Available");
        Fluttertoast.showToast(msg: "Sign Up Failed", backgroundColor: Colors.red);
      }
    } else {
      setBusy(false);
      print(result);
      Fluttertoast.showToast(msg: result, backgroundColor: Colors.red);
    }
  }
}