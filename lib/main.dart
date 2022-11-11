import 'dart:async';
import 'package:common/common.dart';
import 'package:dicoding_ditonton_app/on_generate_route.dart';
import 'package:dicoding_ditonton_app/presentation/pages/main_page.dart';
import 'package:dicoding_ditonton_app/blocs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dicoding_ditonton_app/injection.dart' as di;

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      await di.init();
      runApp(const MyApp());
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: listBlocs,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kWhiteColor,
          scaffoldBackgroundColor: kWhiteColor,
          textTheme: kTextTheme,
        ),
        home: const MainPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
