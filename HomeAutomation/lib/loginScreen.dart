import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Services/auth.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserCredential _userData;
  final _authServices = FirebaseMethods();
  final _formKey = new GlobalKey<FormState>();
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (String data) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(data)
                          ? null
                          : "Please enter valid email";
                    },
                    decoration: InputDecoration(
                        labelText: "Enter Email",
                        icon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (String data) {
                      return data.length <= 5
                          ? 'Password should be atleast 6 digits'
                          : null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Enter Password',
                        icon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _authServices
                            .signInExistingUser(
                                _emailController.text, _passwordController.text)
                            .then((userData) {
                          _userData = userData;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(userData.user.email)),
                              (route) => false);
                        });
                      }
                    },
                    child: Text("Login"),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                    color: Colors.blue,
                  ),
                  Text('Still Not A Member?'),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/registerScreen', (route) => false);
                    },
                    child: Text("Register"),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
