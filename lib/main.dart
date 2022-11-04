import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fumiya_flutter/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:fumiya_flutter/bloc/toggle_bloc/toggle_bloc.dart';
import 'package:fumiya_flutter/util/app_color_util.dart';
import 'package:firebase_core/firebase_core.dart';

import 'l10n/l10n.dart';
import 'route_generator.dart';
import 'screen/tutorial/tutorial_one_screen.dart';
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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ToggleBloc()),
          BlocProvider(create: (context) => BottomNavBloc())
        ],
        child: MaterialApp(
            title: StringConstants.appName,
            theme: ThemeData(
                fontFamily: StringConstants.fontNotoSans,
                primaryColor: AppColorUtil.appBlueColor,
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.white,
                textTheme: const TextTheme(
                    headline6:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    bodyText2: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
                appBarTheme: const AppBarTheme(
                    titleTextStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    backgroundColor: AppColorUtil.appBlueDarkColor),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorUtil.appBlueDarkColor,
                        minimumSize: const Size(double.infinity, 50),
                        side: const BorderSide(width: 1, color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))))),
            onGenerateRoute: RouteGenerator.generateRoute,
            supportedLocales: L10n.lang,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            home: const TutorialOneScreen()));
  }
}
