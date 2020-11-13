import 'package:flutter/material.dart';

class EditUserPage extends StatefulWidget {
  EditUserPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User Page"),
      ),
      body: Center(
        //THIS FUNCTION WILL BE COMPLETELY REDONE. FOR NOW IT WILL HAVE DATEPICKER FOR BIRTHDAY
        child: RaisedButton(
          child: Text("Date Picker"),
          onPressed: () => _datePicker(context)
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

  Future<void> _datePicker(BuildContext context) async {
    final DateTime current = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      confirmText: "Ok"
    );
  }
}