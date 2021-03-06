import 'package:ESPy/Classes/empresa.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

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
    ..html =
        'Olá <b>${user.nome}!</b>,\nRecebemos uma solicitação para recuperar sua senha de acesso em nosso sistema.\nEla ocorreu em ${dataFomatada}\nA sua senha é <b>${user.senha}</b>'; //corpo do email
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
