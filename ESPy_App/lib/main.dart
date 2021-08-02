import 'package:ESPy/Pages/inicial_Page.dart';
import 'package:ESPy/Pages/splash_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Pages/login_Page.dart';
import 'Classes/palette.dart';

void main() => runApp(new MyApp());

String ESPy_url = 'http://192.168.66.109/ESPy/ESPy_MySql';

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
        /* fontFamily: 'Orbitron', */
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
        primarySwatch: Palette.purple,
      ),
      home: new SplashPage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new LoginPage(),
        '/inicial': (BuildContext context) => new inicialPage(),
      },
    );
  }
}
