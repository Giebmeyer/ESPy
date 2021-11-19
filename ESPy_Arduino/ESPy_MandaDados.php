<?php

class Sensores{
 public $link='';
 function __construct($Umidade_DHT11, $Temperatura_DHT11, $Temperatura_BMP180, $Pressao_BMP180, $Altitude_BMP180, $MICS_CO, $MICS_NO2, $MICS_NH3, $IDK, $codigo_caixa, $codigo_empresa){
  $this->connect();
  $this->storeInDB($Umidade_DHT11, $Temperatura_DHT11, $Temperatura_BMP180, $Pressao_BMP180, $Altitude_BMP180, $MICS_CO, $MICS_NO2, $MICS_NH3, $IDK, $codigo_caixa, $codigo_empresa);
 }

 function connect(){
    $this->link = mysqli_connect('confort-espy.com','confor35_Guib','brother29') or die('Cannot connect to the DB');
    mysqli_select_db($this->link,'confor35_espy') or die('Cannot select the DB');
   }
 
 function storeInDB($Umidade_DHT11, $Temperatura_DHT11, $Temperatura_BMP180, $Pressao_BMP180, $Altitude_BMP180, $MICS_CO, $MICS_NO2, $MICS_NH3, $IDK, $codigo_caixa, $codigo_empresa){
  $query = "insert into dados set Umidade_DHT11='".$Umidade_DHT11."', Temperatura_DHT11='".$Temperatura_DHT11."', Temperatura_BMP180='".$Temperatura_BMP180."', Pressao_BMP180='".$Pressao_BMP180."', Altitude_BMP180='".$Altitude_BMP180."', MICS_CO='".$MICS_CO."', MICS_NO2='".$MICS_NO2."', MICS_NH3='".$MICS_NH3."', IDK='".$IDK."', codigo_caixa='".$codigo_caixa."', codigo_empresa='".$codigo_empresa."'";
  $result = mysqli_query($this->link,$query);

 }
 
}
 $Sensores = new Sensores($_GET['Umidade_DHT11'],$_GET['Temperatura_DHT11'],$_GET['Temperatura_BMP180'],$_GET['Pressao_BMP180'],$_GET['Altitude_BMP180'],$_GET['MICS_CO'],$_GET['MICS_NO2'],$_GET['MICS_NH3'],$_GET['IDK'],$_GET['codigo_caixa'],$_GET['codigo_empresa']);
//comentario
?>