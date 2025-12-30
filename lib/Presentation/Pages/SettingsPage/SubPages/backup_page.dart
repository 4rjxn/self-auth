import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qauth/Presentation/Pages/SettingsPage/Bloc/settings_page_bloc.dart';

@RoutePage()
class BackupPage extends StatelessWidget {
  BackupPage({super.key});
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Backup")),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
              controller: _passwordController,
            ),
            MaterialButton(
              onPressed: () {
                context.read<SettingsPageBloc>().add(
                  BackupEvent(backupPassword: _passwordController.text),
                );
                _passwordController.clear();
                Navigator.of(context).pop();
              },
              color: Colors.white,
              child: Text("Backup"),
            ),
          ],
        ),
      ),
    );
  }
}
