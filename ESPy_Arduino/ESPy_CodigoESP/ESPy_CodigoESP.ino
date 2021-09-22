//BIBLIOTECAS-------------------------------------------------------------------------------
#include <WiFiClient.h>
#include <WiFi.h>
#include <DHT.h>
#include <Adafruit_BMP085.h>
#include <MICS6814.h>
#include "BluetoothSerial.h"
#include <HTTPClient.h>
#include <ArduinoJson.h>
#include "math.h"
#include <SD.h>
#include <SPI.h>


//==========================================================================================
//Condiguração dos Sensores-----------------------------------------------------------------
//==========================================================================================
//Bluethooth
//==========================================================================================
char *aux;
char EnviaConversao[40];
String Recebido;
String RecebidoDividido;

#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif

BluetoothSerial SerialBT;

//==========================================================================================
//SD
//==========================================================================================

//==========================================================================================
//DHT11
//==========================================================================================
#define DHTPIN 4 // pino de dados do DHT11
#define DHTTYPE DHT11 // define o tipo de sensor, no caso DHT11

DHT dht(DHTPIN, DHTTYPE);

float Umidade_DHT11;
float Temperatura_DHT11;

double tempOrvalho = 0;
double IDK = 0;

//==========================================================================================
//BMP180
//==========================================================================================
Adafruit_BMP085 bmp;

float Temperatura_BMP180;
float Pressao_BMP180;
float Altitude_BMP180;

//==========================================================================================
//MICS6814
//==========================================================================================
#define PIN_CO   32   // CO
#define PIN_NO2  34  // NH3
#define PIN_NH3  35 // NO2

double CO2_MICS_6814;
double NH3_MICS_6814;
double NO2_MICS_6814;

double MICS_CO; //CO //variável para armazenar o valor proveniente do sensor
double MICS_NO2; //NO2
double MICS_NH3; //NH3

MICS6814 gas(PIN_CO, PIN_NO2, PIN_NH3);

//==========================================================================================
//Wifi
//==========================================================================================
WiFiClient client; //Cria um cliente seguro (para ter acesso ao HTTPS)
  
char *server = "192.168.66.101";
char *Rede = "";
char *Password = "";
//==========================================================================================
//MySql
//==========================================================================================
char *codigoEmpresa = "";
char *codigoCaixa = "1";
int tempoColeta = 1500;

//==========================================================================================
//Setup
//==========================================================================================
void setup() {
  Serial.begin(115200);//Inicia a comunicacao serial
  dht.begin();
  bmp.begin();

  SerialBT.begin("ESPy"); //Nome do Bluetooth

  WiFi.mode(WIFI_STA);//Habilita o modo estaçao

  //MICS6814
  gas.calibrate();

}

//==========================================================================================
//Loop
//==========================================================================================
void loop() {

  recebeDadosWifiBT();
  coletaDadosBD();
  requestSensores();
  enviaDadosBD();

  delay(tempoColeta); // intervalo
}

//==========================================================================================
//Funcoes
//==========================================================================================

//==========================================================================================Função que coleta os dados de cada sensor
void requestSensores() {
  //DHT11
  Temperatura_DHT11 = dht.readTemperature();
  Umidade_DHT11 = dht.readHumidity();
  //
  //BMP180
  Temperatura_BMP180 = bmp.readTemperature();
  Pressao_BMP180 = bmp.readPressure();
  Altitude_BMP180 = bmp.readAltitude();

  //  //MICS6814
//    for (int i = 0; i < 5; i ++) {
//      MICS_CO += gas.measure(CO); //variável para armazenar o valor proveniente do sensor
//      MICS_NO2 += gas.measure(NO2);
//      MICS_NH3 += gas.measure(NH3);
//      delay(1000);
//    }
//
//    MICS_CO /= 5;  //CO
//    MICS_NO2 /= 5;  //NO2
//    MICS_NH3 /= 5;  //NH3

//    Temperatura_DHT11 = 1;
//    Umidade_DHT11 = 2;
//
//    Temperatura_BMP180 = 3;
//    Pressao_BMP180 = 4;
//    Altitude_BMP180 = 5;

   MICS_CO = rand() % 10;
   MICS_NO2 = rand() % 10;
   MICS_NH3 = rand() % 10;

  double mediaTemperaturas = Temperatura_DHT11;

  tempOrvalho = (mediaTemperaturas - (14.55 + 0.114 * mediaTemperaturas) * (1.0 - (0.01 * Umidade_DHT11)) - pow((2.5 + 0.007 * mediaTemperaturas) * (1.0 - (0.01 * Umidade_DHT11)), 3.0) - (15.9 + 0.117 * mediaTemperaturas) * pow(1.0 - (0.01 * Umidade_DHT11), 14.0));
  IDK = ((0.99 * mediaTemperaturas) + (0.36) * (tempOrvalho + 41.5));

}




