/*
mapping of datalayer model to domain layer Entity
*/

import 'package:qauth/Data/Models/AccountModel/account_model.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';

class ModelToEntityMapper {
  static AccountEntity mapToAccountEntity({required AccountModel model}) {
    return AccountEntity(
      id: model.id,
      title: model.title,
      length: model.length,
      interval: model.interval,
      issuer: model.issuer,
      secretKey: model.secretKey,
    );
  }
}
