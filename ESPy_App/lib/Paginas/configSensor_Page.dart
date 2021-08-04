import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class configSensor extends StatefulWidget {
  @override
  _configSensorState createState() => _configSensorState();
}

class _configSensorState extends State<configSensor> {
  @override
  void initState() {
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(updateStatus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        centerTitle: true,
      ),
      body: Container(
        /*  width: MediaQuery.of(context).size.width * 0.50, */
        child: Container(
          padding: const EdgeInsets.only(top: 50.0),
          decoration: new BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Palette.purple.shade900,
              Palette.purple.shade50,
            ],
          )),
          child: Container(
            decoration: new BoxDecoration(),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Align(
                  alignment: Alignment.center,
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
        ),
      ),
    );
  }
}
