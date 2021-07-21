import 'package:ESPy/Pages/splash_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'Pages/login_Page.dart';
import 'Classes/palette.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [const Locale('pt', 'BR')],
        title: 'ESPy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
          }),
          primarySwatch: Palette.purple,
        ),
        home: new SplashPage(),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => new LoginPage()
        });
  }
}
