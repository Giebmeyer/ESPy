<?php 
	include "ESPy_mySqlConfig.php";

    $return["erroRequestSensores"] = false;
    $return["mensagemRequestSensores"] = "";
    $return["sucessoRequestSensores"] = false;

        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);
        $dataInicial = mysqli_real_escape_string ($conexao,$_POST['dataInicial']);
        $dataFinal = mysqli_real_escape_string ($conexao,$_POST['dataFinal']);

		$query = "SELECT * FROM dados WHERE codigo_empresa = '$codigoEmpresa' AND `Data_Hora` BETWEEN '$dataInicial 00:00:00' AND '$dataFinal 23:59:59'";	
        $execut =  mysqli_query($conexao, $query);
	    $resultado = array();
         
        
            while($rowdata = $execut ->fetch_assoc()){
                    $resultado[] = $rowdata;
                }

  echo json_encode($resultado);    
  mysqli_close($conexao);


	?>