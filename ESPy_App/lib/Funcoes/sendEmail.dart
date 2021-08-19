import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> mandaEmailRecuperacaoSenha(var _emailDestinatario) async {
  var dataFomatada =
      DateFormat(" d / MM / y 'as' hh:mm:ss", "pt_BR").format(DateTime.now());

  String _username = 'ESPy.EnviaEmail@gmail.com';
  String _password = '@EspySendEmail';

  final smtpServer = gmail(_username, _password);

  final message = Message()
    ..from = Address(_username, 'ESPy')
    ..recipients.add(_emailDestinatario) //Email de quem irá receber o email.
    ..subject = 'ESPy - Email de recuperação de senha' //Titulo do email.
    ..text =
        'Olá ${user.nome},\nRecebemos uma solicitação para recuperar sua senha de acesso em nosso site.\nEla ocorreu em ${dataFomatada}\nA sua senha é ${user.senha}'; //corpo do email
  try {
    final sendReport = await send(message, smtpServer);
    return true;
  } on MailerException catch (e) {
    return false;
  }
}

Future<bool> mandaEmailFuncionarioEntrouEmpresa(var _emailDestinatario) async {
  var dataFomatada =
      DateFormat(" d/MM/y 'as' hh:mm:ss", "pt_BR").format(DateTime.now());

  String _username = 'ESPy.EnviaEmail@gmail.com';
  String _password = '@EspySendEmail';

  final smtpServer = gmail(_username, _password);

  final message = Message()
    ..from = Address(_username, 'ESPy')
    ..recipients.add(_emailDestinatario) //Email de quem irá receber o email.
    ..subject = 'ESPy - Funcionário novo' //Titulo do email.
    ..text =
        'Olá ${emp.CEO},\nO ${user.nome} juntou-se a equipe ${emp.nome} em ${dataFomatada}!'; //corpo do email

  try {
    final sendReport = await send(message, smtpServer);
    return true;
  } on MailerException catch (e) {
    return false;
  }
}

Future<bool> mandaEmailCadastroUsuario(
    var _emailDestinatario, var _nome) async {
  var dataFomatada =
      DateFormat(" d / MM / y 'as' hh:mm:ss", "pt_BR").format(DateTime.now());

  String _username = 'ESPy.EnviaEmail@gmail.com';
  String _password = '@EspySendEmail';

  final smtpServer = gmail(_username, _password);

  final message = Message()
    ..from = Address(_username, 'ESPy')
    ..recipients.add(_emailDestinatario) //Email de quem irá receber o email.
    ..subject = 'ESPy - Cadastro' //Titulo do email.
    ..text =
        'Olá ${_nome},\nO seu cadastro no sistema do ESPy foi realizado com sucesso e ocorreu em ${dataFomatada}!'; //corpo do email

  try {
    final sendReport = await send(message, smtpServer);
    return true;
  } on MailerException catch (e) {
    return false;
  }
}
