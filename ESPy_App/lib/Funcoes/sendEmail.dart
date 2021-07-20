import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'BD.dart';

String _username;
var smtpServer;

Email(String username, String password) {
  _username = username;
  smtpServer = gmail(_username, password);
}

//Envia um email para o destinatário, contendo a mensagem com o nome do sorteado
Future<bool> sendMessage(
    String mensagem, String destinatario, String assunto) async {
  /* abrirEmail(); */
  //Configurar a mensagem
  final message = Message()
    ..from = Address(_username, 'Nome')
    ..recipients.add(destinatario)
    ..subject = assunto
    ..text = mensagem;

  try {
    final sendReport = await send(message, smtpServer);
    print('Messagem enviada:: ' + sendReport.toString());

    return true;
  } on MailerException catch (e) {
    print('Message não enviada.');
    for (var p in e.problems) {
      print('Problema: ${p.code}: ${p.msg}');
    }
    return false;
  }
}

/* abrirEmail() async {
  const url = 'https://gmail.com/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Não foi possivel abrir: $url';
  }
} */

void sendEmail(String email) async {
  var momento = DateTime.now();

  DateFormat(" d 'de' MMMM 'de' y ", "pt_BR").format(momento);

  String _assunto = 'ESPy - Email de recuperação de senha.';
  String _mensagem = 'Olá, ' +
      user.nome +
      ',\nRecebemos uma solicitação para restaurar sua senha de acesso em nosso site.\nEla ocorreu em ' +
      '$momento' +
      '.\nSua senha é: ' +
      user.senha;

  bool result = await sendMessage(_mensagem, email, _assunto);
}
