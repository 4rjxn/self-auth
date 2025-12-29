import 'package:encrypt/encrypt.dart';
import 'package:qauth/Data/EncryptionHandlers/LocalKeyStore/local_key_helper.dart';

class BackupEncryptionHandler {
  static Future<String> encryptJsonData({
    required List<Map<String, dynamic>> jsonData,
  }) async {
    final key = await LocalKeyStore().getBackupKey();
    final Encrypter encrypter = Encrypter(AES(Key.fromBase64(key!)));
    final IV iv = IV.fromLength(16);
    final String encryptedData = (encrypter.encrypt(
      jsonData.toString(),
      iv: iv,
    )).base64;
    return "${iv.base64}$encryptedData";
  }
}
