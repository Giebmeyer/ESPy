<?php 
	include "ESPy_mySqlConfig.php";

    $return["errorEmpresa"] = false;
    $return["mensagemEmpresa"] = "";
    $return["sucessoEmpresa"] = false;

        $email_user = mysqli_real_escape_string ($conexao,$_POST['emailUsuario']);

		$query = "select e.* from empresa e JOIN usuarios u on e.email_ceo = '$email_user' LIMIT 1;";	 

	    $rasultado = mysqli_query($conexao, $query);

           $numrows = mysqli_num_rows($rasultado);
        if($numrows > 0){
           $obj = mysqli_fetch_object($rasultado);
            $return["errorEmpresa"] = false;
            $return["sucessoEmpresa"] = true;
            $return["codigo"] = (int) $obj->codigo;
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
        /* }else{
            $return["sucessoEmpresa"] = false;
            $return["errorEmpresa"] = true;
            $return["mensagemEmpresa"] = "usuario não é CEO de empresa.";
           } */
        }else{
            $return["sucessoEmpresa"] = false;
            $return["errorEmpresa"] = true;
            $return["mensagemEmpresa"] = "Não existe empresa.";
        }

  mysqli_close($conexao);


  echo json_encode($return);

	?>