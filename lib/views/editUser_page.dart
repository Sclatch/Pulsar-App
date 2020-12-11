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
  final UserModel usersModel = UserModel();
  DateTime birthday;
  NetworkImage pfp;
  NetworkImage background;
  String pfpLink;
  String backgroundLink;
  String description;

  _EditUserPageState({this.user});

  @override
  void initState() {
    super.initState();

    if (user != null) {
      birthday = user.birthday.toDate();
      description = user.description;
      if (user.background != null) {
        background = NetworkImage(user.background);
        backgroundLink = user.background;
      }
      if (user.image != null) {
        pfp = NetworkImage(user.image);
        pfpLink = user.image;
      }
    } else {
      birthday = DateTime.now();
      pfp = null;
      description = null;
      background = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User Page"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.1,
                    backgroundColor: Colors.blueGrey,
                    backgroundImage: pfp,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      initialValue: pfpLink,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.10),
                        ),
                        hintText: "Link to your profile picture",
                        isDense: true,
                      ),
                      maxLines: 1,
                      onChanged: (value) {
                        pfpLink = value;
                      },
                    ),
                  )
                ],
              )),
              SizedBox(height: 15),
              TextFormField(
                style: TextStyle(
                  fontSize: 25.0,
                ),
                initialValue: description,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.75),
                  ),
                  hintText: "Tell us about yourself!",
                  isDense: true,
                ),
                maxLines: 4,
                onChanged: (value) {
                  description = value;
                },
              ),
              SizedBox(height: 15),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.60,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.75),
                          borderRadius:
                              BorderRadius.all(const Radius.circular(5))),
                      child: Text(
                        "${birthday.year} / ${birthday.month} / ${birthday.day}",
                        textScaleFactor: 1.4,
                      ),
                    ),
                    RaisedButton(
                      child: Text(
                        "Date Picker",
                        textScaleFactor: 1.2,
                      ),
                      onPressed: () {
                        _datePicker(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: 175,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  image: DecorationImage(image: background, fit: BoxFit.cover),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width * 0.90,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  initialValue: backgroundLink,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.10),
                    ),
                    hintText: "Link to your background",
                    isDense: true,
                  ),
                  maxLines: 1,
                  onChanged: (value) {
                    backgroundLink = value;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                        child: Icon(Icons.clear),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    RaisedButton(
                        child: Icon(Icons.check),
                        onPressed: () {
                          Timestamp time = user.dateToTime(birthday);
                          user.birthday = time;
                          user.description = description;
                          user.image = pfpLink;
                          user.background = backgroundLink;
                          usersModel.updateUser(user);

                          Navigator.pop(context);
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _datePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: birthday,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        confirmText: "Ok");

    if (picked != null) {
      setState(() {
        birthday = picked;
      });
    }
  }
}
