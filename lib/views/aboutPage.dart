import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {

  final String _aboutText =  "This app is made by 3 people: \n Hayden, Kevin, Nicolas. \n For CSCI4100 Final Project";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('lib/assets/ico.png',
            width: 100, height: 100,),
            SizedBox(height: 15),
            Text("Pulsar - Your Social Media App",
              style: TextStyle(
                fontSize: 25
              ),
            ),
            SizedBox(height: 10),
            Text(_aboutText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17
            ),
            )
          ],
        )
      ),
    );
  }
}