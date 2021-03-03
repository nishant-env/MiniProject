import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Services/auth.dart';
import 'Services/database.dart';

Map<String, dynamic> dataFromDataBase = {
  'room': '',
  'switch_status': '',
  'user_id': ''
};
DatabaseReference id;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authServices = FirebaseMethods();

  final _databaseServices = FirebaseReal();
  DataSnapshot returnData;
  @override
  void initState() {
    super.initState();
    _databaseServices.getData().then((value1) {
      print(value1.value);
      if (value1 != null) {
        setState(() {
          returnData = value1;
        });
        value1.value.forEach((key, value2) {
          id = FirebaseDatabase.instance.reference().child('rooms').child(key);
          value2.forEach((key, value) {
            setState(() {
              dataFromDataBase[key] = value;
              print(dataFromDataBase);
            });
          });
        });
        _databaseServices.getSwitchStatus(() {
          setState(() {
            _databaseServices.switchStatus = dataFromDataBase['switch_status'];
          });
        });
      }
    });
  }

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
      body: Container(
          child: returnData.value != null
              ? Center(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _databaseServices.switchStatus =
                            !_databaseServices.switchStatus;
                        _databaseServices.updateStatus();
                      });
                    },
                    child: _databaseServices.switchStatus
                        ? Text('Turn OFF')
                        : Text('Turn ON'),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                    color: Colors.green,
                  ),
                )
              : Container()),
    );
  }
}
