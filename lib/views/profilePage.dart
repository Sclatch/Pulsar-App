import 'package:Pulsar/widgets/pulse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/posts.dart';
import '../model/users.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    final User user =
        context.watch<User>();
    //final PostsModel postsModel = PostsModel();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        elevation: 0,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.keyboard_backspace, color: Colors.white,),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 175,
            color: Colors.lightBlue,
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueGrey
              )
            ),
          ),
          SizedBox(height: 10),
          Text(user.username,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35
            )
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            height: 100,
            child: Text(user.username + user.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17
            ),
            )
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.60,
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return pulseCard(context, index, Post(), user);
              },
            )
          )
        ],
      ),
    );
  }
}