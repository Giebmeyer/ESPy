<?php 
	include "../ESPy_MySql/ESPy_MySqlCredenciais.php";

    $return["erroRequestSensores"] = false;
    $return["mensagemRequestSensores"] = "";
    $return["sucessoRequestSensores"] = false;

        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);
        $codigoCaixa = mysqli_real_escape_string ($conexao,$_POST['codigoCaixa']);

		$query = "SELECT * FROM dados WHERE codigo_empresa = '$codigoEmpresa' AND codigo_caixa = '$codigoCaixa' ORDER BY `sequencia` DESC LIMIT 5";	
        $execut =  mysqli_query($conexao, $query);
	    $resultado = array();
         
        
            while($rowdata = $execut ->fetch_assoc()){
                    $resultado[] = $rowdata;
                }

  echo json_encode($resultado);    
  mysqli_close($conexao);


	?>