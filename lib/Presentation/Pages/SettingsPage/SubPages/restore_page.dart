import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pik_file/pik_file.dart';
import 'package:qauth/Presentation/Pages/SettingsPage/Bloc/settings_page_bloc.dart';

@RoutePage()
class RestorePage extends StatelessWidget {
  const RestorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: MaterialButton(
            onPressed: () async {
              final path = await FlutterFileDialog.pickFile();
              if (path != null && context.mounted) {
                context.read<SettingsPageBloc>().add(
                  RestoreEvent(backupFilePath: path),
                );
              }
            },
            child: Text("pick file"),
          ),
        ),
      ),
    );
  }
}
