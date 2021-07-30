<?php 
	include "ESPy_mySqlConfig.php";

    $return["erroRequestSensores"] = false;
    $return["mensagemRequestSensores"] = "";
    $return["sucessoRequestSensores"] = false;

        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);

		$query = "SELECT * FROM dados WHERE codigo_empresa = '$codigoEmpresa'";	
        $query2 = "SELECT * FROM dados WHERE codigo_empresa = '$codigoEmpresa' ORDER BY sequencia DESC"; 
        $execut2 = mysqli_query($conexao, $query2);
        $execut =  mysqli_query($conexao, $query);
	    $resultado = array();
         
        
            while($rowdata = $execut ->fetch_assoc()){
                    $resultado[] = $rowdata;
                }

  echo json_encode($resultado);    
  mysqli_close($conexao);


	?>