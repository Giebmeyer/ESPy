import 'package:ESPy/Bluetooth/bluetoohPage.dart';
import 'package:ESPy/Bluetooth/chatPage.dart';
import 'package:ESPy/Pages/configSensor_Page.dart';
import 'package:ESPy/Pages/dashBoard_Page.dart';
import 'package:ESPy/Pages/login_Page.dart';
import 'package:ESPy/Pages/Empresa_Page.dart';
import 'package:flutter/material.dart';

import '../Pages/home_Page.dart';
import '../Classes/palette.dart';

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
      hint: Text("Tempo"),
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

class botaoSair extends StatefulWidget {
  @override
  _botaoSairState createState() => _botaoSairState();
}

class _botaoSairState extends State<botaoSair> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.center,
      icon: Icon(Icons.door_back),
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
      },
    );
  }
}

class botaoAtualizar extends StatefulWidget {
  @override
  _botaoAtualizarState createState() => _botaoAtualizarState();
}

class _botaoAtualizarState extends State<botaoAtualizar> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.center,
      icon: Icon(Icons.restart_alt),
      onPressed: () {
        setState(() {});
      },
    );
  }
}

class botaoCalendario extends StatefulWidget {
  @override
  _botaoCalendarioState createState() => _botaoCalendarioState();
}

TextEditingController dataSelecionada = TextEditingController();
var dataSelecionadaAtual = dataSelecionada;

class _botaoCalendarioState extends State<botaoCalendario> {
  DateTime _date = DateTime.now();

  Future<Null> _selectcDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      cancelText: "Cancelar",
      confirmText: "Filtrar",
      helpText: "Selecione a data desejada:",
      context: context,
      initialDate: _date,
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _date) {
      setState(() {
        dataSelecionada.text = picked.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        heroTag: "Botão de calendário",
        backgroundColor: Palette.purple,
        onPressed: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectcDate(context);
        },
        child: Icon(Icons.calendar_today));
    ;
  }
}
