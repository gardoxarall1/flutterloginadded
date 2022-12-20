import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DbHelper {
  static Database? _db;
  static const String dbName = 'test.db';
  static const String tableName = 'user';
  static const int version = 1;

  static const String id = 'id';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute(
        'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password TEXT)');
  }

  Future<int> saveData(UserModel user) async {
    final dbClient = await db;
    final res = await dbClient.insert(tableName, user.toMap());
    return res;
  }

  Future<UserModel?> getLoginUser(String email, String password) async {
    final dbClient = await db;
    final List list = await dbClient.rawQuery(
        "SELECT * FROM $tableName WHERE "
            "email = '$email' AND "
            "password = '$password'");
    if (list.isEmpty) {
      return null;
    }
    return UserModel.fromMap(list.first);

  }



  Future<int> deleteUser(String userID) async {
    var dbClient = await db;
    var res =
        await dbClient.delete(tableName, where: '$id = ?', whereArgs: [userID]);
    return res;
  }
}

class UserModel {
  String email;
  String password;

  UserModel(this.email, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'email': email, 'password': password};
    return map;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(map['email'], map['password']);
  }
}
