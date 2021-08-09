<?php 
	include "../ESPy_Php/ESPy_mySqlConfig.php";

    $return["erroRequestFuncionarios"] = false;
    $return["mensagemRequestFuncionarios"] = "";
    $return["sucessoRequestFuncionarios"] = false;

        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);

		$query = "SELECT c.tempo_coleta FROM configuracao c JOIN empresa u ON u.codigo = c.codigo_empresa WHERE u.codigo = $codigoEmpresa";	 
        $execut =  mysqli_query($conexao, $query);
	    $resultado = array();

             while($rowdata = $execut ->fetch_assoc()){
                    $resultado[] = $rowdata;
                } 

  echo json_encode($resultado);    
  mysqli_close($conexao);


	?>