import 'dart:async';

import 'package:sqflite/sqflite.dart' as sql;

class SqlHelper {
  static Future<sql.Database> openOrCreate() async {
    return await sql.openDatabase(
      'users',
      version: 1,
      onCreate: (database, version) async {
        await _createTable(database);
      },
    );
  }

  static Future<void> _createTable(sql.Database database) async {
    await database.execute(
        'CREATE TABLE RegisteredUsers(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, email TEXT, password TEXT)'
    );
  }

  static Future<int> addUser({required String name, required String email, required String password}) async {
    final db = await SqlHelper.openOrCreate();
    final data = {'name': name, 'email': email, 'password': password};
    final id = await db.insert('RegisteredUsers', data);
    return id;
  }

  static  Future userLogin({required String email,required String password}) async{
    final db = await SqlHelper.openOrCreate();
    final List<Map<String,dynamic>>result = await db.query('RegisteredUsers',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }

  }
}
