import 'package:ESPy/Bluetooth/bluetoohPage.dart';
import 'package:ESPy/Bluetooth/chatPage.dart';
import 'package:ESPy/Pages/configSensor_Page.dart';
import 'package:ESPy/Pages/dashBoard_Page.dart';
import 'package:ESPy/Pages/login_Page.dart';
import 'package:ESPy/Pages/minhaEmpresa_Page.dart';
import 'package:flutter/material.dart';

import '../Pages/home_Page.dart';
import '../Classes/palette.dart';

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
}

class barraDeNavegacaoInferiorEmpregado extends StatefulWidget {
  @override
  _barraDeNavegacaoInferiorEmpregadoState createState() =>
      _barraDeNavegacaoInferiorEmpregadoState();
}

class _barraDeNavegacaoInferiorEmpregadoState
    extends State<barraDeNavegacaoInferiorEmpregado> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
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
          MaterialPageRoute(builder: (context) => minhaEmpresaPage()));
    }
    if (index == 1) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    }
    if (index == 2) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => dashBoard()));
    }
  }
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

    if (index == 0 && msgConectadoBool == true) {
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
}

String dropdownValueEstado;
String dropdownValueTempoColeta;

class dropDownEstados extends StatefulWidget {
  @override
  _dropDownEstadosState createState() => _dropDownEstadosState();
}

class _dropDownEstadosState extends State<dropDownEstados> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValueEstado,
      items: <String>[
        'AC',
        'AL',
        'AP',
        'AM',
        'BA',
        'CE',
        'DF',
        'ES',
        'GO',
        'MA',
        'MT',
        'MS',
        'MG',
        'PA',
        'PB',
        'PR',
        'PE',
        'PI',
        'RJ',
        'RN',
        'RS',
        'RO',
        'RR',
        'SC',
        'SP',
        'SE',
        'TO',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: Text("Estado"),
      style: const TextStyle(color: Palette.purple),
      underline: Container(
        height: 2,
        color: Palette.purple,
      ),
      alignment: Alignment.bottomLeft,
      onChanged: (String newValue) {
        setState(() {
          dropdownValueEstado = newValue;
        });
      },
    );
  }
}

class dropDownTempoColeta extends StatefulWidget {
  @override
  _dropDownTempoColetaState createState() => _dropDownTempoColetaState();
}

class _dropDownTempoColetaState extends State<dropDownTempoColeta> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValueEstado,
      items: <String>[
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12',
        '13',
        '14',
        '15',
        '16',
        '17',
        '18',
        '19',
        '20',
        '21',
        '22',
        '23',
        '24',
        '25',
        '26',
        '27',
        '28',
        '29',
        '30',
        '31',
        '32',
        '33',
        '34',
        '35',
        '36',
        '37',
        '38',
        '39',
        '40',
        '41',
        '42',
        '43',
        '44',
        '45',
        '46',
        '47',
        '48',
        '49',
        '50',
        '51',
        '52',
        '53',
        '54',
        '55',
        '56',
        '57',
        '58',
        '59',
        '60'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: Text("Estado"),
      menuMaxHeight: MediaQuery.of(context).size.width * 0.60,
      style: const TextStyle(color: Palette.purple),
      alignment: Alignment.bottomCenter,
      underline: Container(
        height: 2,
        color: Palette.purple,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValueEstado = newValue;
        });
      },
    );
  }
}

showCaixaDialogoSimples(BuildContext context, String msg, bool funcBotao) {
  // configura o button
  Widget okButton = FlatButton(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Palette.purple)),
    child: Text(
      "OK",
      textAlign: TextAlign.center,
    ),
    onPressed: () {
      if (funcBotao == true) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        Navigator.of(context).pop();
      }
    },
  );

  AlertDialog alerta = AlertDialog(
    title: Text(msg),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}
