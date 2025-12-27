import 'package:dartz/dartz.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';
import 'package:qauth/Domain/Exceptions/storage_exceptions.dart';
import 'package:qauth/Domain/Repository/AccountStorageRepo/account_storage_repo.dart';

class DeleteAccountUsecase {
  final AccountStoreRepository accountStoreRepository;
  DeleteAccountUsecase({required this.accountStoreRepository});
  Future<Either<AccountStorageException, Unit>> call({
    required AccountEntity account,
  }) async {
    return await accountStoreRepository.deleteAccount(accountEntity: account);
  }
}
