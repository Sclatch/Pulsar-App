import 'package:Pulsar/model/posts.dart';
import 'package:Pulsar/model/postsModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/userSettings.dart';
import '../model/userSettingsModel.dart';
import '../model/comments.dart';
import '../model/commentsModel.dart';

import '../widgets/pulse.dart';

class MainFeedWidget extends StatefulWidget {
  MainFeedWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainFeedWidgetState createState() => _MainFeedWidgetState();
}

class _MainFeedWidgetState extends State<MainFeedWidget> {
  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserSettingsModel userSettingsModel =
        context.watch<UserSettingsModel>();

    final CommentsModel commentsModel = CommentsModel();
    final PostsModel postsModel = PostsModel();

    //Users, Posts, and Comments all work in either of the following ways
    //This is how you access the posts and update as they update

    return StreamBuilder(
        stream: postsModel.streamAllPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List posts = snapshot.data.docs;

            //This is just to show the first instance of the posts
            DocumentSnapshot postDocument = posts[0];

            //This takes a post from the database and makes it an instance of post

            final post = Post.fromMap(postDocument.data(),
                reference: postDocument.reference);

            print(post);

            //This is how you access a specific comments in a post

            return FutureBuilder(
                future: commentsModel.getComment(post.comments[0]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    DocumentSnapshot commentDocument = snapshot.data;

                    //This takes a comment from the post and makes it an instance of comment

                    final comment = Comment.fromMap(commentDocument.data(),
                        reference: commentDocument.reference);

                    print(comment);

                    return ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return pulseCard(context, index);
                      },
                    );

                    //This is how you can get the User Settings
                    return FutureBuilder(
                        future: userSettingsModel.getAllUserSettings(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<UserSettings> userSettings = snapshot.data;
                            print(userSettings[0]);
                            return Text("$userSettings");
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
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
