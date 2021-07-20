import 'dart:convert';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/classPalette.dart';
import 'package:ESPy/Pages/cadastroUsuario_Page.dart';
import 'package:ESPy/Pages/recoverPass_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_Page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _loginPageState();
  }
}

class _loginPageState extends State<LoginPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController senha = new TextEditingController();

//==============================================================================
  String msgErro = '';
  bool erro, showProgress;

  _login() async {
    final response = await http.post(
      Uri.parse('http://192.168.66.109/ESPy/ESPy_MySql/ESPy_login.php'),
      body: {
        "email": email.text,
        "senha": senha.text,
      },
    );

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata["erro"]) {
        setState(() {
          showProgress = false;
          erro = true;
          msgErro = jsondata["messagem"];
        });
      } else {
        if (jsondata["sucesso"]) {
          setState(() {
            erro = false;
            showProgress = false;
          });
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
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          showProgress = false;
          erro = true;
          msgErro = "Algo deu errado.";
        }
      }
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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.97,
            child: ListView(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.45,
                    alignment: Alignment.center,
                    child: Image.asset('assents/imagens/Logo.png'),
                  ),
                ),
//==============================================================================
                TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    keyboardType: TextInputType.emailAddress),
                SizedBox(height: 10),
//==============================================================================
                TextFormField(
                    controller: senha,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Senha',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)))),
//==============================================================================
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => recoverPassPage()));
                    },
                    child: Text(
                      "Esqueci minha senha",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.grey, fontSize: 13.0),
                    ),
                  ),
                ),
//==============================================================================
                Align(
                  child: Container(
                    width: 200,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          showProgress = true;
                        });
                        _login();
                      },
                      child: ApresentaProgresso(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Palette.purple)),
                    ),
                  ),
                ),
//==============================================================================
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CadastroUserPage()));
                  },
                  child: Text(
                    "Não possui login? Cadastre-se",
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.grey, fontSize: 13.0),
                  ),
                ),
//==============================================================================
              ],
            ),
          ),
        ));
  }

//==============================================================================
  Widget ApresentaProgresso() {
    return showProgress
        ? SizedBox(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(
              backgroundColor: (Palette.purple.shade100),
              valueColor: AlwaysStoppedAnimation<Color>(Palette.purple),
            ),
          )
        : Text(
            "Entrar",
            style: TextStyle(color: Palette.purple),
          );
  }
}
