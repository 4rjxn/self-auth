/*
Usecase for updating and existing account entity;
*/
import 'package:dartz/dartz.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';
import 'package:qauth/Domain/Exceptions/storage_exceptions.dart';
import 'package:qauth/Domain/Repository/AccountStorageRepo/account_storage_repo.dart';

class UpdateAccountsUsecase {
  final AccountStoreRepository accountStoreRepository;

  UpdateAccountsUsecase({required this.accountStoreRepository});
  Future<Either<AccountStorageException, Unit>> call({
    required AccountEntity accountEntity,
  }) async {
    return await accountStoreRepository.updateAccount(
      accountEntity: accountEntity,
    );
  }
}
