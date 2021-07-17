import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '192.168.66.109',
      username = 'Guib',
      pass = 'Nkysd3m8tg',
      datab = 'espy';
  static int port = 3306;

  Future<MySqlConnection> getConnection() {
    var settings = new ConnectionSettings(
        host: host, port: port, user: username, password: pass, db: datab);
    return MySqlConnection.connect(settings);
  }
}
