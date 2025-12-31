import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qauth/Presentation/Pages/SettingsPage/Bloc/settings_page_bloc.dart';

@RoutePage()
class BackupPage extends StatelessWidget {
  BackupPage({super.key});
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pathFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Backup")),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "<password>",
                  border: OutlineInputBorder(),
                ),
                controller: _passwordController,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
              child: TextField(
                controller: _pathFieldController,
                onTap: () async {
                  await Permission.storage.request();
                  final userPickedPath = await FilePickerIO()
                      .getDirectoryPath();
                  if (userPickedPath != null) {
                    _pathFieldController.text = userPickedPath;
                  }
                },
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "<backup path>",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            MaterialButton(
              onPressed: () {
                context.read<SettingsPageBloc>().add(
                  BackupEvent(
                    backupPassword: _passwordController.text,
                    backupPath: _pathFieldController.text,
                  ),
                );
                _passwordController.clear();
                Navigator.of(context).pop();
              },
              color: Colors.white,
              child: Text("Backup", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
