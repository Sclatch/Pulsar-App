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
  NetworkImage pfp;
  NetworkImage background;

  return FutureBuilder(
      future: checkUserSettings(),
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
                      image: "https://i.imgur.com/wvLOZSn.png",
                      background: "https://i.imgur.com/t0ZHBWX.jpg",
                    );
                  } else {
                    DocumentSnapshot userDocument = snapshot.data.docs[0];

                  user = User.fromMap(userDocument.data(),
                    reference: userDocument.reference);
                  }

                  if(user.background != null){
                    background = NetworkImage(user.background);
                  }
                  if(user.image != null) {
                    pfp = NetworkImage(user.image);
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
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          image: DecorationImage(
                            image: background,
                            fit: BoxFit.cover
                          )
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundColor: Colors.blueGrey[700],
                                backgroundImage: pfp,
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
                            MaterialPageRoute(builder: (context) => ProfilePage(user: user))
                          );
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
                              builder: (context) => LoginPage()
                            )
                          );
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
                      //LOG OUT BUTTON
                      FlatButton(
                        splashColor: Colors.lightBlue,
                        onPressed: () {
                          _logoutFunction(context);
                        },
                        child: Container(
                            height: 60,
                            child: Row(children: <Widget>[
                              Icon(Icons.settings_power, size: 30.0),
                              SizedBox(width: 15.0),
                              Text(
                                "Log Out",
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
                            ]
                          )
                        ),
                      ),
                      //ABOUT BUTTON
                      FlatButton(
                        splashColor: Colors.lightBlue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutPage()
                            )
                          );
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

Future<UserSettings> checkUserSettings() async {
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

void _logoutFunction(BuildContext context) async{
  bool confirmation = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Log Out?"),
        content: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Icon(
                  Icons.sentiment_very_dissatisfied,
                  size: 40
                )
              ),
              Flexible(
                flex: 3,
                child: Text(
                  "Once you log out, you have to log-in back again. There will be less star in space",
                  textScaleFactor: 1.1,
                )
              )
              
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.lightBlueAccent,
            onPressed: (){
              Navigator.of(context).pop(false);
            },
            child: Text("Cancel")
          ),
          FlatButton(
            textColor: Colors.lightBlueAccent,
            onPressed: (){
              Navigator.of(context).pop(true);
            },
            child: Text("Confirm")
          )
        ],
      );
    }
  );
  if(confirmation == null) {
    confirmation = false;
  }
  if(confirmation == true) {
    final model = UserSettingsModel();
    UserSettings userSettings;

    userSettings = UserSettings(fontSize: 14, showImages: true, login: null);

    userSettings.setID(1);

    model.updateUserSettings(userSettings);

    print("Update called: $userSettings");
  }
}
