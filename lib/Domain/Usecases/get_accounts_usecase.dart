/*
Usecase for getting all available accounts;
*/

import 'package:qauth/Domain/Entity/account_entity.dart';
import 'package:qauth/Domain/Repository/AccountStorageRepo/account_storage_repo.dart';

class GetAccountsUsecase {
  final AccountStoreRepository accountStoreRepository;
  GetAccountsUsecase({required this.accountStoreRepository});
  Future<List<AccountEntity>> call() async {
    return await accountStoreRepository.getAllAccounts();
  }
}
