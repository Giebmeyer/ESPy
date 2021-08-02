import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:flutter/material.dart';

class configSensor extends StatefulWidget {
  @override
  _configSensorState createState() => _configSensorState();
}

class _configSensorState extends State<configSensor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        centerTitle: true,
      ),
      body: Container(
        /*  width: MediaQuery.of(context).size.width * 0.50, */
        child: dropDownTempoColeta(),
      ),
    );
  }
}
