import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/users.dart';
import '../model/usersModel.dart';

class EditUserPage extends StatefulWidget {
  EditUserPage({Key key, this.title, this.user}) : super(key: key);

  final String title;
  final User user;

  @override
  _EditUserPageState createState() => _EditUserPageState(user: user);
}

class _EditUserPageState extends State<EditUserPage> {
  final User user;

  _EditUserPageState({this.user});

  @override
  Widget build(BuildContext context) {
    final UserModel usersModel = UserModel();

    print('\n\n\n\n\n\n$user');

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User Page"),
      ),
      body: Center(
        //THIS FUNCTION WILL BE COMPLETELY REDONE. FOR NOW IT WILL HAVE DATEPICKER FOR BIRTHDAY
        child: RaisedButton(
          child: Text("Date Picker"),
          onPressed: () {
            _datePicker(context).then((value) {
              Timestamp time = user.dateToTime(value);
              print(user);
              user.birthday = time;
              print(user);
              usersModel.updateUser(user);
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Save Profile');
        },
        tooltip: 'Increment',
        child: Icon(Icons.save),
      ),
    );
  }

  Future<DateTime> _datePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        confirmText: "Ok");

    return picked;
  }
}
