import 'dart:isolate';
import 'package:qauth/Data/DataSource/LocalDB/local_db_helper.dart';
import 'package:qauth/Data/Models/AccountModel/account_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static Database? _db;
  LocalDatabase._();
  static final LocalDatabase instance = LocalDatabase._();
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await LocalDbHelper.init();
    return _db!;
  }

  Future<List<AccountModel>> getAllAccounts() async {
    final db = await database;
    final data = await db.query("accounts");
    final List<AccountModel> list = await Isolate.run(() {
      return data.map((e) => AccountModel.fromJson(e)).toList();
    });
    data.map((e) => AccountModel.fromJson(e)).toList();
    return list;
  }

  Future<bool> setNewAccount({required AccountModel data}) async {
    final db = await database;
    final jsonData = data.toJson();
    jsonData.remove('id');
    await db.insert("accounts", jsonData);
    return true;
  }

  Future<bool> updateAccount({required AccountModel data}) async {
    final db = await database;
    await db.update(
      "accounts",
      data.toJson(),
      where: "id=?",
      whereArgs: [data.id],
    );
    return true;
  }

  Future<bool> deleteAccount({required AccountModel data}) async {
    final db = await database;
    await db.delete("accounts", where: "id=?", whereArgs: [data.id]);
    return true;
  }
}
