import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipesaver/constants.dart';
import 'package:recipesaver/locator.dart';
import 'package:recipesaver/services/authentication_service.dart';

import 'base_model.dart';
class LoginViewModel extends BaseModel {
  AuthenticationService _authenticationService = locator<AuthenticationService>();
  Future login({@required String email, @required String password}) async {
    print("Email is: $email");
    if (email == "") {
      Fluttertoast.showToast(
          msg: "Email field can't be empty", backgroundColor: Colors.red);
      return;
    } else if (password == "") {
      Fluttertoast.showToast(msg: "Password field can't be empty", backgroundColor: Colors.red);
      return;
    } else {
      setBusy(true);

      var result = await _authenticationService.loginWithEmail(email, password);
      setBusy(false);

      if (result is bool) {
        if (result) {
          navigationService.pop();
          navigationService.navigateTo(HomeViewRoute);
        } else {
          print("Login Failed");
          Fluttertoast.showToast(msg: "Login Failed, Please try again later");
        }
      } else {
        print(result);
        Fluttertoast.showToast(msg: result);
      }
    }
  }
  Future signInWithGoogle() async{
    await authenticationService.signinwithGoogle();
  }

}