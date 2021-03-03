import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'Services/auth.dart';
import 'loginScreen.dart';
import 'homepage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool checkingifLogged;
  FirebaseMethods _auth = FirebaseMethods();
  void initState() {
    super.initState();
    isLoggedInChecker();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => checkingifLogged ? HomePage() : LoginPage(),
          ));
    });
  }

  isLoggedInChecker() {
    var tempLoginChecker = _auth.checkingIfLogged();
    setState(() {
      checkingifLogged = tempLoginChecker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          color: Colors.blueAccent,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 75.0,
                      backgroundColor: Colors.white,
                      child: Text('HomeAutomation',
                          style: TextStyle(fontSize: 15.0)),
                    ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Loading(
                    indicator: BallPulseIndicator(),
                    size: 100.0,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text('Created By:'),
                  SizedBox(height: 15),
                  Text('Bikash Kunwar'),
                  Text('Nishant Neupane'),
                  Text('Prakash Sapkota'),
                  Text('Uttam Chhetri'),
                ],
              ),
            )
          ],
        )
      ]),
    );
  }
}
