class sensores {
  List<int> sequencia = [];
  List<double> Umidade_DHT11 = [];
  List<double> Temperatura_DHT11 = [];
  List<double> Temperatura_BMP180 = [];
  List<double> Pressao_BMP180 = [];
  List<double> Altitude_BMP180 = [];
  List<double> CO_MICS = [];
  List<double> NO2_MICS = [];
  List<double> NH3_MICS = [];

  sensores(
      {this.sequencia,
      this.Umidade_DHT11,
      this.Temperatura_DHT11,
      this.Temperatura_BMP180,
      this.Pressao_BMP180,
      this.Altitude_BMP180,
      this.CO_MICS,
      this.NO2_MICS,
      this.NH3_MICS});

  factory sensores.fromJson(Map<String, dynamic> json) {
    return sensores(
      sequencia: json['sequencia'],
      Umidade_DHT11: json['Umidade_DHT11'],
      Temperatura_DHT11: json['Temperatura_DHT11'],
      Temperatura_BMP180: json['Temperatura_BMP180'],
      Pressao_BMP180: json['Pressao_BMP180'],
      Altitude_BMP180: json['Altitude_BMP180'],
      CO_MICS: json['CO_MICS'],
      NO2_MICS: json['NO2_MICS'],
      NH3_MICS: json['NH3_MICS'],
    );
  }

  Map<String, dynamic> toJson() => {
        'sequencia': sequencia,
        'Umidade_DHT11': Umidade_DHT11,
        'Temperatura_DHT11': Temperatura_DHT11,
        'Temperatura_BMP180': Temperatura_BMP180,
        'Pressao_BMP180': Pressao_BMP180,
        'Altitude_BMP180': Altitude_BMP180,
        'CO_MICS': CO_MICS,
        'NO2_MICS': NO2_MICS,
        'NH3_MICS': NH3_MICS,
      };
}

sensores sensor = new sensores();