//==========================================================================================Função que envia os dados dos sensores para a tabela Dados
void enviaDadosBD()   {
  SerialBT.println("ENVIA");
  //Conecta com o servidor sql
  if (client.connect(server, 80)) {
    SerialBT.println("Conectado!");

    delay(1000);

    Serial.print("GET /ESPy/ESPy_Arduino/ESPy_MandaDados.php?Umidade_DHT11=");
    client.print("GET /ESPy/ESPy_Arduino/ESPy_MandaDados.php?Umidade_DHT11=");     //URL php
    Serial.println(Umidade_DHT11);
    client.print(Umidade_DHT11);

    client.print("&Temperatura_DHT11=");
    Serial.println("&Temperatura_DHT11=");
    client.print(Temperatura_DHT11);
    Serial.println(Temperatura_DHT11);

    client.print("&Temperatura_BMP180=");
    Serial.println("&Temperatura_BMP180=");
    client.print(Temperatura_BMP180);
    Serial.println(Temperatura_BMP180);

    client.print("&Pressao_BMP180=");
    Serial.println("&Pressao_BMP180=");
    client.print(Pressao_BMP180);
    Serial.println(Pressao_BMP180);

    client.print("&Altitude_BMP180=");
    Serial.println("&Altitude_BMP180=");
    client.print(Altitude_BMP180);
    Serial.println(Altitude_BMP180);

    client.print("&MICS_CO=");
    Serial.println("&MICS_CO=");
    client.print(MICS_CO);
    Serial.println(MICS_CO);

    client.print("&MICS_NO2=");
    Serial.println("&MICS_NO2=");
    client.print(MICS_NO2);
    Serial.println(MICS_NO2);

    client.print("&MICS_NH3=");
    Serial.println("&MICS_NH3=");
    client.print(MICS_NH3);
    Serial.println(MICS_NH3);

    client.print("&IDK=");
    Serial.println("&IDK=");
    client.print(IDK);
    Serial.println(IDK);

    client.print("&codigo_caixa=");
    Serial.println("&codigo_caixa=");
    client.print(codigoCaixa);
    Serial.println(codigoCaixa);


    client.print("&codigo_empresa=");
    Serial.println("&codigo_empresa=");
    client.print(codigoEmpresa);
    Serial.println(codigoEmpresa);

    //enviaDadosBT();

    client.print(" ");      //Espaço depois do HTTP/1.1
    client.print("HTTP/1.1");
    client.println();
    client.println("Host: "+String(server));
    client.println("Connection: close");
    client.println();
  } else {
    SerialBT.println("Falha na conexao");
  }
}




//==========================================================================================Função que coleta os dados da tabela Configurações
void coletaDadosBD() {

  if (WiFi.status() == WL_CONNECTED) {
    HTTPClient client_http;

    SerialBT.println("COLETA");
    SerialBT.println(codigoEmpresa);
    Serial.println("http://" +String(server)+ "/ESPy/ESPy_Arduino/ESPy_ColetaDados.php?codigoEmpresa=" + String(codigoEmpresa));
    client_http.begin("http://" +String(server)+ "/ESPy/ESPy_Arduino/ESPy_ColetaDados.php?codigoEmpresa=" + String(codigoEmpresa));
    int httpCode = client_http.GET();
    SerialBT.println(httpCode);

    if (httpCode > 0) {
      String load = client_http.getString();
      SerialBT.println("\nStatus: " + String(httpCode));
      SerialBT.println(load);
      delay(500);
      char json[500];
      load.replace(" ", "");
      load.replace("\n", "");
      load.trim();
      load.remove(0, 1);
      load.toCharArray(json, 500);

      StaticJsonDocument<200> doc;
      deserializeJson(doc, json);

      int tempoColetaAUX = doc["tempo_coleta"];
      SerialBT.println(tempoColeta);
      Serial.println(tempoColeta);                                          // se o tempo de coleta for diferente de
      //1500 milissegundos, ele altera o valor para o que estava no BD, se for igual a 1500, ele altera para 900000 que são 15 minutos

      if (tempoColetaAUX != tempoColeta) {
        tempoColeta = tempoColetaAUX * 60000; //Como esta salvo em minutos no BD, é necessário fazer x60000 para transformar em milissegundos

      } else {
        tempoColeta = 900000;
      }

      Serial.println(tempoColeta);
      delay(1000);
    } else {
      SerialBT.println("Erro no request");
    }
    client_http.end();
  }
}




