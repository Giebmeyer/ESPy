import 'package:ESPy/Classes/palette.dart';
import 'package:flutter/material.dart';

//Erros:
final erroLogin = SnackBar(
  content: Text('Email ou senha inválidos.',
      style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
  ),
  backgroundColor: Palette.purple,
);
final erroDivergenciaSenha = SnackBar(
  content: Text('Senhas divergentes.',
      style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
  ),
  backgroundColor: Palette.purple,
);
final erroSenha = SnackBar(
  content: Text('Senha inválida.',
      style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
  ),
  backgroundColor: Palette.purple,
);
final erroEmail = SnackBar(
  content: Text('Email inválido.',
      style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
  ),
  backgroundColor: Palette.purple,
);
final falhaRealizarAcao = SnackBar(
  content: Text('Falha no realizar ação.',
      style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
  ),
  duration: const Duration(seconds: 1),
  backgroundColor: Palette.purple,
);

//Sucessos:
final sucessCadastro = SnackBar(
  content: Text('Cadastro realizado com sucesso!',
      style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
  ),
  backgroundColor: Palette.purple,
);
final secessSendEmail = SnackBar(
  content: Text('Email enviado com sucesso!',
      style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
  ),
  backgroundColor: Palette.purple,
);
final sucessRealizarAcao = SnackBar(
  content: Text('Ação realizada com sucesso!',
      style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
  ),
  duration: const Duration(seconds: 1),
  backgroundColor: Palette.purple,
);
