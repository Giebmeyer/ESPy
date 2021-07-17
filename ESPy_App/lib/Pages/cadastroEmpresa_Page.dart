import 'package:ESPy/Classes/Empresa.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/classPalette.dart';
import 'package:ESPy/Funcoes/snackBar.dart';
import 'package:ESPy/Funcoes/variaveis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class cadastroEmpresaPage extends StatefulWidget {
  @override
  _cadastroEmpresaState createState() => _cadastroEmpresaState();
}

class _cadastroEmpresaState extends State<cadastroEmpresaPage> {
  void initState() {
    super.initState();
  }

  String _nome;
  String _CEO;
  String _telefone;
  String _cnpj;
  String _estado;
  String _cidade;
  String _bairro;
  String _rua;
  String _numero;
  String _complemento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de empresa'),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
          width: 400,
          child: ListView(children: [
            SizedBox(height: 10),
//==============================================================================
            TextField(
                onChanged: (nome) {
                  _nome = nome;
                },
                decoration: InputDecoration(
                    labelText: 'Nome da empresa',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                keyboardType: TextInputType.emailAddress),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                onChanged: (ceo) {
                  _CEO = ceo;
                },
                decoration: InputDecoration(
                    labelText: 'Nome do CEO da empresa',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0))),
                keyboardType: TextInputType.emailAddress),
            SizedBox(height: 10),
//==============================================================================
            TextField(
              onChanged: (cnpj) {
                _cnpj = cnpj;
              },
              decoration: InputDecoration(
                  labelText: 'CPF/CNPJ',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
            ),
            SizedBox(height: 10),
//==============================================================================
            TextField(
              onChanged: (telefone) {
                _telefone = telefone;
              },
              decoration: InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
            ),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                onChanged: (estado) {
                  _estado = estado;
                },
                decoration: InputDecoration(
                    labelText: 'Estado',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                onChanged: (cidade) {
                  _cidade = cidade;
                },
                decoration: InputDecoration(
                    labelText: 'Cidade',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                onChanged: (bairro) {
                  _bairro = bairro;
                },
                decoration: InputDecoration(
                    labelText: 'Bairro',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
                onChanged: (rua) {
                  _rua = rua;
                },
                decoration: InputDecoration(
                    labelText: 'Rua',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 10),
//==============================================================================
            TextField(
              onChanged: (numero) {
                _numero = numero;
              },
              decoration: InputDecoration(
                  labelText: 'Número',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
//==============================================================================
            TextField(
                onChanged: (complemento) {
                  _complemento = complemento;
                },
                decoration: InputDecoration(
                    labelText: 'Complemento',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)))),
            SizedBox(height: 20),
//==============================================================================
            FlatButton(
              onPressed: () {
                cadastroEmpresa(_nome, _CEO, user.email, _telefone, _cnpj,
                    _estado, _cidade, _bairro, _rua, _numero, _complemento);
              },
              child: const Text('Enviar'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: Palette.purple)),
            ),
            SizedBox(height: 50),
//==============================================================================
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
