import 'package:flutter/material.dart';

import '../model/posts.dart';

class UserNotification {
  Post post;

  UserNotification({this.post});

  String toString() {
    return '$post';
  }
}

class UserNotificationListBLoC with ChangeNotifier {
  List<UserNotification> _userNotifications = [];

  List<UserNotification> get userNotifications => _userNotifications;

  set userNotifications(List<UserNotification> newValue) {
    _userNotifications = newValue;

    notifyListeners();
  }

  addUserNotification(UserNotification newUserNotification) {
    _userNotifications.add(newUserNotification);

    notifyListeners();
  }

  deleteUserNotification(UserNotification userNotification) {
    _userNotifications.remove(userNotification);

    notifyListeners();
  }
}
