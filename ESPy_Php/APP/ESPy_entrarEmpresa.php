<?php 
	include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

	    $chaveConviteUser  = mysqli_real_escape_string ($conexao,$_POST['chaveConvite']);
	    $codigoUsuario  = mysqli_real_escape_string ($conexao,$_POST['codigoUsuario']);

		$query = "SELECT * FROM empresas WHERE chaveConvite = '$chaveConviteUser';";	 
	    $resultado = mysqli_query($conexao, $query);
        $numrows = mysqli_num_rows($resultado);

        if($numrows > 0){
			$obj = mysqli_fetch_object($resultado);
        
            $return["codigo"] = (int) $obj->codigo;
            $codigoEmp = $obj->codigo;
            $return["chaveConvite"] = (int) $obj ->chaveConvite;
            $return["nome"] = $obj->nome;
            $nomeEmp = $obj->nome;
            $return["ceo"] = $obj->ceo;
            $return["email_ceo"] = $obj->email_ceo;
            $return["telefone"] = (int) $obj->telefone;
            $return["cnpj"] = (int) $obj->cnpj;
            $return["estado"] = $obj->estado;
            $return["cidade"] = $obj->cidade;
            $return["bairro"] = $obj->bairro;
            $return["rua"] = $obj->rua;
            $return["numero"] = (int) $obj->numero;
            $return["complemento"] = $obj->complemento;

            $query2 = "INSERT INTO usuarios_empresas (`codigo_usuario`, `codigo_empresa`) VALUES ('$codigoUsuario', '$codigoEmp');";
            $resultado2 = mysqli_query($conexao, $query2); 

            if($resultado2 > 0){
                $query3 = "UPDATE usuarios SET usuario_empregado = 1 WHERE codigo = '$codigoUsuario';"; 
                $resultado3 = mysqli_query($conexao, $query3); 

                if($resultado3 > 0){
                    $return["sucessoEntrarEmpresa"] = true;
                    $return["erroEntrarEmpresa"] = false;
                    $return["mensagemEntrarEmpresa"] = "Seja bem-vindo a $nomeEmp!";

                }else{
                    $return["sucessoEntrarEmpresa"] = false;
                    $return["erroEntrarEmpresa"] = true;
                    $return["mensagemEntrarEmpresa"] = "Ocorreu um erro ao inserir o código '$codigoUsuario' no grupo de empregados...";

                }
        
            }else{
                $return["sucessoEntrarEmpresa"] = false;
                $return["erroEntrarEmpresa"] = true;
                $return["mensagemEntrarEmpresa"] = "Ocorreu um erro ao inserir você na empresa...";

            }
			
		}else{
			
            $return["sucessoEntrarEmpresa"] = false;
			$return["erroEntrarEmpresa"] = true;
			$return["mensagemEntrarEmpresa"] = "Código inválido.";
            
		}


		mysqli_close($conexao);
        echo json_encode($return);
	    ?>