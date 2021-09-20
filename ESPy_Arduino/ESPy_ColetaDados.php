<?php 
	include "../ESPy_Php/ESPy_mySqlConfig.php";

    $return["erroRequestFuncionarios"] = false;
    $return["mensagemRequestFuncionarios"] = "";
    $return["sucessoRequestFuncionarios"] = false;

        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_GET['codigoEmpresa']);

		$query = "SELECT c.* FROM configuracao c JOIN empresas u ON u.codigo = c.codigo_empresa WHERE u.codigo = '$codigoEmpresa'";	 
        $execut =  mysqli_query($conexao, $query);
	    $resultado = array();

        while($rowdata = $execut->fetch_assoc()){
            $resultado[] = $rowdata;
        }

  echo json_encode($resultado);    
  mysqli_close($conexao);


	?>