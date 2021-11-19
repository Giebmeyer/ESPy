<?php
include "../ESPy_MySql/ESPy_MySqlCredenciais.php";

    $Umidade_DHT11 =  $_GET['Umidade_DHT11'];
    $Temperatura_DHT11 = $_GET['Temperatura_DHT11'];
    $Temperatura_BMP180 = $_GET['Temperatura_BMP180'];
    $Pressao_BMP180 = $_GET['Pressao_BMP180'];
    $Altitude_BMP180 = $_GET['Altitude_BMP180'];
    $MICS_CO = $_GET['MICS_CO'];
    $MICS_NO2 = $_GET['MICS_NO2'];
    $MICS_NH3 = $_GET['MICS_NH3'];
    $IDK = $_GET['IDK'];
    $codigo_caixa = $_GET['codigo_caixa'];
    $codigo_empresa = $_GET['codigo_empresa'];

    $query = "insert into dados set Umidade_DHT11='".$Umidade_DHT11."', Temperatura_DHT11='".$Temperatura_DHT11."', Temperatura_BMP180='".$Temperatura_BMP180."', Pressao_BMP180='".$Pressao_BMP180."', Altitude_BMP180='".$Altitude_BMP180."', MICS_CO='".$MICS_CO."', MICS_NO2='".$MICS_NO2."', MICS_NH3='".$MICS_NH3."', IDK='".$IDK."', codigo_caixa='".$codigo_caixa."', codigo_empresa='".$codigo_empresa."'";;	 
    $execut =  mysqli_query($conexao, $query);

?>