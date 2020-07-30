import 'package:flutter/material.dart';
import 'package:recipesaver/constants.dart';
import 'package:recipesaver/locator.dart';
import 'package:recipesaver/services/authentication_service.dart';

import 'base_model.dart';
class LoginViewModel extends BaseModel {
  AuthenticationService _authenticationService = locator<AuthenticationService>();
  Future login({@required String email, @required String password}) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(email, password);
    setBusy(false);

    if (result is bool) {
      if (result) {
        navigationService.pop();
        navigationService.navigateTo(HomeViewRoute);
      } else {
//        await dialogService.showDialog(
//          lottie: "lottie/error.json",
//            title: "Login Failure",
//            description: "General Login Failure. Please try again later"
//        );
      print("Login Failed");
      }
    } else {
//      await dialogService.showDialog(
//        lottie: "lottie/error.json",
//        title: "Sign Up Failure",
//        description: result,
//      );
    print(result);
    }
  }

//  void navigateToSignUp() {
//    _navigationService.navigateTo(SignUpViewRoute);
//  }
}