part of 'settings_page_bloc.dart';

sealed class SettingsPageEvent {
  const SettingsPageEvent();
}

class BackupEvent extends SettingsPageEvent {
  final String backupPassword;

  BackupEvent({required this.backupPassword});
}
