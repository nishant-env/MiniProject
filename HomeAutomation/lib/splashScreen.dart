import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

import 'loginScreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Home Automation'),
              SizedBox(height: 25),
              Loading(
                indicator: BallPulseIndicator(),
                size: 100.0,
                color: Colors.blue,
              ),
              SizedBox(height: 25),
              Text('Created By:'),
              SizedBox(height: 15),
              Text('Bikash Kunwar'),
              Text('Nishant Neupane'),
              Text('Prakash Sapkota'),
              Text('Uttam Chhetri'),
            ],
          ),
        ),
      ),
    );
  }
}
