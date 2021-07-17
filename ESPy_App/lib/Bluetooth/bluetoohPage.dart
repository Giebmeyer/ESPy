import 'package:ESPy/Bluetooth/listaDispositivos.dart';
import 'package:ESPy/Funcoes/classPalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Bluetooth extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BluetoothState();
  }
}

class BluetoothState extends State<Bluetooth> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FlutterBluetoothSerial.instance.requestEnable(),
        builder: (context, future) {
          if (future.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                child: Center(
                  child: Icon(
                    Icons.bluetooth_disabled,
                    size: 200.0,
                  ),
                ),
              ),
            );
          } else {
            return ListaDispositivos();
          }
        },
        // child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
