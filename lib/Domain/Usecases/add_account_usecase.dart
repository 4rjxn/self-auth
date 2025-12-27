/*
Usecase for Setting a new account(insert) all; 
*/

import 'package:dartz/dartz.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';
import 'package:qauth/Domain/Exceptions/storage_exceptions.dart';
import 'package:qauth/Domain/Repository/AccountStorageRepo/account_storage_repo.dart';

class AddAccountUsecase {
  final AccountStoreRepository accountStoreRepository;
  AddAccountUsecase({required this.accountStoreRepository});
  Future<Either<AccountStorageException, Unit>> call({
    required AccountEntity accountEntity,
  }) async {
    return await accountStoreRepository.addNewAccount(
      accountEntity: accountEntity,
    );
  }
}
