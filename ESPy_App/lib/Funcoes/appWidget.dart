import 'dart:async';
import 'package:ESPy/Paginas/Usuario/login_Page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import '../Classes/palette.dart';

//==============================================================================
String dropdownValueEstado;
String dropdownValueTempoColeta;

//==============================================================================
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

//==============================================================================
void showCaixaDialogoSimples(BuildContext context, String msg) {
  // configura o button
  Widget okButton = FlatButton(
    minWidth: MediaQuery.of(context).size.width * 0.90,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Palette.purple)),
    child: Text(
      "Ok",
      textAlign: TextAlign.center,
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alerta = AlertDialog(
      title: Text(msg, style: TextStyle(), textAlign: TextAlign.center),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      actions: [
        okButton,
      ]);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alerta;
    },
  );
}

//==============================================================================
void showCaixaDialogoRapida(
    BuildContext context, String msg, var paginaDestino, var duracao) {
  showDialog(
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: duracao), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/${paginaDestino}', (route) => false);
        });
        return AlertDialog(
          title: Text(msg),
        );
      });
}

//==============================================================================
class botaoSair extends StatefulWidget {
  @override
  _botaoSairState createState() => _botaoSairState();
}

class _botaoSairState extends State<botaoSair> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.center,
      icon: Icon(Icons.exit_to_app_outlined),
      onPressed: () {
        showCaixaDialogoAvancada(context, "Deseja realmente sair?");
      },
    );
  }

  void showCaixaDialogoAvancada(BuildContext context, String msg) {
    // configura o button

    Widget cancelaButton, confirmaButton;

    Widget linhaBotoes() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          cancelaButton = FlatButton(
            minWidth: MediaQuery.of(context).size.width * 0.25,
            shape: RoundedRectangleBorder(),
            child: Text(
              "Cancelar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          confirmaButton = FlatButton(
            minWidth: MediaQuery.of(context).size.width * 0.25,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Palette.purple)),
            child: Text(
              "Sair",
              textAlign: TextAlign.center,
              style: TextStyle(color: Palette.purple),
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      );
    }

    AlertDialog alerta = AlertDialog(
        title: Text(msg, style: TextStyle(), textAlign: TextAlign.center),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        actions: [linhaBotoes()]);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}

//==============================================================================
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

//==============================================================================
BoxDecoration myBoxDecoration(double border, double radius, Color corBorda) {
  return BoxDecoration(
    border: Border.all(width: border, color: corBorda),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

//==============================================================================

StreamSubscription<ConnectivityResult> connectivitySubscription;
final Connectivity _connectivity = Connectivity();

void updateStatus(ConnectivityResult connectivityResult) async {
  if (connectivityResult == ConnectivityResult.mobile) {
    print("3G/4G");
  } else if (connectivityResult == ConnectivityResult.wifi) {
    String wifiName = await _connectivity.getWifiName();
    String wifiSsid = await _connectivity.getWifiBSSID();
    String wifiIp = await _connectivity.getWifiIP();
    print("Wi-Fi\n$wifiName\n$wifiSsid\n$wifiIp");
  } else {
    Container(
      child: Text("Sem rede"),
    );
  }
}

@override
void dispose() {
  connectivitySubscription.cancel();
}

//==============================================================================

