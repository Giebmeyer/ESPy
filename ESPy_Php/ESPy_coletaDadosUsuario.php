<?php 
	include "ESPy_mySqlConfig.php";

	$return["erroColetaUser"] = false;
    $return["mensagemColetaUser"] = "";
    $return["sucessoColetaUser"] = false;

	    $email  = 'lumes_001@hotmail.com'/* mysqli_real_escape_string ($conexao,$_POST['email']) */;

		$query = "SELECT * FROM usuarios WHERE email = '$email'";

	    $resultado = mysqli_query($conexao, $query);
        $numrows = mysqli_num_rows($resultado);

			if($numrows>0){
					$obj = mysqli_fetch_object($resultado);
				 if($email == $obj->email){ 
                        $return["erroColetaUser"] = false;
                        $return["sucessoColetaUser"] = true;
                        $return["codigo"] = (int) $obj->codigo;
                        $return["nome"] = $obj->nome;
                        $return["senha"] = $obj->senha;
                        $return["email"] = $obj->email;
                        $return["cpf"] = $obj->cpf;
                        $return["telefone"] = (int) $obj->telefone;
                        $return["estado"] = $obj->estado;
                        $return["cidade"] = $obj->cidade;
                        $return["bairro"] = $obj->bairro;
                        $return["rua"] = $obj->rua;
                        $return["numero"] = (int) $obj->numero;
                        $return["complemento"] = $obj->complemento;
                        $return["usuario_chefe"] = (int) $obj->usuario_chefe;
				 }else{
						$return["mensagemColetaUser"] = 'Usuario nao existe.';
						$return["erroColetaUser"] = true;
					} 
				}else{
					$return["erroColetaUser"] = true;
					$return["mensagemColetaUser"] = 'Email nao cadastrado.';

				}  

                mysqli_close($conexao);
                echo json_encode($return);

	    ?>