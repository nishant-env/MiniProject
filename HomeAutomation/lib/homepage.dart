import 'package:flutter/material.dart';
import 'Services/auth.dart';

class HomePage extends StatelessWidget {
  final _authServices = FirebaseMethods();
  // final String _userEmail;
  @override
  // HomePage(this._userEmail);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeAutomation'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _authServices.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/loginScreen', (route) => false);
            },
          )
        ],
      ),
      body: Text('Logged IN'),
    );
  }
}
