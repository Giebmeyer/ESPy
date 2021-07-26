import 'package:ESPy/Classes/usuario.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

String _username;
var smtpServer;

Email(String username, String password) {
  smtpServer = gmail(username, password);
}

//Envia um email para o destinatário, contendo a mensagem com o nome do sorteado
Future<bool> sendMessage(
    String mensagem, String destinatario, String assunto) async {
  abrirEmail();
  //Configurar a mensagem
  final message = Message()
    ..from = Address(_username, 'ESPy')
    ..recipients.add(destinatario)
    ..subject = assunto
    ..text = mensagem;

  try {
    final sendReport = await send(message, smtpServer);
    print('Messagem enviada: ' + sendReport.toString());

    return true;
  } on MailerException catch (e) {
    print('Message não enviada.');
    for (var p in e.problems) {
      print('Problema: ${p.code}: ${p.msg}');
    }
    return false;
  }
}

void sendEmail(String email) async {
  var emailEspy = Email('ESPy.EnviaEmail@gmail.com', '@EspySendEmail');
  var momento = DateTime.now();

  var dataFomatada =
      DateFormat(" d / MM / y 'as' hh:mm:ss", "pt_BR").format(momento);

  var senha = user.senha;
  var nome = user.nome;
  var destinatario = 'giebmeyerthiago@gmail.com';

  String _assunto = 'ESPy - Email de recuperação de senha.';
  String _mensagem = 'X';
  /* 'Olá, ' +
      '$nome' +
      '\nRecebemos uma solicitação para restaurar sua senha de acesso em nosso site.\nEla ocorreu em ' +
      '$dataFomatada' +
      '\nSua senha é: ' +
      '$senha'; */

  bool result = await sendMessage(_mensagem, destinatario, _assunto);
}

abrirEmail() async {
  const url = 'https://www.gmail.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Não foi possivel abrir: $url';
  }
}
