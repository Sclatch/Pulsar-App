import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Pulsar/model/userSettings.dart';
import 'model/userSettingsModel.dart';

import 'views/updateSettings.dart';
import 'views/main_feed.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserSettingsModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulsar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: 'Pulsar'),
      routes: <String, WidgetBuilder>{
        '/updateUserSettings': (BuildContext context) =>
            UpdateUserSettingsWidget(title: 'Update User Settings'),
        '/mainFeed': (BuildContext context) =>
            MainFeedWidget(title: 'Main Feed'),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _updateUserSettings,
          ),
        ],
      ),
      body: MainFeedWidget(),
    );
  }

  Future<void> _updateUserSettings() async {
    var userSettings =
        await Navigator.pushNamed(context, '/updateUserSettings');

    UserSettings newUserSettings = userSettings;

    newUserSettings.setID(1);

    final _model = UserSettingsModel();

    _model.updateUserSettings(newUserSettings);

    setState(() {});

    print("Update called: ${newUserSettings}");
  }
}
