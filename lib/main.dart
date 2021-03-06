import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'model/userSettingsModel.dart';
import 'model/userNotification.dart';

import 'views/updateSettings.dart';
import 'views/main_feed.dart';
import 'views/search_view.dart';
import 'views/send_pulse.dart';
import 'views/notification_view.dart';

import 'widgets/drawer_menu.dart';
import 'widgets/bottomNavigation.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserNotificationListBLoC()),
        ChangeNotifierProvider(
          create: (_) => UserSettingsModel(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Error initializing firebase');
            return Text('Error initializing firebase');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Pulsar',
              theme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.lightBlue,
                accentColor: Colors.lightBlue,
                toggleableActiveColor: Colors.lightBlue,
                splashColor: Colors.lightBlueAccent,
                textSelectionHandleColor: Colors.lightBlue,
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
          } else {
            return CircularProgressIndicator();
          }
        });
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

  void state() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> options = <Widget>[
      MainFeedWidget(),
      SearchView(),
      SendPulse(),
      NotificationPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Center(
          widthFactor: 2,
          child: Image.asset(
            'lib/assets/scaffoldText.png',
            width: 150,
            height: 150,
          ),
        ),
      ),
      drawer: drawerMenu(context, state),
      body: options[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: bottomNavigation(),
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
}