//==========================================================================================Função que recebe os dados do Wifi pelo BT
void recebeDadosWifiBT() {

  if (Serial.available()) {
    SerialBT.write(Serial.read());
  }
  if (SerialBT.available()) {

    Recebido = SerialBT.readString();
    SerialBT.print("**Dados recebidos pelo BT: ");
    SerialBT.print(Recebido);
    delay(500);
    SerialBT.print("**Enviado para Conversao S > C: ");
    SerialBT.print(Recebido);

    converteStringChar(Recebido);

  }
}




//==========================================================================================Função que envia para o Chat do BT os dados de cada sensor.
void enviaDadosBT() {
  SerialBT.printf("Temp. DHT11: %.2f °", Temperatura_DHT11);
  SerialBT.printf("Umid. DHT11: %.2f %%", Umidade_DHT11);
  delay(1000);
  SerialBT.printf("Temp. BMP180: %.2f º", Temperatura_BMP180);
  SerialBT.printf("Press. BMP180: %.2f bar", Pressao_BMP180);
  SerialBT.printf("Alti. BMP180: %.2f m", Altitude_BMP180);
  delay(1000);
  SerialBT.printf("CO. BMP180: %.2lf ppm", MICS_CO);
  SerialBT.printf("NO2. BMP180: %.2lf ppm", MICS_NO2);
  SerialBT.printf("NH3. BMP180: %.2lf ppm", MICS_NH3);
}




//==========================================================================================Função que converte String para Char
void converteStringChar(String Recebido) {

  SerialBT.print("**Recebido para Conversao S > C: ");
  SerialBT.print(Recebido);
  delay(500);
  Recebido.trim();
  Recebido.toCharArray(EnviaConversao, 40);
  delay(500);
  SerialBT.print("**Convertido para Conversao S > C: ");
  SerialBT.print(EnviaConversao);
  divideString(EnviaConversao);
}




//==========================================================================================Função que ira dividir a mensagem "NomeRede;SenhaRede;CodigoEmpresa" em suas respectivas variaveis
void divideString(char* EnviaConversao) {
  delay(500);
  SerialBT.print("**Recebido para divisao: ");
  SerialBT.print(EnviaConversao);

  aux = strtok(EnviaConversao, ";");
  Rede = aux;

  if (aux != NULL) {
    aux = strtok(NULL, ";");
    Password = aux;
    codigoEmpresa = strtok(NULL, ";");
    codigoCaixa = strtok(NULL, ";");
  }

  SerialBT.print("**Codigo empresa: ");
  SerialBT.println(codigoEmpresa);
  delay(500);

  SerialBT.print("**Codigo caixa: ");
  SerialBT.println(codigoCaixa);
  delay(500);

  SerialBT.print("**Dados enviados para a ConectaWifi \n");
  SerialBT.print("Nome da rede Wifi: ");
  SerialBT.println(Rede);
  delay(500);

  SerialBT.print("Senha da rede Wifi: ");
  SerialBT.println(Password);

  conectaWifi(Rede, Password);

}




//==========================================================================================Função que realizada a conexão do ESP32 no WIFI
void conectaWifi(char* Rede, char* Password) {

  int timeOut = 0;

  SerialBT.println("**Dados recebidos Para conectar no WiFi");
  SerialBT.print("Nome da rede Wifi: ");
  SerialBT.println(Rede);
  delay(500);

  SerialBT.print("Senha da rede Wifi: ");
  SerialBT.println(Password);
  delay(500);

  SerialBT.printf("Conectando na rede: %s \n", Rede);
  WiFi.begin(Rede, Password);
  delay(500);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    SerialBT.print(".");


    if (timeOut == 10) {
      break;
    }

    timeOut++;

  }

  delay(2000);//Espera um tempo para se conectar no WiFi
  SerialBT.println("Conectado");
}
