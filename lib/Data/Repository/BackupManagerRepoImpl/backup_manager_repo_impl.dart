import 'dart:io';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:qauth/Data/DataSource/LocalDB/local_db.dart';
import 'package:qauth/Data/EncryptionHandlers/Handlers/backup_encryption_handler.dart';
import 'package:qauth/Data/EncryptionHandlers/Handlers/encryption_handler.dart';
import 'package:qauth/Data/EncryptionHandlers/LocalKeyStore/local_key_helper.dart';
import 'package:qauth/Data/Models/AccountModel/account_model.dart';
import 'package:qauth/Domain/Repository/BackupManagerRepo/backup_manager_repo.dart';

class BackupManagerRepoImpl implements BackupManagerRepo {
  final LocalDatabase _localDatabase = LocalDatabase.instance;
  @override
  Future<void> backup({
    required String backupPassword,
    required String backUpPath,
  }) async {
    final List<AccountModel> accounts = await _localDatabase.getAllAccounts();
    //token needed for isolate to run;
    final rootToken = ServicesBinding.rootIsolateToken!;
    final String encryptedJsonData = await Isolate.run(() async {
      BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);
      await LocalKeyStore().setBackupKey(backupPassword: backupPassword);
      final List<AccountModel> accountModels = [];
      for (final account in accounts) {
        accountModels.add(await EncryptionHandler.decrypt(account: account));
      }
      final List<Map<String, dynamic>> jsonData = accountModels
          .map((account) => account.toJson())
          .toList();
      return await BackupEncryptionHandler.encryptJsonData(jsonData: jsonData);
    });
    final File backupFile = File(p.join(backUpPath, "backup.alp"));
    print("saver dire:::::: $backUpPath");
    await Permission.storage.request();
    await backupFile.writeAsString(encryptedJsonData);
  }
}
