//BIBLIOTECAS-------------------------------------------------------------------------------
#include <WiFiClient.h>
#include <WiFi.h>
#include "DHT.h"
#include <Adafruit_BMP085.h>
#include <MICS6814.h>
#include "BluetoothSerial.h"


//==========================================================================================
//Condiguração dos Sensores-----------------------------------------------------------------
//==========================================================================================
//Bluethooth
//==========================================================================================
char *aux;
char EnviaConversao[40];
String Recebido;
String RecebidoDividido;
String BTopcao = "";

#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif

BluetoothSerial SerialBT;

//==========================================================================================
//DHT11
//==========================================================================================
#define DHTPIN 4 // pino de dados do DHT11
#define DHTTYPE DHT11 // define o tipo de sensor, no caso DHT11

DHT dht(DHTPIN, DHTTYPE);

float Umidade_DHT11;
float Temperatura_DHT11;
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
WiFiClient client;//Cria um cliente seguro (para ter acesso ao HTTPS)

char *server;
char *Rede;
char *password;
//==========================================================================================
//Setup
//==========================================================================================
void setup() {
  Serial.begin(115200);//Inicia a comunicacao serial
  dht.begin();
  bmp.begin();
  SerialBT.begin("ESPy"); //Bluetooth device name

  WiFi.mode(WIFI_STA);//Habilita o modo estaçao

  delay(5000);

  //MICS6814
  //  Serial.println("Calibrating Sensor");
  //  gas.calibrate();
  //  Serial.println("OK!");
}
//==========================================================================================
//Loop
//==========================================================================================
void loop() {

  selecionaOpcaoBT();

    requestSensores();
    enviaDadosBD();
    delay(30000); // interval
}

//==========================================================================================
//Funcoes
//==========================================================================================

void requestSensores() {
  ////Request dos  Sensores---------------------------------------------------------------------------------------------
  //DHT11
//  Temperatura_DHT11 = dht.readTemperature();
//  Umidade_DHT11 = dht.readHumidity();
//
//  //BMP180
//
//  Temperatura_BMP180 = bmp.readTemperature();
//  Pressao_BMP180 = bmp.readPressure();
//  Altitude_BMP180 = bmp.readAltitude();
//
//  //MICS6814
//  for (int i = 0; i < 5; i ++) {
//    MICS_CO += gas.measure(CO); //variável para armazenar o valor proveniente do sensor
//    MICS_NO2 += gas.measure(NO2);
//    MICS_NH3 += gas.measure(NH3);
//    delay(1000);
//  }
//  MICS_CO /= 5;  //CO
//  MICS_NO2 /= 5;  //NO2
//  MICS_NH3 /= 5;  //NH3

  Temperatura_DHT11 = 1;
  Umidade_DHT11 = 2;

  Temperatura_BMP180 = 3;
  Pressao_BMP180 = 4;
  Altitude_BMP180 = 5;

  MICS_CO = 6;
  MICS_NO2 = 7;
  MICS_NH3 = 8;
}
void enviaDadosBD()   {
  //Conecta com o servidor sql
  if (client.connect(server, 80) == 1) {
    Serial.println("connected");


    Serial.print("GET /PFC_MandaDados/PFC_MandaDados.php?Umidade_DHT11=");
    client.print("GET /PFC_MandaDados/PFC_MandaDados.php?Umidade_DHT11=");     //YOUR URL
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

    client.print(" ");      //SPACE BEFORE HTTP/1.1
    client.print("HTTP/1.1");
    client.println();
    client.println("Host: 192.168.66.109");
    client.println("Connection: close");
    client.println();
  } else {
    // if you didn't get a connection to the server:
    Serial.println("connection failed");
  }
}

void selecionaOpcaoBT(){
    if (Serial.available()) {
      delay(1000);
    SerialBT.write(Serial.read());
  }
  
  if (SerialBT.available()) {
          SerialBT.print("No campo de *REDE*, digite a opção desejada: \n1 | Configurar Wifi \n2 | Ultimos dados dos sensores");
    if(BTopcao == "1;")
      recebeDadosWifiBT();
    
    if(BTopcao == "2;")
      enviaDadosBT();
      
    }
  }


void recebeDadosWifiBT() {

    if (Serial.available()) {
    SerialBT.write(Serial.read());
  }
  if (SerialBT.available()) {

    Recebido = SerialBT.readString();
    SerialBT.print("Dados recebidos pelo BT: ");
    SerialBT.print(Recebido);
    delay(500);
    SerialBT.print("Enviado para Conversao S > C: ");
    SerialBT.print(Recebido);

    converteStringChar(Recebido);

  }
}

void enviaDadosBT(){
  SerialBT.printf("Temp. DHT11: %.2f °", Temperatura_DHT11);
    SerialBT.printf("Umid. DHT11: %.2f %%", Umidade_DHT11);

   SerialBT.printf("Temp. BMP180: %.2f º", Temperatura_BMP180);   
      SerialBT.printf("Press. BMP180: %.2f bar", Pressao_BMP180);   
         SerialBT.printf("Alti. BMP180: %.2f m", Altitude_BMP180);   

   SerialBT.printf("CO. BMP180: %.2lf ppm", MICS_CO);   
      SerialBT.printf("NO2. BMP180: %.2lf ppm", MICS_NO2);  
         SerialBT.printf("NH3. BMP180: %.2lf ppm", MICS_NH3);  
}

void converteStringChar(String Recebido){
  
  
    SerialBT.print("Recebido para Conversao S > C: ");
    SerialBT.print(Recebido);
    delay(500);
    Recebido.toCharArray(EnviaConversao, 40);
    delay(500);
    SerialBT.print("Convertido para Conversao S > C: ");
    SerialBT.print(EnviaConversao);

    divideString(EnviaConversao);
  
}
void divideString(char* EnviaConversao) {
    delay(500);
    SerialBT.print("Recebido para divisao: ");
    SerialBT.print(EnviaConversao);

  aux = strtok(EnviaConversao, ";");
  Rede = aux;

  if (aux != NULL) {
    aux = strtok(NULL, ";");
    password = aux;
  }
  SerialBT.print("**Dados enviados para a ConectaWifi");
  SerialBT.print("Nome da rede Wifi: ");
  SerialBT.print(Rede);
    delay(500);
  SerialBT.print("Senha da rede Wifi: ");
  SerialBT.print(password);

  conectaWifi(Rede, password);

}
void conectaWifi(char* Rede, char* password) {

  SerialBT.println("**Dados recebidos da DivideString");
  SerialBT.print("Nome da rede Wifi: ");
  SerialBT.println(Rede);
    delay(500);
  SerialBT.print("Senha da rede Wifi: ");
  SerialBT.println(password);
    delay(500);
  SerialBT.printf("Conectando na rede: %s \n", Rede);
  WiFi.begin(Rede, password);
    delay(500);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    SerialBT.print(".");
  }
  delay(2000);//Espera um tempo para se conectar no WiFi
  SerialBT.println(" Conectado!");
}
