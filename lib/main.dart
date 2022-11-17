import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import 'bloc/auth_bloc/auth_bloc.dart';
import 'bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'bloc/toggle_bloc/toggle_bloc.dart';
import 'business_logic/cubit/password_toggle_cubit.dart';
import 'domain/use_case/app_use_cases.dart';
import 'l10n/l10n.dart';
import 'route_generator.dart';
import 'util/app_color_util.dart';
import 'util/route_util.dart';
import 'util/string_constants.dart';

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
          RepositoryProvider(
              create: (context) => AppUseCases())
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => AuthBloc(
                      appUseCases:
                          RepositoryProvider.of<AppUseCases>(context))),
              BlocProvider(create: (context) => ToggleBloc()),
              BlocProvider(create: (context) => BottomNavBloc()),
              BlocProvider(create: (context) => PasswordToggleCubit())
            ],
            child: MaterialApp(
                title: StringConstants.appName,
                theme: ThemeData(
                    fontFamily: StringConstants.fontNotoSans,
                    primaryColor: AppColorUtil.appBlueColor,
                    primarySwatch: Colors.blue,
                    scaffoldBackgroundColor: Colors.white,
                    errorColor: AppColorUtil.appOrangeColor,
                    textTheme: const TextTheme(
                        headline6: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w400),
                        bodyText2: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                    appBarTheme: const AppBarTheme(
                        titleTextStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                        backgroundColor: AppColorUtil.appBlueDarkColor),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColorUtil.appBlueDarkColor,
                            minimumSize: const Size(double.infinity, 50),
                            side:
                                const BorderSide(width: 1, color: Colors.white),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)))),
                    checkboxTheme: CheckboxThemeData(
                        checkColor: MaterialStateProperty.all(
                            AppColorUtil.appBlueColor),
                        fillColor: MaterialStateProperty.all(Colors.white))),
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
