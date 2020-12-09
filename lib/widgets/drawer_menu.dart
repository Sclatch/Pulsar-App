import 'package:Pulsar/model/usersModel.dart';
import 'package:Pulsar/views/aboutPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../views/profilePage.dart';
import '../views/loginPage.dart';
import '../model/userSettings.dart';
import '../model/userSettingsModel.dart';
import '../model/users.dart';

Widget drawerMenu(BuildContext context) {
  final UserModel usersModel = UserModel();

  return FutureBuilder(
      future: checkUserSettings(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserSettings userSettings = snapshot.data;

          return FutureBuilder(
              future: usersModel.searchUser(userSettings.login),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  User user;

                  if (snapshot.data.docs.isEmpty) {
                    user = User(
                      username: "Anonymous",
                      image: "https://i.imgur.com/dnQFN6c.png",
                      background: "https://i.imgur.com/dnQFN6c.png",
                    );
                  } else {
                    DocumentSnapshot userDocument = snapshot.data.docs[0];

                    user = User.fromMap(userDocument.data(),
                        reference: userDocument.reference);
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
                              CircleAvatar(
                                radius: 35.0,
                                backgroundColor: Colors.blueGrey[700],
                                backgroundImage: NetworkImage(user.image),
                              ),
                              SizedBox(width: 12),
                              Text(
                                user.username,
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
                                        child: ProfilePage(
                                            title: 'Profile', user: null));
                                  },
                                  transitionsBuilder: (___,
                                      Animation<double> animation,
                                      ____,
                                      Widget child) {
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
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
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
                          _updateUserSettings(context);
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
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutPage()));
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
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}

Future<void> _updateUserSettings(BuildContext context) async {
  final userSettingsModel = UserSettingsModel();
  var userSettings = await Navigator.pushNamed(context, '/updateUserSettings');

  UserSettings newUserSettings = userSettings;

  newUserSettings.setID(1);

  userSettingsModel.updateUserSettings(newUserSettings);

  print("Update called: $newUserSettings");
}

Future<UserSettings> checkUserSettings(BuildContext context) async {
  final userSettingsModel = UserSettingsModel();
  UserSettings userSettings;

  var _temp = await userSettingsModel.getUserSettingsWithId(1);

  if (_temp == null) {
    userSettings = UserSettings(fontSize: 14, showImages: true, login: null);
  } else {
    userSettings = _temp;
  }

  userSettings.setID(1);

  userSettingsModel.updateUserSettings(userSettings);

  return userSettings;
}
