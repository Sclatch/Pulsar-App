import 'package:Pulsar/views/aboutPage.dart';
import 'package:flutter/material.dart';

import '../views/profilePage.dart';
import '../views/loginPage.dart';
import '../model/userSettings.dart';
import '../model/userSettingsModel.dart';

Widget drawerMenu(BuildContext context) {
  Future<void> _updateUserSettings() async {
    var userSettings =
        await Navigator.pushNamed(context, '/updateUserSettings');

    UserSettings newUserSettings = userSettings;

    newUserSettings.setID(1);

    final _model = UserSettingsModel();

    _model.updateUserSettings(newUserSettings);

    print("Update called: $newUserSettings");
  }

  return Drawer(
      child: Container(
          child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      //HEADER DRAWER. USER PROFILE
      Container(
        padding: EdgeInsets.only(left: 15, bottom: 15),
        height: 175,
        width: 500,
        color: Colors.lightBlue,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(radius: 35.0, backgroundColor: Colors.blueGrey[700]),
              SizedBox(width: 12),
              Text(
                "Anonymous",
                textScaleFactor: 1.5,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ]),
      ),
      SizedBox(height: 15),
      //PROFILE BUTTON
      FlatButton(
        splashColor: Colors.lightBlue,
        onPressed: () {
          Navigator.push(
              context,
              PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) {
                    return Center(
                        child: ProfilePage(title: 'Profile', user: null));
                  },
                  transitionsBuilder:
                      (___, Animation<double> animation, ____, Widget child) {
                    return child;
                  }));
        },
        child: Container(
            height: 60,
            child: Row(children: <Widget>[
              Icon(Icons.person, size: 30.0),
              SizedBox(width: 15.0),
              Text(
                "Profile",
                textScaleFactor: 1.30,
              )
            ])),
      ),
      //LOG IN BUTTON
      FlatButton(
        splashColor: Colors.lightBlue,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Container(
            height: 60,
            child: Row(children: <Widget>[
              Icon(Icons.input, size: 30.0),
              SizedBox(width: 15.0),
              Text(
                "Login",
                textScaleFactor: 1.30,
              )
            ])),
      ),
      //SETTINGS BUTTON
      FlatButton(
        splashColor: Colors.lightBlue,
        onPressed: () {
          _updateUserSettings();
        },
        child: Container(
            height: 60,
            child: Row(children: <Widget>[
              Icon(Icons.settings, size: 30.0),
              SizedBox(width: 15.0),
              Text(
                "Settings",
                textScaleFactor: 1.30,
              )
            ])),
      ),
      //ABOUT BUTTON
      FlatButton(
        splashColor: Colors.lightBlue,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AboutPage()));
        },
        child: Container(
            height: 60,
            child: Row(children: <Widget>[
              Icon(Icons.error, size: 30.0),
              SizedBox(width: 15.0),
              Text(
                "About",
                textScaleFactor: 1.30,
              )
            ])),
      ),
    ],
  )));
}
