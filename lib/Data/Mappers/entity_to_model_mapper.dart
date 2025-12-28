/*
Maping of domain layer entity to datalayer model
*/

import 'package:qauth/Data/Models/AccountModel/account_model.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';

class EntityToModelMapper {
  static AccountModel mapToAccountModel({required AccountEntity entity}) {
    return AccountModel(
      id: entity.id,
      secretKey: entity.secretKey,
      title: entity.title,
      length: entity.length,
      interval: entity.interval,
      issuer: entity.issuer,
      iv: "",
    );
  }
}
