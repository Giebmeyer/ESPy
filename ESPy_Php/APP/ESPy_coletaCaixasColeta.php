<?php 
	include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

    $return["erroRequestFuncionarios"] = false;
    $return["mensagemRequestFuncionarios"] = "";
    $return["sucessoRequestFuncionarios"] = false;

        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);

		$query = "SELECT cc.*, IFNULL((select d.IDK as idk from dados d where cc.codigo = d.codigo_caixa order by sequencia desc limit 1), 0) as IDK from caixas_coleta cc join empresas e On e.codigo = cc.codigo_empresa WHERE e.codigo = '9' AND cc.excluida != 1";	 
        $execut =  mysqli_query($conexao, $query);
	    $resultado = array();
         
        
            while($rowdata = $execut ->fetch_assoc()){
                    $resultado[] = $rowdata;
                }

  echo json_encode($resultado);    
  mysqli_close($conexao);


	?>