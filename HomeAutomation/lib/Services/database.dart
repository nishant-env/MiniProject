import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:HomeAutomation/homepage.dart';

class FirebaseReal {
  User _user = FirebaseAuth.instance.currentUser;
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();
  bool switchStatus;

  void getSwitchStatus(Function callback) {
    callback();
  }

  void updateStatus() {
    id.update({
      'room': 'living_room',
      'switch_status': switchStatus,
      'user_id': _user.uid,
    });
  }

  Future<DataSnapshot> getData() async {
    DataSnapshot data = await _databaseReference
        .child('rooms')
        .orderByChild('user_id')
        .equalTo(_user.uid)
        .once();
    return data;
  }
}
