class sensores {
  int sequencia;
  double Umidade_DHT11;
  double Temperatura_DHT11;
  double Temperatura_BMP180;
  double Pressao_BMP180;
  double Altitude_BMP180;
  double CO_MICS;
  double NO2_MICS;
  double NH3_MICS;

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

  sensores.fromJson(Map<double, dynamic> json) {
    sequencia = json['sequencia'];
    Umidade_DHT11 = json['Umidade_DHT11'];
    Temperatura_DHT11 = json['Temperatura_DHT11'];
    Temperatura_BMP180 = json['Temperatura_BMP180'];
    Pressao_BMP180 = json['Pressao_BMP180'];
    Altitude_BMP180 = json['Altitude_BMP180'];
    CO_MICS = json['CO_MICS'];
    NO2_MICS = json['NO2_MICS'];
    NH3_MICS = json['NH3_MICS'];
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
