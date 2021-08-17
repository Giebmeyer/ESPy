import 'dart:async';
import 'package:ESPy/Paginas/login_Page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
              "Voltar",
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

abrirUrl(var url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
