import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirebaseMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<UserCredential> _userCredential;

  Future<UserCredential> registerNewUser(
      String _email, String _password, BuildContext context) {
    try {
      _userCredential = _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "Weak Password");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "Email already registered");
      }
    } catch (e) {
      print(e);
    }
    return _userCredential;
  }

  Future<UserCredential> signInExistingUser(
      String _email, String _password, BuildContext context) {
    try {
      _userCredential =
          _auth.signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "User Not Registered");
        ;
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "Wrong Password");
        print('Wrong pwd');
      }
    }
    return _userCredential;
  }

  signOut() async {
    await _auth.signOut();
  }
}

showSnackBar(BuildContext context, String text) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}
