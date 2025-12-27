import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackupHelper {
  static Future<Option<String>> get getBackUpPath async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? data = pref.get('backup_path') as String?;
    if (data != null) {
      return Some(data);
    }
    return None();
  }

  static Future<void> setBackUpPath({required String path}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("backup_path", path);
    return;
  }
}
