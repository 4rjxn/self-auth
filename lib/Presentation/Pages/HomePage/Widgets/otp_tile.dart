import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qauth/Domain/Entity/account_entity.dart';
import 'package:qauth/Domain/Entity/otp_entity.dart';
import 'package:qauth/Presentation/Pages/HomePage/Bloc/home_page_bloc.dart';
import 'package:qauth/Presentation/Router/router.gr.dart';
import 'package:qauth/Presentation/Styles/text_styles.dart';

class OtpTile extends StatelessWidget {
  final AccountEntity accountEntity;
  final OtpEntity otpEntity;
  const OtpTile({
    super.key,
    required this.accountEntity,
    required this.otpEntity,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isExpanded = ValueNotifier<bool>(false);
    return Padding(
      padding: EdgeInsets.only(bottom: 20.w),
      child: AnimatedBuilder(
        animation: isExpanded,
        builder: (context, child) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  isExpanded.value = !isExpanded.value;
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: isExpanded.value
                          ? Radius.zero
                          : Radius.circular(12.r),
                      bottomRight: isExpanded.value
                          ? Radius.zero
                          : Radius.circular(12.r),
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                  ),
                  width: 320.w,
                  height: 60.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await Clipboard.setData(
                            ClipboardData(text: otpEntity.otp),
                          );
                        },
                        child: Text(
                          otpEntity.otp,
                          style: GlobalTextStyles.otpTileText,
                        ),
                      ),
                      Text(
                        accountEntity.title,
                        style: GlobalTextStyles.otpTileText,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedSize(
                duration: Duration(milliseconds: 120),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  margin: EdgeInsets.only(top: 3.w),
                  height: isExpanded.value ? 120.h : 0,
                  width: 320.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12.r),
                      bottomRight: Radius.circular(12.r),
                    ),
                  ),
                  child: isExpanded.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Issuer ",
                                style: GlobalTextStyles.otpDetailsText.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: accountEntity.issuer,
                                    style: GlobalTextStyles.otpDetailsText,
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Interval ",
                                style: GlobalTextStyles.otpDetailsText.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: accountEntity.interval.toString(),
                                    style: GlobalTextStyles.otpDetailsText,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MaterialButton(
                                  onPressed: () async {
                                    await AutoRouter.of(context).push(
                                      AccountEditRoute(account: accountEntity),
                                    );
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  color: Colors.black,
                                  child: Text(
                                    "Edit",
                                    style: GlobalTextStyles.otpTileText,
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Conformation"),
                                          content: Text(
                                            "All of the data associated with this account will be deleted permenetly",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context
                                                    .read<HomePageBloc>()
                                                    .add(
                                                      DeleteAccountEvent(
                                                        account: accountEntity,
                                                      ),
                                                    );
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Ok"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  color: Colors.black,
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
