import 'package:encrypt/encrypt.dart';
import 'package:qauth/Data/EncryptionHandlers/LocalKeyStore/local_key_helper.dart';
import 'package:qauth/Data/Models/AccountModel/account_model.dart';

class EncryptionHandler {
  static Future<AccountModel> encrypt({required AccountModel account}) async {
    if (account.iv == "") {
      account = account.copyWith(iv: IV.fromLength(16).base64);
    }
    final encrypter = Encrypter(
      AES(Key.fromBase64(await LocalKeyStore().getKey())),
    );
    final encryptedSecret = encrypter.encrypt(
      account.secretKey,
      iv: IV.fromBase64(account.iv),
    );
    return account.copyWith(secretKey: encryptedSecret.base64);
  }

  static Future<AccountModel> decrypt({required AccountModel account}) async {
    final Encrypter encrypter = Encrypter(
      AES(Key.fromBase64(await LocalKeyStore().getKey())),
    );
    final String secretKey = encrypter.decrypt(
      Encrypted.fromBase64(account.secretKey),
      iv: IV.fromBase64(account.iv),
    );
    return account.copyWith(secretKey: secretKey);
  }
}
