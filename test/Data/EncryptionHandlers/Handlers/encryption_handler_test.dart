import 'package:flutter_test/flutter_test.dart';
import 'package:qauth/Data/EncryptionHandlers/Handlers/encryption_handler.dart';
import 'package:qauth/Data/EncryptionHandlers/LocalKeyStore/key_types.dart';
import 'package:qauth/Data/Models/AccountModel/account_model.dart';

void main() {
  test("is encryption working", () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final AccountModel account = AccountModel(
      id: 4,
      secretKey: "super secretKey",
      title: "hello",
      length: 8,
      interval: 30,
      issuer: "hello.com",
      iv: "",
    );
    final AccountModel encryptedAccount = await EncryptionHandler.encrypt(
      account: account,
      keyType: KeyType.storeKey,
    );
    print(encryptedAccount.toString());
    final decrypted = await EncryptionHandler.decrypt(
      account: encryptedAccount,
      keyType: KeyType.storeKey,
    );
    print(decrypted.toString());
  });
}
