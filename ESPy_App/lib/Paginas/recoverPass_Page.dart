import 'dart:convert';
import 'package:ESPy/Funcoes/appWidget.dart';
import 'package:ESPy/Paginas/login_Page.dart';
import 'package:ESPy/main.dart';
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
  String email = '';
  String msgErro = '';
  bool erro, showProgress;
//==============================================================================
  _ColetaDadosUsuario() async {
    final response = await http.post(
      Uri.parse(ESPy_url + '/ESPy_coletaDadosUsuario.php'),
      body: {
        "email": email,
      },
    );
    var jsondata = json.decode(response.body);

    if (response.statusCode == 200) {
      msgErro = jsondata["mensagemColetaUser"];
      user.codigo = jsondata['codigo'];
      user.nome = jsondata['nome'];
      print(user.nome);
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
      user.usuario_empregado = jsondata['usuario_empregado'];

      if (mandaEmailRecuperacaoSenha(email) != false) {
        showCaixaDialogoRapida(context, "Email enviado", 'login', 1);
      } else {
        showCaixaDialogoSimples(
            context, "Ocorreu um erro ao enviar o email para ${email}");
      }
    } else {
      setState(() {
        erro = true;
        msgErro = jsondata["mensagemColetaUser"];
        showCaixaDialogoSimples(context, msgErro);
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
                  onChanged: (emailx) {
                    email = emailx;
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  keyboardType: TextInputType.emailAddress),
              SizedBox(height: 10.0),
              FlatButton(
                focusColor: Palette.purple.shade50,
                onPressed: () {
                  _ColetaDadosUsuario();
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
