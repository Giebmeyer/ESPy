<?php 
	include "ESPy_mySqlConfig.php";

    $return["errorEmpresa"] = false;
    $return["mensagemEmpresa"] = "";
    $return["sucessoEmpresa"] = false;

        $codigoEmpresa = mysqli_real_escape_string ($conexao,$_POST['codigoEmpresa']);

		$query = "SELECT * FROM empresa WHERE codigo = '$codigoEmpresa';";	 

	    $rasultado = mysqli_query($conexao, $query);

        $numrows = mysqli_num_rows($rasultado);
           
        if($numrows > 0){
           $obj = mysqli_fetch_object($rasultado);
            $return["errorEmpresa"] = false;
            $return["sucessoEmpresa"] = true;
            $return["codigo"] = (int) $obj->codigo;
            $return["chaveConvite"] = (int) $obj ->chaveConvite;
            $return["nome"] = $obj->nome;
            $return["ceo"] = $obj->ceo;
            $return["email_ceo"] = $obj->email_ceo;
            $return["telefone"] = (int) $obj->telefone;
            $return["cnpj"] = (int) $obj->cpf_cnpj;
            $return["estado"] = $obj->estado;
            $return["cidade"] = $obj->cidade;
            $return["bairro"] = $obj->bairro;
            $return["rua"] = $obj->rua;
            $return["numero"] = (int) $obj->numero;
            $return["complemento"] = $obj->complemento;
            echo json_encode($return);
        }else{
            $return["sucessoEmpresa"] = false;
            $return["errorEmpresa"] = true;
            $return["mensagemEmpresa"] = "Não existe empresa.";
            echo json_encode($return);
        }

  mysqli_close($conexao);

	?>