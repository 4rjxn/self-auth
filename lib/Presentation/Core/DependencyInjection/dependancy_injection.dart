import 'package:get_it/get_it.dart';
import 'package:qauth/Data/Repository/AccountStorageRepo/account_storage_repo_impl.dart';
import 'package:qauth/Domain/Usecases/add_account_usecase.dart';
import 'package:qauth/Domain/Usecases/delete_account_usecase.dart';
import 'package:qauth/Domain/Usecases/get_accounts_usecase.dart';
import 'package:qauth/Domain/Usecases/update_account_usecase.dart';

final GetIt getIt = GetIt.instance;

void initGetIt() {
  getIt.registerSingleton<AccountStorageRepoImpl>(AccountStorageRepoImpl());
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
}
