import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
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
    await Isolate.run(() async {
      BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);
      await LocalKeyStore().setBackupKey(backupPassword: backupPassword);
      final List<AccountModel> accountModels = [];
      for (final account in accounts) {
        accountModels.add(await EncryptionHandler.decrypt(account: account));
      }
      final List<Map<String, dynamic>> jsonData = accountModels
          .map((account) => account.toJson())
          .toList();
      final String encryptedJsonData =
          await BackupEncryptionHandler.encryptJsonData(jsonData: jsonData);
      await FlutterFileDialog.saveFileToDirectory(
        directory: backUpPath,
        data: utf8.encode(encryptedJsonData),
        fileName: "backup.alp",
        mimeType: "application/octet-stream",
        replace: true,
      );
    });
  }
}
