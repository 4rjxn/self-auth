import 'package:qauth/Domain/Repository/BackupManagerRepo/backup_manager_repo.dart';

class BackupUsecase {
  final BackupManagerRepo backupManagerRepo;

  BackupUsecase({required this.backupManagerRepo});
  Future<void> call() async {
    await backupManagerRepo.backup();
  }
}
