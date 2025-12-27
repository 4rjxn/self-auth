/*
implimentation of domain layer repository to fetch data from local_database
*/

import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:qauth/Data/DataSource/LocalDB/local_db.dart';
import 'package:qauth/Data/Mappers/entity_to_model_mapper.dart';
import 'package:qauth/Data/Mappers/model_to_entity_mapper.dart';
import 'package:qauth/Data/Models/AccountModel/account_model.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';
import 'package:qauth/Domain/Exceptions/storage_exceptions.dart';
import 'package:qauth/Domain/Repository/AccountStorageRepo/account_storage_repo.dart';

class AccountStorageRepoImpl implements AccountStoreRepository {
  final LocalDatabase _localDatabase = LocalDatabase.instance;
  @override
  Future<List<AccountEntity>> getAllAccounts() async {
    final List<AccountModel> accounts = await _localDatabase.getAllAccounts();
    return await Isolate.run(() {
      return accounts
          .map((e) => ModelToEntityMapper.mapToAccountEntity(model: e))
          .toList();
    });
  }

  @override
  Future<Either<AccountStorageException, Unit>> addNewAccount({
    required AccountEntity accountEntity,
  }) async {
    if (await _localDatabase.setNewAccount(
      data: EntityToModelMapper.mapToAccountModel(entity: accountEntity),
    )) {
      return Right(unit);
    } else {
      return Left(
        AccountStorageException(error: "Add Account Failed (DB_ERR)"),
      );
    }
  }

  @override
  Future<Either<AccountStorageException, Unit>> updateAccount({
    required AccountEntity accountEntity,
  }) async {
    if (await _localDatabase.updateAccount(
      data: EntityToModelMapper.mapToAccountModel(entity: accountEntity),
    )) {
      return Right(unit);
    } else {
      return Left(
        AccountStorageException(error: "Update Account Failed (DB_ERR)"),
      );
    }
  }

  @override
  Future<Either<AccountStorageException, Unit>> deleteAccount({
    required AccountEntity accountEntity,
  }) async {
    if (await _localDatabase.deleteAccount(
      data: EntityToModelMapper.mapToAccountModel(entity: accountEntity),
    )) {
      return Right(unit);
    } else {
      return Left(
        AccountStorageException(error: "Delete Account Failed (DB_ERR)"),
      );
    }
  }
}
