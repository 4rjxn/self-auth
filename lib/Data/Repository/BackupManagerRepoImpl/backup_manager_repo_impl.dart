import 'dart:io';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:qauth/Data/DataSource/LocalDB/local_db.dart';
import 'package:qauth/Data/EncryptionHandlers/Handlers/backup_encryption_handler.dart';
import 'package:qauth/Data/EncryptionHandlers/Handlers/encryption_handler.dart';
import 'package:qauth/Data/Models/AccountModel/account_model.dart';
import 'package:qauth/Domain/Repository/BackupManagerRepo/backup_manager_repo.dart';

class BackupManagerRepoImpl implements BackupManagerRepo {
  final LocalDatabase _localDatabase = LocalDatabase.instance;
  @override
  Future<void> backup() async {
    final List<AccountModel> accounts = await _localDatabase.getAllAccounts();
    //token needed for isolate to run;
    final rootToken = ServicesBinding.rootIsolateToken!;
    await Isolate.run(() async {
      BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);
      final List<AccountModel> accountModels = [];
      for (final account in accounts) {
        accountModels.add(await EncryptionHandler.decrypt(account: account));
      }
      final List<Map<String, dynamic>> jsonData = accountModels
          .map((account) => account.toJson())
          .toList();
      final String encryptedJsonData =
          await BackupEncryptionHandler.encryptJsonData(jsonData: jsonData);
      final Directory dir = await getApplicationDocumentsDirectory();
      final File backupFile = File(p.join(dir.path, "backup.alp"));
      await backupFile.writeAsString(encryptedJsonData);
    });
  }
}
