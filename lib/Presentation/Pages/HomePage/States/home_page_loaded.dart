import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';
import 'package:qauth/Domain/Entity/otp_entity.dart';
import 'package:qauth/Presentation/Pages/HomePage/Widgets/otp_tile.dart';

class HomePageLoadedScreen extends StatelessWidget {
  final List<AccountEntity> listOfAccounts;
  final List<OtpEntity> otpEntity;
  const HomePageLoadedScreen({
    super.key,
    required this.listOfAccounts,
    required this.otpEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Center(
        child: ListView.builder(
          itemCount: listOfAccounts.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: OtpTile(
                accountEntity: listOfAccounts[index],
                otpEntity: otpEntity[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
