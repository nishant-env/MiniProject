import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String _userEmail;
  @override
  HomePage(this._userEmail);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeAutomation'),
      ),
      body: Text(_userEmail),
    );
  }
}
