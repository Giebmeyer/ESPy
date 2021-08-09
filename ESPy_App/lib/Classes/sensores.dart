import 'package:intl/intl.dart';

class sensores {
  int sequencia;
  double Umidade_DHT11;
  double Temperatura_DHT11;
  double Temperatura_BMP180;
  double Pressao_BMP180;
  double Altitude_BMP180;
  double MICS_CO;
  double MICS_NO2;
  double MICS_NH3;
  String data;

  var qtdDados;

  sensores(
      {this.sequencia,
      this.Umidade_DHT11,
      this.Temperatura_DHT11,
      this.Temperatura_BMP180,
      this.Pressao_BMP180,
      this.Altitude_BMP180,
      this.MICS_CO,
      this.MICS_NO2,
      this.MICS_NH3,
      this.data});

  factory sensores.fromJson(Map<String, dynamic> map) {
    return sensores(
      sequencia: int.parse(map["sequencia"]),
      Umidade_DHT11: double.parse(map["Umidade_DHT11"]),
      Temperatura_DHT11: double.parse(map["Temperatura_DHT11"]),
      Temperatura_BMP180: double.parse(map["Temperatura_BMP180"]),
      Pressao_BMP180: double.parse(map["Pressao_BMP180"]),
      Altitude_BMP180: double.parse(map["Altitude_BMP180"]),
      MICS_CO: double.parse(map["MICS_CO"]),
      MICS_NO2: double.parse(map["MICS_NO2"]),
      MICS_NH3: double.parse(map["MICS_NH3"]),
      data: map["Data_Hora"],
    );
  }

  Map<String, dynamic> toJson() => {
        'sequencia': sequencia,
        'Umidade_DHT11': Umidade_DHT11,
        'Temperatura_DHT11': Temperatura_DHT11,
        'Temperatura_BMP180': Temperatura_BMP180,
        'Pressao_BMP180': Pressao_BMP180,
        'Altitude_BMP180': Altitude_BMP180,
        'CO_MICS': MICS_CO,
        'NO2_MICS': MICS_NO2,
        'NH3_MICS': MICS_NH3,
        'Data_Hora': data,
      };
}

sensores sensor = new sensores();
