/*
Abstract repository defining all available account store usecases;
*/

import 'package:dartz/dartz.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';
import 'package:qauth/Domain/Exceptions/storage_exceptions.dart';

abstract class AccountStoreRepository {
  Future<List<AccountEntity>> getAllAccounts();
  Future<Either<AccountStorageException, Unit>> addNewAccount({
    required AccountEntity accountEntity,
  });
  Future<Either<AccountStorageException, Unit>> updateAccount({
    required AccountEntity accountEntity,
  });
  Future<Either<AccountStorageException, Unit>> deleteAccount({
    required AccountEntity accountEntity,
  });
}
