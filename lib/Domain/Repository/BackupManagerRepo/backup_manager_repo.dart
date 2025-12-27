abstract class BackupManagerRepo {
  Future<void> getBackupConfigs();
  Future<void> generateBackupJson();
  Future<void> uploadBackupJson();
}
