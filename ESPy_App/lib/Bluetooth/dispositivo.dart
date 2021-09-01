import 'package:ESPy/Classes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  final Function onTap;
  final BluetoothDevice device;

  BluetoothDeviceListEntry({this.onTap, @required this.device});

  @override
  Widget build(BuildContext context) {
    return verificaNome();
  }

  Widget verificaNome() {
    if (device.name == "ESPy") {
      return ListTile(
        onTap: onTap,
        leading: Icon(Icons.devices),
        title: Text(device.name ?? "Dispositivo Desconhecido"),
        subtitle: Text(device.address.toString()),
        trailing: FlatButton(
          child: Text('Conectar'),
          onPressed: onTap,
        ),
      );
    } else {
      return Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "O seu dispositivo ainda não foi pareado com nenhum sistema ESPy.",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center),
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
}
