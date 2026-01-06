/*
settings page holds all setting Options
*/

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qauth/Presentation/Pages/SettingsPage/Widgets/settings_tile.dart';
import 'package:qauth/Presentation/Router/router.gr.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: Column(
            children: [
              SettingsTile(
                title: "Backup",
                discription: "Configure Backup Options.",
                route: BackupRoute(),
              ),
              SizedBox(height: 20.h),
              SettingsTile(
                title: "Restore",
                discription: "Restore from an existing backup file",
                route: RestoreRoute(),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
