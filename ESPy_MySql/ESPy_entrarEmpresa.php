<?php 
	include "ESPy_mySqlConfig.php";

	$return["erroEntrarEmpresa"] = false;
	$return["mensagemEntrarEmpresa"] = "";
	$return["sucessoEntrarEmpresa"] = false;	

	    $chaveConviteUser  =  mysqli_real_escape_string ($conexao,$_POST['chaveConvite']);
	    $codigoUsuario  =  mysqli_real_escape_string ($conexao,$_POST['codigoUsuario']);

		$query = "SELECT * FROM empresa WHERE chaveConvite = '$chaveConviteUser';";	 
	    $resultado = mysqli_query($conexao, $query);
        $numrows = mysqli_num_rows($resultado);

        if($numrows > 0){
			$obj = mysqli_fetch_object($resultado);
        
            $return["codigo"] = (int) $obj->codigo;
            $codigoEmp = $obj->codigo;
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

            $query2 = "INSERT INTO usuarios_empresa (`codigo_usuario`, `codigo_empresa`) VALUES ('$codigoUsuario', '$codigoEmp');";
            $resultado2 = mysqli_query($conexao, $query2); 
            if($resultado2 > 0){
                $query3 = "UPDATE usuarios SET usuario_empregado = 1 WHERE codigo = '$codigoUsuario';"; 
                $resultado3 = mysqli_query($conexao, $query3); 
                if($resultado > 0){
                $return["sucessoEntrarEmpresa"] = true;
                $return["erroEntrarEmpresa"] = false;
                $return["mensagemEntrarEmpresa"] = "Bem-vindo a empresa $obj->nome!";
                echo json_encode($return);
            }else{
                $return["sucessoEntrarEmpresa"] = false;
                $return["erroEntrarEmpresa"] = true;
                $return["mensagemEntrarEmpresa"] = "Ocorreu um erro ao inserir você na empresa...";
                echo json_encode($return);  
            }
        
            }else{
                $return["sucessoEntrarEmpresa"] = false;
                $return["erroEntrarEmpresa"] = true;
                $return["mensagemEntrarEmpresa"] = "Ocorreu um erro ao inserir você na empresa...";
                echo json_encode($return);
            }


			
		}else{
			
            $return["sucessoEntrarEmpresa"] = false;
			$return["erroEntrarEmpresa"] = true;
			$return["mensagemEntrarEmpresa"] = "Código não pertence a nenhuma empresa.";
            echo json_encode($return);
		}

		mysqli_close($conexao);
	    ?>