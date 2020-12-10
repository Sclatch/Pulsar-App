import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/users.dart';
import '../model/usersModel.dart';
import '../model/userSettings.dart';
import '../model/userSettingsModel.dart';

import 'registerPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
          padding: const EdgeInsets.all(25),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Image.asset(
                  'lib/assets/scaffoldText.png',
                  width: 300,
                )),
                SizedBox(height: 25),
                TextField(
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: BorderSide(width: 0.75),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(10))),
                    icon: Icon(Icons.account_circle, size: 30),
                    hintText: "Username",
                    isDense: true,
                  ),
                  controller: userController,
                ),
                SizedBox(height: 10),
                TextField(
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: BorderSide(width: 0.75),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(10))),
                    icon: Icon(Icons.lock, size: 30),
                    hintText: "Password",
                    isDense: true,
                  ),
                  controller: passController,
                  obscureText: true,
                ),
                SizedBox(height: 25),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ButtonTheme(
                        height: 50,
                        minWidth: 150,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.5),
                          ),
                          child: Text("Register", textScaleFactor: 1.4,),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage()
                              )
                            );
                          },
                        ),
                      ),
                      ButtonTheme(
                        height: 50,
                        minWidth: 150,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.5),
                          ),
                          child: Text("Login", textScaleFactor: 1.4,),
                          onPressed: () {
                            checkLogin(userController.text, passController.text);
                          }
                        ),
                      ),
                      
                    ]
                  )
                )
              ])),
    );
  }

  Future<void> checkLogin(String name, String pass) async {
    UserModel usersModel = UserModel();

    QuerySnapshot snapshot = await usersModel.checkLogin(name, pass);

    List users = snapshot.docs;

    if (users.isEmpty) {
      print("USER NOT FOUND");
    } else {
      DocumentSnapshot userDocument = users[0];

      User user =
          User.fromMap(userDocument.data(), reference: userDocument.reference);

      if (user.password != pass) {
        print("INCORRECT PASSWORD");
      } else {
        print("LOGGED IN");
        updateUserSettings(user.username);
        Future.delayed(Duration(milliseconds: 500)).then((value) => Navigator.pop(context));
      }
    }
  }

  Future<void> updateUserSettings(String login) async {
    final model = UserSettingsModel();
    UserSettings userSettings;

    var _temp = await model.getUserSettingsWithId(1);

    if (_temp == null) {
      userSettings = UserSettings(fontSize: 14, showImages: true, login: null);
    } else {
      userSettings = _temp;
    }

    userSettings.login = login;

    userSettings.setID(1);

    model.updateUserSettings(userSettings);

    print("Update called: $userSettings");
  }
}
