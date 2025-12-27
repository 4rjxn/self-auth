import 'package:path/path.dart' as p;
import 'package:qauth/Data/DataSource/LocalKeyStore/local_key_store.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class LocalDbHelper {
  static Future<Database> init() async {
    final String? localKey = await LocalKeyStore().getKey();
    final path = await getDatabasesPath();
    return await openDatabase(
      p.join(path, "local_storage.db"),
      version: 1,
      password: localKey,
      onCreate: (db, ver) async {
        await db.execute('''
          CREATE TABLE accounts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            secretKey TEXT,
            title TEXT,
            length INTEGER,
            interval INTEGER,
            issuer TEXT)
        ''');
      },
    );
  }
}
