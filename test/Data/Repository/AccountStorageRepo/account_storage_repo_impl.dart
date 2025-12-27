import 'package:flutter_test/flutter_test.dart';
import 'package:qauth/Data/Repository/AccountStorageRepo/account_storage_repo_impl.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';

void main() {
  late AccountStorageRepoImpl sut;
  setUp(() {
    sut = AccountStorageRepoImpl();
  });
  test("testing if set function works", () async {
    final status = await sut.setNewAccount(
      accountEntity: AccountEntity(
        title: "Test Title",
        length: 6,
        interval: 30,
        issuer: "test.com",
        secretKey: "lasfdfhgifagiafh24",
      ),
    );
    expect(status, true);
  });
}
