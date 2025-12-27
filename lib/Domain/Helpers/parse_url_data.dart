import 'package:dartz/dartz.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';
import 'package:qauth/Domain/Exceptions/scan_exception.dart';

Either<ScanException, AccountEntity> parseUri({required String uri}) {
  final parsedUri = Uri.parse(uri);
  if (parsedUri.host == "totp") {
    final params = parsedUri.queryParameters;
    return right(
      AccountEntity(
        title: params["issuer"]!,
        secretKey: params["secret"]!,
        length: int.parse(params["digits"] ?? "6"),
        issuer: params["issuer"]!,
        interval: int.parse(params["period"] ?? "30"),
      ),
    );
  }
  return left(ScanException());
}
