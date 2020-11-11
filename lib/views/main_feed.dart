import 'package:Pulsar/model/posts.dart';
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
    Future<List<UserSettings>> userSettings =
        userSettingsModel.getAllUserSettings();

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List posts = snapshot.data.docs;

            DocumentSnapshot document = posts[0];
            final post =
                Post.fromMap(document.data(), reference: document.reference);
            print(post);

            return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('comments')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List comments = snapshot.data.docs;

                    DocumentSnapshot document = comments[0];
                    final comment = Comment.fromMap(document.data(),
                        reference: document.reference);
                    print(comment);

                    return FutureBuilder(
                        future: userSettings,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<UserSettings> userSettings = snapshot.data;

                            return ListView.builder(
                              padding: const EdgeInsets.all(8.0),
                              itemCount:
                                  6, //DEBUGGING PURPOSES. BELOW IS THE ORIGINAL
                              //itemCount: userSettings.length,
                              itemBuilder: (BuildContext context, int index) {
                                return pulseCard(context, index);

                                /*
                        return ListTile(
                          title: Text('${userSettings[index].fontSize}'),
                          subtitle: Text('${userSettings[index].showImages}'),
                        );
                        */
                              },
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                  } else {
                    return Text("Plz Wait");
                  }
                });
          } else {
            return Text("Plz Wait");
          }
        });
  }
}
