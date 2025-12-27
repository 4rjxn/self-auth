import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';
import 'package:qauth/Domain/Exceptions/scan_exception.dart';
import 'package:qauth/Domain/Helpers/parse_url_data.dart';

class ParseUriUsecase {
  Future<Either<ScanException, AccountEntity>> call({
    required String data,
  }) async {
    return await Isolate.run(() => parseUri(uri: data));
  }
}
