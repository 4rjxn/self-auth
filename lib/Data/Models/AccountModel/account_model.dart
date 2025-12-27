/*
The data layer model responsible for data source based operations and transport;
*/

import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
abstract class AccountModel with _$AccountModel {
  const factory AccountModel({
    required final int id,
    required final String secretKey,
    required final String title,
    required final int length,
    required final int interval,
    required final String issuer,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, Object?> json) =>
      _$AccountModelFromJson(json);
}
