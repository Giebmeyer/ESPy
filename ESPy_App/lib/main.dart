import 'package:ESPy/Bluetooth/bluetoohPage.dart';
import 'package:ESPy/Paginas/configSensor_Page.dart';
import 'package:ESPy/Paginas/dashBoard_Page.dart';
import 'package:ESPy/Paginas/empresa_Page.dart';
import 'package:ESPy/Paginas/inicial_Page.dart';
import 'package:ESPy/Paginas/splash_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Paginas/login_Page.dart';
import 'Classes/palette.dart';

void main() => runApp(new MyApp());

String ESPy_url = 'http://192.168.66.109/ESPy/ESPy_Php';

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
        '/configSensor': (BuildContext context) => new configSensor(),
        '/minhaEmpresa': (BuildContext context) => new EmpresaPage(),
        '/dashBoard': (BuildContext context) => new dashBoard(),
        '/Bluetooth': (BuildContext context) => new Bluetooth(),
      },
    );
  }
}
