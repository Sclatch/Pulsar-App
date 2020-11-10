import 'package:flutter/material.dart';
import '../main.dart';

Widget drawerMenu() {
  return Drawer(
    child: Container(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15, bottom: 15),
            height: 150,
            width: 500,
            color: Colors.lightBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 35.0,
                  backgroundColor: Colors.blueGrey[700]
                ),
                SizedBox(width: 12),
                Text(
                  "username",
                  textScaleFactor: 1.5,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ]
            ),
          ),
          FlatButton(
            splashColor: Colors.lightBlue,
            onPressed: () {print("POP TO PROFILE");},
            child: Container(
              height: 65,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 30.0
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    "Profile",
                    textScaleFactor: 1.30,
                  )
                ]
              )
            ),
          ),
          FlatButton(
            splashColor: Colors.lightBlue,
            onPressed: () {print("POP TO MENU");},
            child: Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    size: 30.0
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    "Settings",
                    textScaleFactor: 1.30,
                  )
                ]
              )
            ),
          ),
        ],
      )
    )
  );
}