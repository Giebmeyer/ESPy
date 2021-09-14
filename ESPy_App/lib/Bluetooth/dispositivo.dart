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
  }
}
