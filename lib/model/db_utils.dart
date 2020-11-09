import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future<Database> init() async {
    return await openDatabase(
      path.join(await getDatabasesPath(), 'settings.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE user_settings(id INTEGER PRIMARY KEY, fontSize INTEGER, showImages INTEGER)');
      },
      version: 1,
    );
  }
}
