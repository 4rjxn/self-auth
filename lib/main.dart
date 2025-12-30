import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qauth/Presentation/Core/DependencyInjection/dependancy_injection.dart';
import 'package:qauth/Presentation/Pages/HomePage/Bloc/home_page_bloc.dart';
import 'package:qauth/Presentation/Pages/SettingsPage/Bloc/settings_page_bloc.dart';
import 'package:qauth/Presentation/Router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //initializing get for dependency injection;
  initGetIt();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomePageBloc>(create: (_) => HomePageBloc()),
        BlocProvider<SettingsPageBloc>(create: (_) => SettingsPageBloc()),
      ],
      child: ScreenUtilInit(
        builder: (_, child) {
          return MaterialApp.router(
            themeMode: ThemeMode.dark,
            darkTheme: ThemeData.dark(useMaterial3: true),
            routerConfig: _appRouter.config(),
          );
        },
      ),
    );
  }
}
