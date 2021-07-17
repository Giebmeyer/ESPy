import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/classPalette.dart';
import 'package:flutter/material.dart';
import '../Funcoes/sendEmail.dart';

class recoverPassPage extends StatefulWidget {
  @override
  _recoverPassPageState createState() => _recoverPassPageState();
}

class _recoverPassPageState extends State<recoverPassPage> {
  var emailEspy = Email('ESPy.EnviaEmail@gmail.com', '@EspySendEmail');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperação de senha'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
//==============================================================================
              TextField(
                  onChanged: (email) {
                    // coletaDadosUsuario(user.email);
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  keyboardType: TextInputType.emailAddress),
              SizedBox(height: 10.0),
              FlatButton(
                onPressed: () {
                  verificaEmail_EnviaEmail(user.email);
                },
                child: const Text('Recuperar'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Palette.purple)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
