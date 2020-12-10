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
import '../model/userNotification.dart';

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
    final UserNotificationListBLoC userNotificationListBLoC =
        Provider.of<UserNotificationListBLoC>(context);
    final UserSettingsModel userSettingsModel =
        context.watch<UserSettingsModel>();

    final CommentsModel commentsModel = CommentsModel();
    final PostsModel postsModel = PostsModel();
    final UserModel usersModel = UserModel();
    List<Post> newPostList = [];

    return FutureBuilder(
        //This is how you search for a user
        future: checkUserSettings(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserSettings settings = snapshot.data;

            print(settings);

            return FutureBuilder(
                //This is how you search for a user
                future: usersModel.searchUser(settings.login),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    User curUser;

                    if (snapshot.data.docs.isEmpty) {
                      curUser = null;
                    } else {
                      DocumentSnapshot userDocument = snapshot.data.docs[0];

                      curUser = User.fromMap(userDocument.data(),
                          reference: userDocument.reference);
                    }

                    //Users, Posts, and Comments all work in either of the following ways
                    //This is how you access the posts and update as they update
                    return StreamBuilder(
                        stream: postsModel.streamAllPosts(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List posts = snapshot.data.docs;

                            int newPosts;

                            if (settings.login != null) {
                              newPosts = posts.length - curUser.postsSeen - 1;
                            }
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

                                if (settings.login != null) {
                                  if (posts.length > curUser.postsSeen) {
                                    curUser.postsSeen = posts.length;
                                    usersModel.updateUser(curUser);
                                  }

                                  if (newPosts >= 0) {
                                    //This is where I will call the notification
                                    //it will be somethng like addNotification(post)

                                    newPostList.add(post);

                                    if (newPosts == 0) {
                                      //print("NEW POST FROM USER ${post.user}");

                                      //newPostList = newPostList.reversed.toList();
                                      for (Post newPost in newPostList) {
                                        //print("NEW POST FROM USER ${newPost.user}");

                                        if (newPost.user != curUser.username) {
                                          UserNotification newUserNotification =
                                              UserNotification(post: newPost);

                                          userNotificationListBLoC
                                              .addUserNotification(
                                                  newUserNotification);
                                        }
                                      }
                                      print(
                                          "THE FIRST NEW POST IS INDEX $index");
                                    }

                                    newPosts -= 1;
                                  }
                                }

                                return FutureBuilder(
                                    //This is how you search for a user
                                    future: usersModel.searchUser(post.user),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List users = snapshot.data.docs;

                                        DocumentSnapshot userDocument =
                                            users[0];

                                        final user = User.fromMap(
                                            userDocument.data(),
                                            reference: userDocument.reference);

                                        return PulseCard(
                                            post: post, user: user);
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
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<UserSettings> checkUserSettings() async {
    final userSettingsModel = UserSettingsModel();

    return await userSettingsModel.getUserSettingsWithId(1);
  }
}
