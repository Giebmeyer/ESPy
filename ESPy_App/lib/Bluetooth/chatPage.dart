import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:ESPy/Classes/sensores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

bool msgConectadoBool = false;
bool confirmaEnvioBool = false;

class ChatPage extends StatefulWidget {
  final BluetoothDevice server;

  const ChatPage({this.server});

  @override
  _ChatPage createState() => new _ChatPage();
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}

class _ChatPage extends State<ChatPage> {
  String _rede = '';
  String _senha = '';
  String _RedeSenha = '';
  String _codigoEmpresa = emp.codigo.toString();
  String _mensagemFinal = '';
  static final clientID = 0;
  var connection; //BluetoothConnection

  List<_Message> messages = [];
  String _messageBuffer = '';
  final TextEditingController _redeController = new TextEditingController();
  final TextEditingController _senhaController = new TextEditingController();
  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Conecte-se a um dispositivo');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection.input.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected()) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Row> list = messages.map((_message) {
      return Row(
        children: <Widget>[
          Container(
            child: Text(
                (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: TextStyle(color: Colors.white)),
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color: _message.whom == clientID ? Palette.purple : Colors.grey,
                borderRadius: BorderRadius.circular(12.0)),
          ),
        ],
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: (isConnecting
            ? Text(widget.server.name + '...')
            : isConnected()
                ? Text(widget.server.name)
                : Text(widget.server.name)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView(
                  padding: const EdgeInsets.all(12.0),
                  controller: listScrollController,
                  children: list),
            ),
            Container(
              color: Palette.purple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _redeController,
                        onChanged: (rede) {
                          _rede = rede;
                        },
                        style: const TextStyle(
                            color: Palette.purple, fontSize: 15.0),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          hintText: isConnecting
                              ? 'Aguarde...'
                              : isConnected()
                                  ? 'Rede'
                                  : 'Chat desconectado',
                          hintStyle: TextStyle(color: Palette.purple),
                        ),
                        enabled: isConnected(),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      child: TextField(
                        controller: _senhaController,
                        onChanged: (senha) {
                          if (senha.length == 0 || senha == null) {
                            senha = 'semSenha';
                            _senha = senha;
                        
                          }else{
                             _senha = senha;
                          }
                            _RedeSenha = _rede.trim() + ';' + _senha.trim();
                          _mensagemFinal = _RedeSenha.trim() +
                              ';' +
                              _codigoEmpresa.trim() +
                              ';' +
                              sensor.codigoCaixa.toString().trim();
                        },
                        style: const TextStyle(
                            color: Palette.purple, fontSize: 15.0),
                        /* obscureText: true, */
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          hintText: isConnecting
                              ? 'Aguarde...'
                              : isConnected()
                                  ? 'Senha'
                                  : '',
                          hintStyle: const TextStyle(color: Palette.purple),
                        ),
                        enabled: isConnected(),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(2.0),
                    child: IconButton(
                        icon: const Icon(Icons.send_outlined,
                            color: Colors.white),
                        onPressed: isConnected()
                            ? () => showCaixaDialogoAvancada(
                                context, "Rede: ${_rede}\nSenha: ${_senha}")
                            : null),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
          _Message(
            1,
            backspacesCounter > 0
                ? _messageBuffer.substring(
                    0, _messageBuffer.length - backspacesCounter)
                : _messageBuffer + dataString.substring(0, index),
          ),
        );
        _messageBuffer = dataString.substring(index);
      });
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String _RedeSenha) async {
    _RedeSenha = _RedeSenha.trim();
    _redeController.clear();
    _senhaController.clear();

    try {
      connection.output.add(utf8.encode(_RedeSenha + "\r\n"));
      await connection.output.allSent;

      setState(() {
        messages.add(_Message(clientID, _RedeSenha));
      });

      Future.delayed(Duration(milliseconds: 333)).then((_) {
        listScrollController.animateTo(
            listScrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 333),
            curve: Curves.easeOut);
      });
    } catch (e) {
      // Ignore error, but notify state
      setState(() {});
    }
  }

  bool isConnected() {
    return connection != null && connection.isConnected;
  }

  void confirmaEnvio() {
    if (confirmaEnvioBool == true) {
      setState(() {});
      _sendMessage(_mensagemFinal);
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
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
              confirmaEnvioBool = false;
              confirmaEnvio();
            },
          ),
          confirmaButton = FlatButton(
            minWidth: MediaQuery.of(context).size.width * 0.25,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Palette.purple)),
            child: Text(
              "Confirmar",
              textAlign: TextAlign.center,
              style: TextStyle(color: Palette.purple),
            ),
            onPressed: () {
              confirmaEnvioBool = true;
              confirmaEnvio();
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
