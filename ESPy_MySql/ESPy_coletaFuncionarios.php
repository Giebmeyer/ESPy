<?php 
	include "ESPy_mySqlConfig.php";

    $return["erroRequestFuncionarios"] = false;
    $return["mensagemRequestFuncionarios"] = "";
    $return["sucessoRequestFuncionarios"] = false;

        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);

		$query = "SELECT u.* FROM usuarios u JOIN usuarios_empresa ue ON u.codigo = ue.codigo_usuario JOIN empresa e ON e.codigo = ue.codigo_empresa WHERE ue.codigo_empresa = '$codigoEmpresa'";	 
        $execut =  mysqli_query($conexao, $query);
	    $resultado = array();
         

            while($rowdata = $execut ->fetch_assoc()){
                    $resultado[] = $rowdata;
                }

  echo json_encode($resultado);    
  mysqli_close($conexao);


	?>