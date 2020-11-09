import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/userSettings.dart';
import '../model/userSettingsModel.dart';

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

    return FutureBuilder(
        future: userSettings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserSettings> userSettings = snapshot.data;

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: userSettings.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  tileColor: Colors.white,
                  title: Text('${userSettings[index].fontSize}'),
                  subtitle: Text('${userSettings[index].showImages}'),
                );
              },
            );
          } else {
            return Text("Plz Wait");
          }
        });
  }
}
