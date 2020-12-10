import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/posts.dart';
import '../model/userSettings.dart';
import '../model/usersModel.dart';
import '../model/users.dart';
import '../model/comments.dart';
import '../model/commentsModel.dart';
import 'send_pulse.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key key, this.post}) : super(key: key);

  Post post;

  @override
  _CommentPageState createState() => _CommentPageState(post: post);
}

class _CommentPageState extends State<CommentPage> {
  Post post;
  Comment comment;
  final UserModel usersModel = UserModel();
  final CommentsModel commentsModel = CommentsModel();
  NetworkImage pfp;
  bool loggedIn;

  _CommentPageState({this.post});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkUserSettings(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserSettings userSettings = snapshot.data;
            return FutureBuilder(
                future: usersModel.searchUser(userSettings.login),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    User user;
                    if (snapshot.data.docs.isEmpty) {
                      loggedIn = false;
                    } else {
                      DocumentSnapshot userDocument = snapshot.data.docs[0];

                      user = User.fromMap(userDocument.data(),
                          reference: userDocument.reference);
                      loggedIn = true;
                      if(user.image != null){
                        pfp = NetworkImage(user.image);
                      }
                    }
                    return Scaffold(
                      appBar: AppBar(
                        title: Row(
                          children: <Widget>[
                            Icon(Icons.comment),
                            SizedBox(width: 10),
                            Text("Comment Section")
                          ],
                        )
                      ),
                      body: Container(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Column(
                          children: <Widget>[
                            Flexible(
                              child: StreamBuilder(
                                stream: commentsModel.streamAllComments(),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData) {
                                    List comments = snapshot.data.docs;

                                    return ListView.builder(
                                      itemCount: post.comments.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        DocumentSnapshot commentDocument = comments[index];

                                        final comment = Comment.fromMap(
                                          commentDocument.data(),
                                          reference: commentDocument.reference
                                        );

                                        return FutureBuilder(
                                          future: usersModel.searchUser(comment.user),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List users = snapshot.data.docs;

                                              DocumentSnapshot userDocument = users[0];

                                              final user = User.fromMap(
                                                userDocument.data(),
                                                reference: userDocument.reference
                                              );

                                              return _bubbleComment(user,comment);
                                              
                                            } else {
                                              return LinearProgressIndicator();
                                            }
                                          }
                                        );

                                        
                                      }
                                    );
                                  }else {
                                    return Center(
                                      child: CircularProgressIndicator()
                                    );
                                  }
                                }
                              )
                            ),
                            _replySection(loggedIn, pfp)
                          ],
                        )
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

Widget _replySection(bool loggedIn, NetworkImage pfp) {
  if (loggedIn) {
    return Container( 
      padding: const EdgeInsets.symmetric(vertical: 10),
      constraints: BoxConstraints(minHeight: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              backgroundImage: pfp,
            )
          ),
          SizedBox(width: 5),
          Flexible(
            flex: 8,
            child: TextField(
              style: TextStyle(
                fontSize: 18,
              ),
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: BorderSide(width: 0.75),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(15))),
                hintText: "Write a reply",
                isDense: true
              ),
              onSubmitted: (value) {
                print("value");
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.send),
              splashRadius: 20,
              onPressed: () {}
            )
          )
        ],
      )
    );
  }
  else {
    return Container();
  }
}

Widget _bubbleComment(User user, Comment comment) {
  NetworkImage pfp;
  if(user.image != null){
    pfp = NetworkImage(user.image);
  }

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.all(const Radius.circular(10))
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.grey,
              backgroundImage: pfp,
            ) 
          ),
          Flexible(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${comment.user}: ",
                    textScaleFactor: 1.4,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 5),
                  Text("${comment.text}",
                    textScaleFactor: 1.4,
                  )
                ],
              )
            )
          )
        ],
      ),
    )
  );
}