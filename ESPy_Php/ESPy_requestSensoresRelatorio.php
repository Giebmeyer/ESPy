<?php 
	include "ESPy_mySqlConfig.php";

    $return["erroRequestSensores"] = false;
    $return["mensagemRequestSensores"] = "";
    $return["sucessoRequestSensores"] = false;

        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);

		$query = "SELECT * FROM dados d JOIN caixas_coleta cc ON d.codigo_caixa = cc.codigo WHERE d.codigo_empresa = '$codigoEmpresa' ORDER BY d.sequencia desc";
        $execut =  mysqli_query($conexao, $query);
	    $resultado = array();
         
        
            while($rowdata = $execut ->fetch_assoc()){
                    $resultado[] = $rowdata;
                }

  echo json_encode($resultado);    
  mysqli_close($conexao);


	?>