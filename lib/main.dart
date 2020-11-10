import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Pulsar/model/userSettings.dart';
import 'model/userSettingsModel.dart';

import 'views/updateSettings.dart';
import 'views/main_feed.dart';
import 'views/drawer_menu.dart';

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
        brightness: Brightness.dark,
        primarySwatch: Colors.lightBlue,
        accentColor: Colors.lightBlue,
        toggleableActiveColor: Colors.lightBlue,
        splashColor: Colors.lightBlueAccent,
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

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'lib/assets/scaffoldText.png',
            width: 150,
            height: 150
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _updateUserSettings,
          ),
        ],
      ),
      drawer: drawerMenu(),
      body: MainFeedWidget(),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30
            ),
            title: Text("Dashboard")
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30
            ),
            title: Text("Search Keyword")
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              size: 40
            ),
            title: Text("Send a Pulse")
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 30
            ),
            title: Text("Notifications")
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mail,
              size: 30
            ),
            title: Text("Direct Messages")
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
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
