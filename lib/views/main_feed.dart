import 'package:Pulsar/model/posts.dart';
import 'package:Pulsar/model/postsModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/userSettings.dart';
import '../model/userSettingsModel.dart';
import '../model/comments.dart';
import '../model/commentsModel.dart';
import '../model/users.dart';
import '../model/usersModel.dart';

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
    final UserModel usersModel = UserModel();

    return FutureBuilder(
        //This is how you search for a user
        future: checkUserSettings(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserSettings settings = snapshot.data;

            print(settings);

            //Users, Posts, and Comments all work in either of the following ways
            //This is how you access the posts and update as they update
            return StreamBuilder(
                stream: postsModel.streamAllPosts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List posts = snapshot.data.docs;

                    int newPosts = posts.length - settings.postCount;

                    //posts = posts.reversed.toList();

                    //This is how you access a specific comments in a post

                    return ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        //This is just to show the first instance of the posts
                        DocumentSnapshot postDocument = posts[index];

                        //This takes a post from the database and makes it an instance of post

                        Post post = Post.fromMap(postDocument.data(),
                            reference: postDocument.reference);

                        if (posts.length > settings.postCount) {
                          settings.postCount = posts.length;
                          updateUserSettings(posts.length);
                        }

                        if (newPosts > 0) {
                          newPosts -= 1;
                          //This is where I will call the notification
                          print("NEW POST FROM USER ${post.user}");
                        }

                        return FutureBuilder(
                            //This is how you search for a user
                            future: usersModel.searchUser(post.user),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List users = snapshot.data.docs;

                                DocumentSnapshot userDocument = users[0];

                                final user = User.fromMap(userDocument.data(),
                                    reference: userDocument.reference);

                                return PulseCard(post: post, user: user);
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            });

                        /*return StreamBuilder(
                    stream: commentsModel.streamAllComments(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List comments = snapshot.data.docs;

                        return ListView.builder(
                            itemCount: comments.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot commentDocument =
                                  comments[index];

                              //This takes a comment from the post and makes it an instance of comment

                              final comment = Comment.fromMap(
                                  commentDocument.data(),
                                  reference: commentDocument.reference);

                              print(comment);
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });*/
                      },
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

  Future<UserSettings> checkUserSettings() async {
    final userSettingsModel = UserSettingsModel();

    UserSettings userSettings;

    var _temp = await userSettingsModel.getUserSettingsWithId(1);

    if (_temp == null) {
      userSettings = UserSettings(
        fontSize: 14,
        showImages: true,
        login: null,
        postCount: 0,
      );

      userSettings.setID(1);

      userSettingsModel.updateUserSettings(userSettings);
    } else {
      userSettings = _temp;
    }

    return userSettings;
  }

  Future<void> updateUserSettings(int postCount) async {
    final model = UserSettingsModel();
    UserSettings userSettings = await model.getUserSettingsWithId(1);

    userSettings.postCount = postCount;

    userSettings.setID(1);

    model.updateUserSettings(userSettings);
  }
}
