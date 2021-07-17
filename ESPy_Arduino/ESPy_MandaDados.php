<?php
class Sensores{
 public $link='';
 function __construct($Umidade_DHT11, $Temperatura_DHT11, $Temperatura_BMP180, $Pressao_BMP180, $Altitude_BMP180, $MICS_CO, $MICS_NO2, $MICS_NH3){
  $this->connect();
  $this->storeInDB($Umidade_DHT11, $Temperatura_DHT11, $Temperatura_BMP180, $Pressao_BMP180, $Altitude_BMP180, $MICS_CO, $MICS_NO2, $MICS_NH3);
 }
 
 function connect(){
  $this->link = mysqli_connect('localhost','root','') or die('Cannot connect to the DB');
  mysqli_select_db($this->link,'espy') or die('Cannot select the DB');
 }
 
 function storeInDB($Umidade_DHT11, $Temperatura_DHT11, $Temperatura_BMP180, $Pressao_BMP180, $Altitude_BMP180, $MICS_CO, $MICS_NO2, $MICS_NH3){
  $query = "insert into dados set Umidade_DHT11='".$Umidade_DHT11."', Temperatura_DHT11='".$Temperatura_DHT11."', Temperatura_BMP180='".$Temperatura_BMP180."', Pressao_BMP180='".$Pressao_BMP180."', Altitude_BMP180='".$Altitude_BMP180."', MICS_CO='".$MICS_CO."', MICS_NO2='".$MICS_NO2."', MICS_NH3='".$MICS_NH3."'";
  $result = mysqli_query($this->link,$query) or die('Errant query:  '.$query);
 }
 
}
if($_GET['Temperatura_DHT11'] != '' and  $_GET['Umidade_DHT11'] != '' and $_GET['Temperatura_BMP180'] != '' and $_GET['Pressao_BMP180'] != '' and $_GET['Altitude_BMP180'] != '' and $_GET['MICS_CO'] != '' and $_GET['MICS_NO2'] != '' and $_GET['MICS_NH3'] != ''){
 $Sensores = new Sensores($_GET['Temperatura_DHT11'],$_GET['Umidade_DHT11'],$_GET['Temperatura_BMP180'],$_GET['Pressao_BMP180'],$_GET['Altitude_BMP180'],$_GET['MICS_CO'],$_GET['MICS_NO2'],$_GET['MICS_NH3']);
}
//comentario
?>