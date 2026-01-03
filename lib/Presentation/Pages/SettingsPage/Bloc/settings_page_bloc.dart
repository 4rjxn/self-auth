import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qauth/Domain/BackupUsecases/backup_usecase.dart';
import 'package:qauth/Domain/BackupUsecases/restore_usecase.dart';
import 'package:qauth/Presentation/Core/DependencyInjection/dependancy_injection.dart';
import 'package:qauth/Presentation/Pages/HomePage/Bloc/home_page_bloc.dart';

part 'settings_page_state.dart';
part 'settings_page_event.dart';

class SettingsPageBloc extends Bloc<SettingsPageEvent, SettingsPageState> {
  SettingsPageBloc() : super(SettingsPageLoaded()) {
    on<BackupEvent>(_backupEventHandler);
    on<RestoreEvent>(_restoreEvent);
  }
  Future<void> _backupEventHandler(
    BackupEvent event,
    Emitter<SettingsPageState> emit,
  ) async {
    await getIt<BackupUsecase>().call(
      backupPassword: event.backupPassword,
      backUpPath: event.backupPath,
    );
  }

  Future<void> _restoreEvent(
    RestoreEvent event,
    Emitter<SettingsPageState> emit,
  ) async {
    await getIt<RestoreUsecase>().call(backupFilePath: event.backupFilePath);
    getIt<HomePageBloc>().add(RefreshHomePageEvent());
  }
}
