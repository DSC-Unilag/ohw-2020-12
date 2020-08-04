import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipesaver/model/user.dart';

import '../locator.dart';
import 'firestore_service.dart';
import 'navigation_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final GoogleSignIn _googlesignin = GoogleSignIn();
  final NavigationService _navigationService = locator<NavigationService>();

  User _currentUser;

  User get currentUser => _currentUser;

  Future<bool> signinwithGoogle() async{
    final GoogleSignInAccount googleSignInAccount = await _googlesignin.signIn();
    final GoogleSignInAuthentication googlesigninauthentication = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(accessToken: googlesigninauthentication.accessToken, idToken: googlesigninauthentication.idToken);
    await _firebaseAuth.signInWithCredential(credential);
    var user = await _firebaseAuth.currentUser();
    await populateCurrentUser(user);
    return user != null;
  }
  Future loginWithEmail(
    @required String email,
    @required String password,
  ) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await populateCurrentUser(user.user);
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signupWithEmail(
      {@required String email,
      @required String password,
      @required String fullname,
      @required String username,
      }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      //create a new user profile on firestore
      _currentUser = User(
          id: authResult.user.uid,
          email: email,
          username: username,
          fullname: fullname,
          password: password,);
      await _firestoreService.create(currentUser);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    await populateCurrentUser(user);
    return user != null;
  }

  Future populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }
  Future signout() async{
    var user = await _firebaseAuth.signOut();
    return user;
  }

}
