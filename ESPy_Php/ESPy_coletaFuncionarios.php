<?php 
	include "ESPy_mySqlConfig.php";

    $return["erroRequestFuncionarios"] = false;
    $return["mensagemRequestFuncionarios"] = "";
    $return["sucessoRequestFuncionarios"] = false;

        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);

		$query = "SELECT u.* FROM usuarios u JOIN usuarios_empresas ue ON u.codigo = ue.codigo_usuario JOIN empresas e ON e.codigo = ue.codigo_empresa WHERE ue.codigo_empresa = '$codigoEmpresa' AND u.usuario_chefe != 1 AND ue.saiuEmpresa != 1 ORDER BY `data_hora_cadastro` desc";	 
        $execut =  mysqli_query($conexao, $query);
	    $resultado = array();
        
            while($rowdata = $execut ->fetch_assoc()){
                    $resultado[] = $rowdata;
                }

  echo json_encode($resultado);    
  mysqli_close($conexao);


	?>  