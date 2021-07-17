import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/classPalette.dart';
import 'package:ESPy/Funcoes/BD.dart';
import 'package:ESPy/Funcoes/snackBar.dart';
import 'package:ESPy/Pages/recoverPass_Page.dart';
import 'package:flutter/material.dart';

import 'cadastroUsuario_Page.dart';
import 'home_Page.dart';
import 'homePage_Chefe.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _loginPageState();
  }
}

class _loginPageState extends State<LoginPage> {
  String _email = '';
  String _auxEmail = '';
  String _senha = '';
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
          width: 400,
          child: ListView(
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset('assents/imagens/Logo.png'),
                  height: 300,
                ),
              ),
//==============================================================================
              TextFormField(
                  onChanged: (email) {
                    _email = email;
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  keyboardType: TextInputType.emailAddress),
              SizedBox(height: 10),
//==============================================================================
              TextFormField(
                  onChanged: (senha) {
                    _senha = senha;
                  },
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Palette.purple)),
                    onPressed: () {
                      coletaDadosUsuario(_email);
                      verificaLogin(_email, _senha);
                    },
                    child: const Text('Entrar'),
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
      ),
    );
  }

  void verificaLogin(String _email, String _senha) {
    var db = new Mysql();
    db.getConnection().then((conn) {
      conn
          .query(
              "select email, senha, usuario_chefe from usuarios where email = " +
                  "'$_email'" +
                  ";")
          .then(((results) {
        print(
            "select email, senha, usuario_chefe from usuarios where email = " +
                "'$_email'" +
                ";");
        for (var collum in results) {
          if (_email == collum[0] && _senha == collum[1]) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(erroLogin);
          }
        }
        conn.close();
      }));
    });
  }
}
