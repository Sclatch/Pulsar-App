import 'package:flutter/material.dart';

List<BottomNavigationBarItem> bottomNavigation() {
  return const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home, size: 30),
      title: Text("Dashboard"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search, size: 30),
      title: Text("Search Keyword"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_circle_outline, size: 30),
      title: Text("Send a Pulse"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications, size: 30),
      title: Text("Notifications"),
    ),
  ];
}
