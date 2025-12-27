import 'dart:isolate';

import 'package:qauth/Domain/Entity/account_entity.dart';
import 'package:qauth/Domain/Entity/otp_entity.dart';
import 'package:totp_dart/totp_dart.dart';

class GenerateOtpUsecase {
  Future<List<OtpEntity>> call({
    required List<AccountEntity> accountList,
  }) async {
    return await Isolate.run(() {
      final List<OtpEntity> listOfOtps = accountList.map((account) {
        final totp = TOTP(
          sharecdSecret: account.secretKey,
          otpconfig: OtpConfig(
            interval: account.interval,
            lenght: account.length,
          ),
        );
        final otp = totp.update();
        return OtpEntity(otp: otp['otp']!, expiryIn: otp['timeLeft']!);
      }).toList();
      return listOfOtps;
    });
  }
}
