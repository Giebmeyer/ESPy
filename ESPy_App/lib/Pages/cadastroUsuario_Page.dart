import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/classPalette.dart';
import 'package:ESPy/Funcoes/snackBar.dart';
import 'package:ESPy/Funcoes/variaveis.dart';
import 'package:ESPy/Pages/login_Page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CadastroUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _cadastroUserPageState();
  }
}

class _cadastroUserPageState extends State<CadastroUserPage> {
/*   String nome = '';
  String email = '';
  String senha = '';
  String confirmacaoSenha = '';
  int cpf;
  int telefone;
  String estado = '';
  String cidade = '';
  String bairro = '';
  String rua = '';
  int numero;
  String complemento = ''; */

  @override
  Widget build(BuildContext context) {
    TextEditingController nome = new TextEditingController();
    TextEditingController senha = new TextEditingController();
    TextEditingController confirmacaoSenha = new TextEditingController();
    TextEditingController email = new TextEditingController();
    TextEditingController cpf = new TextEditingController();
    TextEditingController telefone = new TextEditingController();
    TextEditingController estado = new TextEditingController();
    TextEditingController cidade = new TextEditingController();
    TextEditingController bairro = new TextEditingController();
    TextEditingController rua = new TextEditingController();
    TextEditingController numero = new TextEditingController();
    TextEditingController complemento = new TextEditingController();

    Future<List> cadastraUsuario() async {
      final response = await http.post(
          Uri.parse(
              'http://192.168.66.109/ESPy/ESPy_App/ESPy_app/lib/MySql/insert.php'),
          body: {
            "nome": nome.text,
            "senha": senha.text,
            "email": email.text,
            "cpf": cpf.text,
            "telefone": telefone.text,
            "estado": estado.text,
            "cidade": cidade.text,
            "rua": rua.text,
            "numero": numero.text,
            "complemento": complemento.text,
          });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de usuário'),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
          width: 400,
          child: ListView(children: [
            SizedBox(height: 50),
//==============================================================================
            TextField(
                controller: nome,
                decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                keyboardType: TextInputType.emailAddress),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                controller: email,
                decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                keyboardType: TextInputType.emailAddress),
            SizedBox(height: 10),
//==============================================================================
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 170,
                      child: TextField(
                          controller: senha,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Senha',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)))),
                    ),
//==================
                    Container(
                      width: 170,
                      child: TextField(
                          controller: confirmacaoSenha,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Confirmar senha',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)))),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                controller: cpf,
                decoration: InputDecoration(
                    labelText: 'CPF',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                controller: telefone,
                decoration: InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                controller: estado,
                decoration: InputDecoration(
                    labelText: 'Estado',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                controller: cidade,
                decoration: InputDecoration(
                    labelText: 'Cidade',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                controller: bairro,
                decoration: InputDecoration(
                    labelText: 'bairro',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                controller: rua,
                decoration: InputDecoration(
                    labelText: 'rua',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                controller: numero,
                decoration: InputDecoration(
                    labelText: 'numero',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 20),
//==============================================================================
            TextField(
                controller: complemento,
                decoration: InputDecoration(
                    labelText: 'Complemento',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 20),
//==============================================================================
            FlatButton(
              onPressed: () {
                cadastraUsuario;
              },
              child: const Text('Enviar'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Palette.purple)),
            ),
          ]),
        )));
  }

  void _verificaCadastro() {
    if (VALIDACAO == true) {
      ScaffoldMessenger.of(context).showSnackBar(sucessCadastro);
      Navigator.pop(context);
    }
    if (VALIDACAO == false) {
      ScaffoldMessenger.of(context).showSnackBar(erroDivergenciaSenha);
    }
  }
}
