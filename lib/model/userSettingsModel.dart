import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import 'db_utils.dart';
import 'userSettings.dart';

class UserSettingsModel with ChangeNotifier {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await DBUtils.init();

    List<UserSettings> userSettings = await getAllUserSettings();

    if (userSettings.isEmpty) {
      UserSettings userSettings = UserSettings(
        fontSize: 14,
        showImages: true,
        login: null,
      );
      insertUserSettings(userSettings);
    }

    return _database;
  }

  Future<int> insertUserSettings(UserSettings userSettings) async {
    final db = await database;

    notifyListeners();

    return db.insert(
      'user_settings',
      userSettings.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUserSettings(UserSettings userSettings) async {
    final db = await database;

    await db.update(
      'user_settings',
      userSettings.toMap(),
      where: 'id = ?',
      whereArgs: [userSettings.id],
    );

    notifyListeners();
  }

  Future<void> deleteUserSettingsWithId(int id) async {
    final db = await database;

    await db.delete(
      'user_settings',
      where: 'id = ?',
      whereArgs: [id],
    );

    notifyListeners();
  }

  Future<List<UserSettings>> getAllUserSettings() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('user_settings');
    List<UserSettings> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(UserSettings.fromMap(maps[i]));
      }
    }

    return result;
  }

  Future<UserSettings> getUserSettingsWithId(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'user_settings',
      where: 'id = ?',
      whereArgs: [id],
    );

    notifyListeners();

    if (maps.isEmpty) {
      print("QUERY IS NULL");
      return null;
    } else {
      return UserSettings.fromMap(maps[0]);
    }
  }
}
