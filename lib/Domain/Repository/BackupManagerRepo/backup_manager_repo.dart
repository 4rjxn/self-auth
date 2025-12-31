abstract class BackupManagerRepo {
  Future<void> backup({
    required String backupPassword,
    required String backUpPath,
  }) async {}
}
