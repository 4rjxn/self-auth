import 'package:encrypt/encrypt.dart';
import 'package:qauth/Data/EncryptionHandlers/LocalKeyStore/local_key_helper.dart';

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
      jsonData.toString(),
      iv: iv,
    )).base64;
    return "${keyList[0]}${iv.base64}$encryptedData";
  }
}
