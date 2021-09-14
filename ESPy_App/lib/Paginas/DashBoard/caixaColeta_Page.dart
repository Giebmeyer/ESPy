import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/sensores.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

String tituloPage;

class CaixaColetaPage extends StatefulWidget {
  @override
  _CaixaColetaPageState createState() => _CaixaColetaPageState();
}

class _CaixaColetaPageState extends State<CaixaColetaPage> {
  @override
  void initState() {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(updateStatus);
    super.initState();
  }

//==============================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sensor.nomeCaixa),
        centerTitle: true,
      ),
      body: showOpcaoCaixaColeta(),
    );
  }

  Widget showOpcaoCaixaColeta() {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
      decoration: new BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Palette.purple.shade900,
          Palette.purple.shade50,
        ],
      )),
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: FlatButton(
                          focusColor: Palette.purple.shade50,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/Bluetooth');
                          },
                          child: Text(
                            "Configuração Bluetooth",
                            style: TextStyle(color: Palette.purple),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Palette.purple),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                      Container(
                        child: FlatButton(
                          focusColor: Palette.purple.shade50,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/senhaConfig');
                          },
                          child: Text(
                            "Configuração do tempo de coleta",
                            style: TextStyle(color: Palette.purple),
                            textAlign: TextAlign.center,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Palette.purple),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                      Container(
                        child: FlatButton(
                          focusColor: Palette.purple.shade50,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/dashBoard');
                          },
                          child: Text(
                            "Dashboard",
                            style: TextStyle(color: Palette.purple),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Palette.purple),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(115.0),
                topRight: const Radius.circular(115.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
