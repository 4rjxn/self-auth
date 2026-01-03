import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:qauth/Data/EncryptionHandlers/LocalKeyStore/local_key_helper.dart';
import 'package:qauth/Data/Models/AccountModel/account_model.dart';

class BackupEncryptionHandler {
  static Future<String> encryptJsonData({
    required List<Map<String, dynamic>> jsonData,
  }) async {
    final keyList = (await LocalKeyStore().getBackupKey())!
        .split("\$")
        .toList();
    final Encrypter encrypter = Encrypter(AES(Key.fromBase64(keyList.last)));
    final IV iv = IV.fromLength(16);
    final String encryptedData = (encrypter.encrypt(
      jsonEncode(jsonData),
      iv: iv,
    )).base64;
    return "${iv.base64}$encryptedData";
  }

  static Future<List<AccountModel>> decryptJsonData({
    required String backupFilePath,
  }) async {
    final File file = File(backupFilePath);
    final key = (await LocalKeyStore().getBackupKey())!
        .split("\$")
        .toList()
        .last;
    final Encrypter encrypter = Encrypter(AES(Key.fromBase64(key)));
    final encJson = await file.readAsString();
    final json = encrypter.decrypt64(
      encJson.substring(24),
      iv: IV.fromBase64(encJson.substring(0, 24)),
    );
    final List<dynamic> jsonData = jsonDecode(json);
    final List<AccountModel> accounts = [];
    for (final data in jsonData) {
      accounts.add(AccountModel.fromJson(data));
    }
    return accounts;
  }
}
