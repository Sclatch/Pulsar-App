import 'package:Pulsar/widgets/pulse.dart';
import 'package:flutter/material.dart';
import '../model/postsModel.dart';
import '../model/posts.dart';
import '../model/users.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title, this.user}) : super(key: key);
  final User user;
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState(user: user);
}

class _ProfilePageState extends State<ProfilePage> {
  final User user;

  _ProfilePageState({this.user}) {
    print(user.username + "'s profile has been opened");
  }

  @override
  Widget build(BuildContext context) {
    PostsModel postsModel;
    //postsModel.getAllPosts();
    

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
            child: Text(user.description,
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