import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String username;
  String password;
  String conPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register a New User"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Image.asset(
                'lib/assets/scaffoldText.png',
                width: 300,
              )),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width* 0.80,
                child: Text(
                  "Your chance to shine like a STAR starts here!",
                  textScaleFactor: 1.55,
                  textAlign: TextAlign.center,
                  
                )
              ),
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
                onChanged: (value) {
                  username = value;
                },
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
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
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
                  hintText: "Confirm Password",
                  isDense: true,
                ),
                obscureText: true,
                onChanged: (value) {
                  conPassword = value;
                },
              ),
              SizedBox(height: 25),
              ButtonTheme(
                height: 50,
                minWidth: 150,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                  child: Text("Register", textScaleFactor: 1.4,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ]
          )
        )
      ),
    );
  }
}
