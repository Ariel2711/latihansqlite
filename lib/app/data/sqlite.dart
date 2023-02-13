// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqlite/app/data/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await setDB();
    }
    return _db!;
  }

  Future setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    String path = join(directory.path, "UserDB");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE user(id INTEGER PRIMARY KEY, username TEXT, password TEXT, role TEXT)");
    print("Database user created");
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert("user", user.toJson());
    print("user inserted");
    return res;
  }

  Future<List<User>> getUsers() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery("SELECT * FROM user");
    List<User> usersData = [];
    for (int i = 0; i < list.length; i++) {
      var user =
          User(list[i]['username'], list[i]['password'], list[i]['role']);
      user.setUserid(list[i]['id']);
      usersData.add(user);
    }
    return usersData;
  }

  Future<bool> updateUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.update("user", user.toJson(),
        where: "id=?", whereArgs: <int?>[user.id]);
    print("user updated");
    return res > 0 ? true : false;
  }

  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res =
        await dbClient.rawDelete("DELETE FROM user WHERE id=?", [user.id]);
    print("user deleted");
    return res;
  }

  Future dropUser() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "UserDB");
    databaseFactory.deleteDatabase(path);
    print("Database Drop");
  }
}
