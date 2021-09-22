import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Paginas/DashBoard/listaCaixasColeta_Page.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'Empresa/empresa_Page.dart';
import 'Usuario/home_Page.dart';

class Pages extends StatefulWidget {
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  final List<Widget> telasChefe = [
    EmpresaPage(),
    HomePage(),
    caixasColeta(),
  ];

  final List<Widget> telasEmpregado = [
    EmpresaPage(),
    HomePage(),
    caixasColeta(),
  ];

  final List<Widget> telasNovoUsuario = [
    EmpresaPage(),
    HomePage(),
  ];

  int selectedIndexChefe = 1;
  int selectedIndexEmpregado = 1;
  int selectedIndexNovoUser = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: telasUsuarioCargo_Retorno(),
      bottomNavigationBar: barraDeNavegacaoInferior_Retorno(),
    );
  }

  telasUsuarioCargo_Retorno() {
    if (user.usuario_chefe == 0 && user.usuario_empregado == 0) {
      return telasNovoUsuario[selectedIndexNovoUser];
    } else if (user.usuario_chefe == 0 && user.usuario_empregado == 1) {
      return telasEmpregado[selectedIndexEmpregado];
    } else {
      return telasChefe[selectedIndexChefe];
    }
  }

  Widget barraDeNavegacaoInferior_Retorno() {
    if (user.usuario_chefe == 0 && user.usuario_empregado == 0) {
      return barraDeNavegacaoInferior();
    } else if (user.usuario_chefe == 0 && user.usuario_empregado == 1) {
      return barraDeNavegacaoInferiorEmpregado();
    } else {
      return barraDeNavegacaoChefeInferior();
    }
  }

  Widget barraDeNavegacaoInferior() {
    return BottomNavyBar(
      selectedIndex: selectedIndexEmpregado,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => selectedIndexEmpregado = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            icon: Icon(
              Icons.business,
              color: Palette.purple,
            ),
            activeColor: Palette.purple.shade50,
            title: Text('Empresa', style: TextStyle(color: Colors.white))),
        BottomNavyBarItem(
            icon: Icon(
              Icons.workspaces_outline,
              color: Palette.purple,
            ),
            activeColor: Palette.purple.shade50,
            title: Text('Principal', style: TextStyle(color: Colors.white))),
      ],
    );
  }

  Widget barraDeNavegacaoInferiorEmpregado() {
    return BottomNavyBar(
      selectedIndex: selectedIndexEmpregado,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => selectedIndexEmpregado = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            icon: Icon(
              Icons.business,
              color: Palette.purple,
            ),
            activeColor: Palette.purple.shade50,
            title: Text('Empresa', style: TextStyle(color: Colors.white))),
        BottomNavyBarItem(
            icon: Icon(
              Icons.workspaces_outline,
              color: Palette.purple,
            ),
            activeColor: Palette.purple.shade50,
            title: Text('Principal', style: TextStyle(color: Colors.white))),
        BottomNavyBarItem(
            icon: Icon(
              Icons.dashboard,
              color: Palette.purple,
            ),
            activeColor: Palette.purple.shade50,
            title: Text('Caixas', style: TextStyle(color: Colors.white)))
      ],
    );
  }

  Widget barraDeNavegacaoChefeInferior() {
    return BottomNavyBar(
      selectedIndex: selectedIndexChefe,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => selectedIndexChefe = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            icon: Icon(
              Icons.business,
              color: Palette.purple,
            ),
            activeColor: Palette.purple.shade50,
            title: Text(
              'Minha Empresa',
              style: TextStyle(color: Colors.white),
            )),
        BottomNavyBarItem(
            icon: Icon(
              Icons.workspaces_outline,
              color: Palette.purple,
            ),
            activeColor: Palette.purple.shade50,
            title: Text('Principal', style: TextStyle(color: Colors.white))),
        BottomNavyBarItem(
            icon: Icon(
              Icons.dashboard,
              color: Palette.purple,
            ),
            activeColor: Palette.purple.shade50,
            title: Text('Caixas', style: TextStyle(color: Colors.white)))
      ],
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndexChefe = index;
      selectedIndexEmpregado = index;
      selectedIndexNovoUser = index;
    });
  }
}
