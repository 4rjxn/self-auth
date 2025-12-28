import 'package:auto_route/auto_route.dart';
import 'package:qauth/Presentation/Router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: AccountEditRoute.page, fullscreenDialog: true),
    AutoRoute(page: ScanCodeRoute.page, fullscreenDialog: true),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: BackupRoute.page),
  ];
}
