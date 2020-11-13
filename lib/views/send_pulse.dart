import 'package:flutter/material.dart';

class SendPulse extends StatefulWidget {
  SendPulse({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SendPulseState createState() => _SendPulseState();
}

class _SendPulseState extends State<SendPulse> {

  String pulse = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.blueGrey
          ),
          SizedBox(height: 10),
          Text(
            "Send a Pulse",
            textScaleFactor: 1.5
          ),
          SizedBox(height: 20),
          TextField(
            style: TextStyle(
              fontSize: 25.0,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 0.75),
              ),
              hintText: "What's on your mind?",
              isDense: true,
            ),
            maxLines: 4,
            //PLEASE WRITE THE FUNCTION HERE TO RETURN THE VALUE
            onChanged: (value) {},
          ),
          TextField(
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 0.75),
              ),
              hintText: "Link to your Image",
              isDense: true,
            ),
            maxLines: 1,
            //PLEASE WRITE THE FUNCTION HERE FOR IMAGE
            onChanged: (value) {},
          ),

          //SEND BUTTON
          Container(
            padding: const EdgeInsets.only(top: 10),
            width: 325,
            child: RaisedButton(
              child: Text(
                "Send",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                print("Send something");
                final snackBar = SnackBar(
                  content: Text("Pulse Sent!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17
                    ),
                  ),
                  backgroundColor: Colors.grey[900],
                );

                Scaffold.of(context).showSnackBar(snackBar);
              },
            )
          ),
        ],
      )
    );
  }
}