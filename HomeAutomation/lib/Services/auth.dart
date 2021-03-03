import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirebaseMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential _userCredential;

  bool checkingIfLogged() {
    User user = _auth.currentUser;
    return user != null ? true : false;
  }

  Future<UserCredential> registerNewUser(
      String _email, String _password, BuildContext context) async {
    try {
      _userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar("Weak Password");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar("Email already registered");
      }
    } catch (e) {
      print(e);
    }
    return _userCredential;
  }

  Future<UserCredential> signInExistingUser(
      String _email, String _password, BuildContext context) async {
    try {
      _userCredential = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
    } on PlatformException catch (e) {
      showSnackBar(e.message);
    } catch (e) {
      showSnackBar(e.message);
    }
    return _userCredential;
  }

  signOut() async {
    await _auth.signOut();
  }
}

GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
showSnackBar(String text) {
  scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Text(text),
    duration: Duration(seconds: 1),
  ));
}
