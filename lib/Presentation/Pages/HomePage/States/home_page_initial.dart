import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qauth/Presentation/Router/router.gr.dart';

class HomePageInitialScreen extends StatelessWidget {
  const HomePageInitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 250.h),
        child: Column(
          children: [
            Text("Dont see your keys?"),
            SizedBox(height: 20.h),
            MaterialButton(
              onPressed: () async {
                await AutoRouter.of(context).push(AccountEditRoute());
              },
              color: Colors.black,
              textColor: Colors.white,
              child: Text("Add New"),
            ),
          ],
        ),
      ),
    );
  }
}
