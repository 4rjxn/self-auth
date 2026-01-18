//The usecase which handles the backup calls

import 'package:qauth/Domain/Repository/BackupManagerRepo/backup_manager_repo.dart';

class BackupUsecase {
  final BackupManagerRepo backupManagerRepo;

  BackupUsecase({required this.backupManagerRepo});
  Future<void> call({
    required String backupPassword,
    required String backUpPath,
  }) async {
    await backupManagerRepo.backup(
      backupPassword: backupPassword,
      backUpPath: backUpPath,
    );
  }
}
