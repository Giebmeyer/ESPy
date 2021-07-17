import 'package:ESPy/Classes/usuario.dart';
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
      bottomNavigationBar: barraDeNavegacaoInferior_Retorno(),
    );
  }
}
