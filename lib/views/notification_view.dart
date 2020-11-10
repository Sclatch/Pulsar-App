import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: 6,
        separatorBuilder: (BuildContext context, int index) => Divider(height: 10),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.grey[900],
            child: GestureDetector (
              child: ListTile(
                //AVATAR
                leading: CircleAvatar(
                  radius: 35.0,
                  backgroundColor: Colors.blueGrey
                ),
                //MORE OPTIONS
                trailing: Material(
                  color: Colors.transparent, //DO NOT REMOVE THIS. OTHERWISE THE SPLASH WONT SHOW
                    child: IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      size: 20,
                    ),
                    splashRadius: 15,
                    onPressed: () {
                      //ADD DELETE FUNCTION HERE
                    }
                  )
                ),
                //TEXTS
                title: Text(
                  "Username",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                subtitle: Text("Notification Text")
              ),
              onTap: () {
                print("Expand which pulse");
                //EXPAND FUNCTION HERE
              },
            ),
          );
        },
      )
    );
  }
}