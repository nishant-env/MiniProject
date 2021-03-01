import 'package:HomeAutomation/loginScreen.dart';
import 'package:HomeAutomation/registerPage.dart';
import 'package:flutter/material.dart';
import 'splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splashScreen',
      routes: <String, WidgetBuilder>{
        '/loginScreen': (context) => LoginPage(),
        '/registerScreen': (context) => RegisterPage(),
        '/splashScreen': (context) => SplashPage(),
      },
    );
  }
}
