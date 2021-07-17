import 'package:ESPy/Classes/Empresa.dart';
import 'package:ESPy/Classes/usuario.dart';
import 'package:ESPy/Funcoes/BD.dart';

class usuario_empresa {
  int _sequencia;
  int _codigo_usuario = user.codigo;
  int _codigo_empresa = emp.codigo;
}

int insertUsuario_Empresa(
  int _codigo_usuario,
  int _codigo_empresa,
) {
  var db = new Mysql();
  db.getConnection().then((conn) {
    conn.query(
        "INSERT INTO `usuarios_empresa`(`codigo_usuario`, `codigo_empresa`) VALUES (" +
            "'$_codigo_usuario'" +
            ",'$_codigo_empresa'" +
            ");");
  });
}

usuario_empresa user_emp = new usuario_empresa();
