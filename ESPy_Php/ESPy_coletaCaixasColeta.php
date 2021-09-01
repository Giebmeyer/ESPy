<?php 
	include "ESPy_mySqlConfig.php";

    $return["erroRequestFuncionarios"] = false;
    $return["mensagemRequestFuncionarios"] = "";
    $return["sucessoRequestFuncionarios"] = false;

        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);

		$query = "Select cc.* from caixas_coleta cc join empresas e On e.codigo = cc.codigo_empresa WHERE e.codigo = '$codigoEmpresa' AND cc.excluida != 1 ORDER BY `data_hora_cadastro` desc";	 
        $execut =  mysqli_query($conexao, $query);
	    $resultado = array();
         
        
            while($rowdata = $execut ->fetch_assoc()){
                    $resultado[] = $rowdata;
                }

  echo json_encode($resultado);    
  mysqli_close($conexao);


	?>