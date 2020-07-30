import 'package:flutter/cupertino.dart';
import 'package:recipesaver/constants.dart';
import 'package:recipesaver/services/authentication_service.dart';
import 'package:recipesaver/viewmodel/base_model.dart';

import '../locator.dart';

class SignUpVIewModel extends BaseModel{
  AuthenticationService _authenticationService = locator<AuthenticationService>();

  Future SignUpWithEmailAndPassword({@required String email, @required String password, @required String fullname, @required String username}) async{
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
      }
    } else {
      setBusy(false);
      print(result);
//      await dialogService.showDialog(
//        lottie: "lottie/warning.json",
//        title: "Sign Up Failure",
//        description: result,
//      );
    }
  }
}