import 'package:flutter_test/flutter_test.dart';
import 'package:qauth/Data/DataSource/LocalKeyStore/local_key_store.dart';

void main() {
  test("is key generated", () {
    final LocalKeyStore keystore = LocalKeyStore();
    print(keystore.getKey());
  });
}
