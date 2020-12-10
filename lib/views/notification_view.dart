import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/userNotification.dart';
import '../model/posts.dart';
import '../model/usersModel.dart';
import '../model/users.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final UserNotificationListBLoC userNotificationListBLoC =
        context.watch<UserNotificationListBLoC>();

    final UserModel usersModel = UserModel();

    return ListView.separated(
      itemCount: userNotificationListBLoC.userNotifications.length,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 10),
      itemBuilder: (BuildContext context, int index) {
        Post post = userNotificationListBLoC.userNotifications[index].post;

        return FutureBuilder(
            //This is how you search for a user
            future: usersModel.searchUser(post.user),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                DocumentSnapshot userDocument = snapshot.data.docs[0];

                User user = User.fromMap(userDocument.data(),
                    reference: userDocument.reference);

                return Container(
                  color: Colors.grey[900],
                  child: GestureDetector(
                    child: ListTile(
                        //AVATAR
                        leading: CircleAvatar(
                          radius: 35.0,
                          backgroundColor: Colors.blueGrey,
                          backgroundImage: NetworkImage(user.image),
                        ),
                        //MORE OPTIONS
                        trailing: Material(
                            color: Colors
                                .transparent, //DO NOT REMOVE THIS. OTHERWISE THE SPLASH WONT SHOW
                            child: IconButton(
                                icon: Icon(
                                  Icons.visibility_off,
                                  size: 20,
                                ),
                                splashRadius: 15,
                                onPressed: () {
                                  //ADD DELETE FUNCTION HERE
                                  userNotificationListBLoC
                                      .deleteUserNotification(
                                          userNotificationListBLoC
                                              .userNotifications[index]);
                                })),
                        //TEXTS
                        title: Text(
                          post.user,
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(post.content)),
                    onTap: () {
                      print("Expand which pulse");
                      //EXPAND FUNCTION HERE
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            });
      },
    );
  }
}
