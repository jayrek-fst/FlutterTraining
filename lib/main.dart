import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fumiya_flutter/business_logic/bloc/user_bloc/user_bloc.dart';
import 'package:fumiya_flutter/domain/use_case/user_use_case.dart';

import 'business_logic/bloc/auth_bloc/auth_bloc.dart';
import 'business_logic/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'business_logic/bloc/toggle_bloc/toggle_bloc.dart';
import 'domain/use_case/auth_use_case.dart';
import 'l10n/l10n.dart';
import 'route_generator.dart';
import 'util/route_util.dart';
import 'util/string_constants.dart';
import 'util/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => AuthUseCase()),
          RepositoryProvider(create: (context) => UserUseCase())
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      AuthBloc(
                          appUseCases:
                          RepositoryProvider.of<AuthUseCase>(context))),
              BlocProvider(create: (context) =>
                  UserBloc(
                      userUseCase: RepositoryProvider.of<UserUseCase>(context))),
              BlocProvider(create: (context) => ToggleBloc()),
              BlocProvider(create: (context) => BottomNavBloc())
            ],
            child: MaterialApp(
                title: StringConstants.appName,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: ThemeMode.system,
                onGenerateRoute: RouteGenerator.generateRoute,
                initialRoute: RouteUtil.splash,
                supportedLocales: L10n.lang,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ])));
  }
}
