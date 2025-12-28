import 'package:encrypt/encrypt.dart';
import 'package:qauth/Data/EncryptionHandlers/LocalKeyStore/key_types.dart';
import 'package:qauth/Data/EncryptionHandlers/LocalKeyStore/local_key_helper.dart';
import 'package:qauth/Data/Models/AccountModel/account_model.dart';

class EncryptionHandler {
  static Future<AccountModel> encrypt({
    required AccountModel account,
    required KeyType keyType,
  }) async {
    final String key = await switch (keyType) {
      KeyType.storeKey => LocalKeyStore().getKey(),
      KeyType.backupKey => LocalKeyStore().getKey(),
    };
    if (account.iv == "") {
      account = account.copyWith(iv: IV.fromLength(16).base64);
    }
    final encrypter = Encrypter(AES(Key.fromBase64(key)));
    final encryptedSecret = encrypter.encrypt(
      account.secretKey,
      iv: IV.fromBase64(account.iv),
    );
    return account.copyWith(secretKey: encryptedSecret.base64);
  }

  static Future<AccountModel> decrypt({
    required AccountModel account,
    required KeyType keyType,
  }) async {
    final String key = await switch (keyType) {
      KeyType.storeKey => LocalKeyStore().getKey(),
      KeyType.backupKey => LocalKeyStore().getKey(),
    };
    final Encrypter encrypter = Encrypter(AES(Key.fromBase64(key)));
    final String secretKey = encrypter.decrypt(
      Encrypted.fromBase64(account.secretKey),
      iv: IV.fromBase64(account.iv),
    );
    return account.copyWith(secretKey: secretKey);
  }
}
