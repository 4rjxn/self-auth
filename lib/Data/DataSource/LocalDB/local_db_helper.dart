import 'package:path/path.dart' as p;
import 'package:qauth/Data/EncryptionHandlers/LocalKeyStore/local_key_helper.dart';
import 'package:sqflite/sqflite.dart';

class LocalDbHelper {
  static Future<Database> init() async {
    await LocalKeyStore().getKey();
    final path = await getDatabasesPath();
    return await openDatabase(
      p.join(path, "local_storage.db"),
      version: 1,
      onCreate: (db, ver) async {
        await db.execute('''
          CREATE TABLE accounts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            secretKey TEXT,
            title TEXT,
            length INTEGER,
            interval INTEGER,
            issuer TEXT,
            iv TEXT)
        ''');
      },
    );
  }
}
