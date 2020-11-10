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
            maxLines: 6,
            //PLEASE WRITE THE FUNCTION HERE TO RETURN THE VALUE
            onChanged: (value) {},
          ),
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
              },
            )
          ),
        ],
      )
    );
  }
}