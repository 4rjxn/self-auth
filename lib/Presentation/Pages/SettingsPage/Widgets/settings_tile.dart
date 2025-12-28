import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final String discription;
  final PageRouteInfo<Object?> route;
  const SettingsTile({
    super.key,
    required this.title,
    required this.discription,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        await AutoRouter.of(context).push(route);
      },
      child: SizedBox(
        width: double.infinity,
        height: 30.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 20)),
            Text(discription, style: TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
