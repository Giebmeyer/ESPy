<?php 
	include "ESPy_mySqlConfig.php";

    $return["erroRequestSensores"] = false;
    $return["mensagemRequestSensores"] = "";
    $return["sucessoRequestSensores"] = false;

        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);

		$query = "SELECT * FROM dados WHERE codigo_empresa = '$codigoEmpresa'";	 

	    $resultado = mysqli_query($conexao, $query);
        $numrows = mysqli_num_rows($resultado);

        if($numrows > 0){
            
            while($obj = mysqli_fetch_array($resultado)){
                $return["sequencia"] = (int) $obj['sequencia'];
                $return["Umidade_DHT11"] = (float) $obj['Umidade_DHT11'];
                $return["Temperatura_DHT11"] = (float) $obj['Temperatura_DHT11'];
                $return["Temperatura_BMP180"] = (float) $obj['Temperatura_BMP180'];
                $return["Pressao_BMP180"] = (float) $obj['Pressao_BMP180'];
                $return["Altitude_BMP180"] = (float) $obj['Altitude_BMP180'];
                $return["CO_MICS"] = (float) $obj['MICS_CO'];
                $return["NO2_MICS"] = (float) $obj['MICS_NO2'];
                $return["NH3_MICS"] = (float) $obj['MICS_NH3'];
                }
        }else{
            $return["erroRequestSensores"] = true;
            $return["mensagemRequestSensores"] = "Nenhum dado foi selecionado";
            $return["sucessoRequestSensores"] = false;
        }


        
           
  mysqli_close($conexao);


	?>