import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'Services/auth.dart';
import 'Services/database.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

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
    fetchData();
  }

  DataSnapshot value1;
  fetchData() async {
    value1 = await _databaseServices.getData();
    if (value1 != null) {
      setState(() {
        returnData = value1;
      });
      value1.value.forEach((key, value2) {
        id = FirebaseDatabase.instance.reference().child('rooms').child(key);
        value2.forEach((key, value) {
          setState(() {
            dataFromDataBase[key] = value;
          });
        });
      });
      _databaseServices.getSwitchStatus(() {
        setState(() {
          _databaseServices.switchStatus = dataFromDataBase['switch_status'];
        });
      });
    }
  }

  @override
  // HomePage(this._userEmail);
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('HomeAutomation'),
        centerTitle: true,
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
      body: value1 == null
          ? Center(
              child: Loading(
                indicator: BallPulseIndicator(),
                size: 100.0,
                color: Colors.black,
              ),
            )
          : Container(
              child: returnData.value != null
                  ? Center(
                      child: RaisedButton(
                        elevation: 20.0,
                        onPressed: () {
                          setState(() {
                            _databaseServices.switchStatus =
                                !_databaseServices.switchStatus;
                            _databaseServices.updateStatus();
                            _databaseServices.switchStatus
                                ? showSnackBar('Turning ON')
                                : showSnackBar('Turning OFF');
                          });
                        },
                        child: _databaseServices.switchStatus
                            ? Text('Turn OFF')
                            : Text('Turn ON'),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                        color: _databaseServices.switchStatus
                            ? Colors.green
                            : Colors.red,
                      ),
                    )
                  : Container()),
    );
  }
}
