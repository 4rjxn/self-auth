//Usecase for managing restore
import 'package:qauth/Domain/Repository/BackupManagerRepo/backup_manager_repo.dart';

class RestoreUsecase {
  final BackupManagerRepo backupManagerRepo;

  RestoreUsecase({required this.backupManagerRepo});
  Future<void> call({required String backupFilePath}) async {
    await backupManagerRepo.restore(backupFilePath: backupFilePath);
  }
}
