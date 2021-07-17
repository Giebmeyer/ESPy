import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Classes/usuario_empresa.dart';
import 'package:ESPy/Funcoes/BD.dart';
import 'package:ESPy/Pages/dashBoard_Page.dart';

class empresa {
  int codigo = 0;
  String nome = '';
  String CEO = '';
  String email_ceo = '';
  int telefone = 0;
  int cnpj = 0;
  String estado = '';
  String cidade = '';
  String bairro = '';
  String rua = '';
  int numero = 0;
  String complemento = '';
  List<dynamic> dadosEmpresa = [];
  var qtdDadosBD = 1;

  empresa(
      {this.codigo,
      this.nome,
      this.CEO,
      this.email_ceo,
      this.cnpj,
      this.telefone,
      this.estado,
      this.cidade,
      this.bairro,
      this.rua,
      this.numero,
      this.complemento});
}

void cadastroEmpresa(
    String _nome,
    String _CEO,
    String _email_ceo,
    String _telefone,
    String _cnpj,
    String _estado,
    String _cidade,
    String _bairro,
    String _rua,
    String _numero,
    String _complemento) {
  var db = new Mysql();

  db.getConnection().then((conn) {
    conn.query(
        'INSERT INTO empresa (`nome`, `ceo`,`email_ceo`, `telefone`, `cpf_cnpj`, `estado`, `cidade`, `bairro`, `rua`, `numero`, `complemento`) VALUES ("$_nome", "$_CEO", "$_email_ceo", "$_telefone", "$_cnpj", "$_estado", "$_cidade", "$_bairro", "$_rua", "$_numero", "$_complemento");');
  });

  coletaDadosEmpresaEspecifica(user.email);
  updateUsuario_Chefe(user.codigo);
  insertUsuario_Empresa(user.codigo, emp.codigo);
}

void updateUsuario_Chefe(int user_codigo) {
  var db = new Mysql();

  db.getConnection().then((conn) {
    conn.query("UPDATE `usuarios` SET `usuario_chefe`= 1 WHERE codigo = " +
        '$user_codigo' +
        ";");
  });
}

void coletaDadosEmpresaEspecifica(String auxEmail) {
  var db = new Mysql();

  db.getConnection().then((conn) {
    conn
        .query("select * from empresa where email_ceo = " + "'$auxEmail'" + ";")
        .then(((results) {
      for (var collum in results) {
        emp.dadosEmpresa = collum.values;
        emp.codigo = (collum[0]);
        print(emp.codigo);
        emp.nome = (collum[1]);
        emp.CEO = (collum[2]);
        emp.email_ceo = (collum[3]);
        emp.telefone = (collum[4]);
        emp.cnpj = (collum[5]);
        emp.estado = (collum[6]);
        emp.cidade = (collum[7]);
        emp.bairro = (collum[8]);
        emp.rua = (collum[9]);
        emp.numero = (collum[10]);
        emp.complemento = (collum[11]);
      }
      conn.close();
    }));
  });
}

empresa emp = new empresa();
