import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/users.dart';
import '../model/usersModel.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passController = TextEditingController();

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
              ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkLogin(userController.text, passController.text);
        },
        tooltip: 'Login',
        child: Icon(Icons.input),
      ),
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
      }
    }
  }
}
