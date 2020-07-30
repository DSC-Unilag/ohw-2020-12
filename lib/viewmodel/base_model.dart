import 'package:flutter/widgets.dart';
import 'package:recipesaver/model/user.dart';
import 'package:recipesaver/services/authentication_service.dart';
import 'package:recipesaver/services/firestore_service.dart';
import 'package:recipesaver/services/navigation_service.dart';

import '../locator.dart';

class BaseModel extends ChangeNotifier {

  final AuthenticationService authenticationService = locator<AuthenticationService>();
  NavigationService navigationService = locator<NavigationService>();
  FirestoreService firestoreService = locator<FirestoreService>();

  User get currentUser => authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
