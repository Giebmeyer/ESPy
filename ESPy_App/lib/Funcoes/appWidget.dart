import 'package:ESPy/Bluetooth/bluetoohPage.dart';
import 'package:ESPy/Funcoes/appController.dart';
import 'package:ESPy/Pages/cadastroUsuario_Page.dart';
import 'package:ESPy/Pages/configSensorPage.dart';
import 'package:ESPy/Pages/dashBoard_Page.dart';
import 'package:ESPy/Pages/meuPerfil_Page.dart';
import 'package:ESPy/Pages/minhaEmpresa_Page.dart';
import 'package:flutter/material.dart';

import '../Pages/recoverPass_Page.dart';
import '../Pages/home_Page.dart';
import '../Pages/login_Page.dart';
import 'classPalette.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
          initialRoute: '/login',
          routes: {
            '/login': (context) => LoginPage(),
            '/home': (context) => HomePage(),
            '/editPass': (context) => recoverPassPage(),
            '/CreateUser': (context) => CadastroUserPage(),
            '/Bluethooth': (context) => Bluetooth(),
          },
        );
      },
    );
  }
}

class CustomSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: AppController.instance.isDartTheme,
      onChanged: (value) {
        AppController.instance.carregaTema();
      },
    );
  }
}

class barraDeNavegacaoInferior extends StatefulWidget {
  @override
  _barraDeNavegacaoInferiorState createState() =>
      _barraDeNavegacaoInferiorState();
}

class _barraDeNavegacaoInferiorState extends State<barraDeNavegacaoInferior> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.business,
              color: Palette.purple,
            ),
            title: Text('Minha Empresa')),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.workspaces_outline,
              color: Palette.purple,
            ),
            title: Text('Principal')),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => minhaEmpresaPage()));
    }
    if (index == 1) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  void requestDHT11_Temperatura() {}
}

class barraDeNavegacaoChefeInferior extends StatefulWidget {
  @override
  _barraDeNavegacaoChefeInferiorState createState() =>
      _barraDeNavegacaoChefeInferiorState();
}

class _barraDeNavegacaoChefeInferiorState
    extends State<barraDeNavegacaoChefeInferior> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Palette.purple,
            ),
            title: Text('Configurações')),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.business,
              color: Palette.purple,
            ),
            title: Text('Minha Empresa')),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.workspaces_outline,
              color: Palette.purple,
            ),
            title: Text('Principal')),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.bluetooth,
              color: Palette.purple,
            ),
            title: Text('Bluetooth')),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              color: Palette.purple,
            ),
            title: Text('DashBoard'))
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => configSensor()));
    }
    if (index == 1) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => minhaEmpresaPage()));
    }
    if (index == 2) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
    if (index == 3) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Bluetooth()));
    }
    if (index == 4) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => dashBoard()));
    }
  }

  void requestDHT11_Temperatura() {}
}
