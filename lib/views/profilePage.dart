import 'package:Pulsar/views/editUser_page.dart';
import 'package:Pulsar/widgets/pulse.dart';
import 'package:flutter/material.dart';
import '../model/postsModel.dart';
import '../model/posts.dart';
import '../model/users.dart';
import 'package:Pulsar/model/posts.dart';
import 'package:Pulsar/model/postsModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title, this.user}) : super(key: key);
  final User user;
  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState(user: user);
}

class _ProfilePageState extends State<ProfilePage> {
  final User user;
  String username;
  String description;
  NetworkImage pfp;
  NetworkImage background;

  _ProfilePageState({this.user}) {
    if (user != null) {
      username = user.username;
      description = user.description;
      if(user.image != null){
        pfp = NetworkImage(user.image);
      }
      if(user.background != null){
        background = NetworkImage(user.background);
      }
      
    } else {
      username = "Anonymous";
      description = "Anonymous User";
    }
  }

  @override
  Widget build(BuildContext context) {
    PostsModel postsModel = PostsModel();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        elevation: 0,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.keyboard_backspace,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              image: DecorationImage(
                image: background,
                fit: BoxFit.cover
              )
            ),
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueGrey,
                backgroundImage: pfp
              )
            ),
          ),
          SizedBox(height: 10),
          Text(username,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 35)),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              height: 100,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              )),
          Container(
            height: 25,
            child: RaisedButton(
              child: Text("Edit Profile"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditUserPage(user: this.user)));
              }
            ),
          ),
          Expanded(
              //padding: const EdgeInsets.symmetric(horizontal: 5),
              //width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height * 0.60,
              child: FutureBuilder(
                  //This is how you search for a user
                  future: postsModel.searchPostUser(username),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List posts = snapshot.data.docs;
                      return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (BuildContext context, int index) {
                            //This is just to show the indexed post
                            DocumentSnapshot postDocument = posts[index];

                            //This takes a post from the database and makes it an instance of post
                            final post = Post.fromMap(postDocument.data(),
                                reference: postDocument.reference);
                            //print(post);

                            return PulseCard(post: post, user: user);
                          }
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }))
        ],
      ),
    );
  }
}
