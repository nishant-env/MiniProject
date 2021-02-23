import 'package:firebase_auth/firebase_auth.dart';

class FirebaseMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<UserCredential> _userCredential;

  Future<UserCredential> registerNewUser(String _email, String _password) {
    try {
      _userCredential = _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return _userCredential;
  }

  Future<UserCredential> signInExistingUser(String _email, String _password) {
    try {
      _userCredential =
          _auth.signInWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return _userCredential;
  }
}
