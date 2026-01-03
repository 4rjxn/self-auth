abstract class BackupManagerRepo {
  Future<void> backup({
    required String backupPassword,
    required String backUpPath,
  });
  Future<void> restore({required String backupFilePath});
}
