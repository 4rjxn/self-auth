//contains all DI for the Presentation layer

import 'package:get_it/get_it.dart';
import 'package:qauth/Data/Repository/AccountStorageRepoImpl/account_storage_repo_impl.dart';
import 'package:qauth/Data/Repository/BackupManagerRepoImpl/backup_manager_repo_impl.dart';
import 'package:qauth/Domain/BackupUsecases/backup_usecase.dart';
import 'package:qauth/Domain/BackupUsecases/restore_usecase.dart';
import 'package:qauth/Domain/Usecases/add_account_usecase.dart';
import 'package:qauth/Domain/Usecases/delete_account_usecase.dart';
import 'package:qauth/Domain/Usecases/get_accounts_usecase.dart';
import 'package:qauth/Domain/Usecases/update_account_usecase.dart';
import 'package:qauth/Presentation/Pages/HomePage/Bloc/home_page_bloc.dart';

final GetIt getIt = GetIt.instance;

void initGetIt() {
  getIt.registerSingleton<AccountStorageRepoImpl>(AccountStorageRepoImpl());
  getIt.registerSingleton<BackupManagerRepoImpl>(BackupManagerRepoImpl());
  getIt.registerSingleton<HomePageBloc>(HomePageBloc());
  //register all storage related usecases with AccountStorageRepoImpl;
  getIt.registerLazySingleton<GetAccountsUsecase>(
    () => GetAccountsUsecase(
      accountStoreRepository: getIt<AccountStorageRepoImpl>(),
    ),
  );
  getIt.registerLazySingleton<AddAccountUsecase>(
    () => AddAccountUsecase(
      accountStoreRepository: getIt<AccountStorageRepoImpl>(),
    ),
  );
  getIt.registerLazySingleton<UpdateAccountsUsecase>(
    () => UpdateAccountsUsecase(
      accountStoreRepository: getIt<AccountStorageRepoImpl>(),
    ),
  );
  getIt.registerLazySingleton<DeleteAccountUsecase>(
    () => DeleteAccountUsecase(
      accountStoreRepository: getIt<AccountStorageRepoImpl>(),
    ),
  );
  getIt.registerLazySingleton<BackupUsecase>(
    () => BackupUsecase(backupManagerRepo: getIt<BackupManagerRepoImpl>()),
  );
  getIt.registerLazySingleton<RestoreUsecase>(
    () => RestoreUsecase(backupManagerRepo: getIt<BackupManagerRepoImpl>()),
  );
}
