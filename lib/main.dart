import 'package:dicoding_ditonton_app/common/constants.dart';
import 'package:dicoding_ditonton_app/common/route_observer.dart';
import 'package:dicoding_ditonton_app/on_generate_route.dart';
import 'package:dicoding_ditonton_app/presentation/pages/main_page.dart';
import 'package:dicoding_ditonton_app/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dicoding_ditonton_app/injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: listProviders,
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
