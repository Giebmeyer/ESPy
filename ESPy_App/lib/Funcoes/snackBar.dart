import 'package:flutter/material.dart';

//Erros:
final erroLogin = SnackBar(content: Text('Email ou senha inválidos.'));
final erroDivergenciaSenha = SnackBar(content: Text('Senhas divergentes.'));
final erroSenha = SnackBar(content: Text('Senha inválida.'));
final erroEmail = SnackBar(content: Text('Email inválido.'));

//Sucessos:
final sucessCadastro =
    SnackBar(content: Text('Cadastro realizado com sucesso!'));
final secessSendEmail = SnackBar(content: Text('Email enviado com sucesso!'));
