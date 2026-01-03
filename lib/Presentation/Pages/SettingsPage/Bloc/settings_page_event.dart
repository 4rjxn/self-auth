part of 'settings_page_bloc.dart';

sealed class SettingsPageEvent {
  const SettingsPageEvent();
}

class BackupEvent extends SettingsPageEvent {
  final String backupPassword;
  final String backupPath;
  BackupEvent({required this.backupPassword, required this.backupPath});
}

class RestoreEvent extends SettingsPageEvent {
  final String backupFilePath;

  RestoreEvent({required this.backupFilePath});
}
