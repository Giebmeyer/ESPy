import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Classes/palette.dart';
import 'package:flutter/material.dart';
import '../Funcoes/sendEmail.dart';

class recoverPassPage extends StatefulWidget {
  @override
  _recoverPassPageState createState() => _recoverPassPageState();
}

class _recoverPassPageState extends State<recoverPassPage> {
//==============================================================================
  String msgErro = '';
  bool erro, showProgress;

  _ColetaDadosUsuario() async {
    final response = await http.post(
      Uri.parse(
          'http://192.168.66.109/ESPy/ESPy_MySql/ESPy_coletaDadosUsuario.php'),
      body: {
        "email": email1,
      },
    );

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);

      user.codigo = jsondata['codigo'];
      user.nome = jsondata['nome'];
      user.senha = jsondata['senha'];
      user.email = jsondata['email'];
      user.cpf = jsondata['cpf'];
      user.telefone = jsondata['telefone'];
      user.estado = jsondata['estado'];
      user.cidade = jsondata['cidade'];
      user.bairro = jsondata['bairro'];
      user.rua = jsondata['rua'];
      user.numero = jsondata['numero'];
      user.complemento = jsondata['complemento'];
      user.usuario_chefe = jsondata['usuario_chefe'];
    } else {
      setState(() {
        showProgress = false;
        erro = true;
        msgErro = "Erro na conexão com o servidor.";
      });
    }
  }

//==============================================================================
  @override
  void initState() {
    erro = false;
    showProgress = false;

    super.initState();
  }

//==============================================================================

  var email1;
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
                    email1 = email;
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  keyboardType: TextInputType.emailAddress),
              SizedBox(height: 10.0),
              FlatButton(
                onPressed: () {
                  _ColetaDadosUsuario();
                  print(email1);
                  sendEmail(email1);
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
