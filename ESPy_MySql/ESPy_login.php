<?php 
	include "ESPy_mySqlConfig.php";

    $return["error"] = false;
    $return["mensagem"] = "";
    $return["sucesso"] = false;

        $email  = mysqli_real_escape_string ($conexao,$_POST['email']);
 	    $senha = mysqli_real_escape_string ($conexao,$_POST['senha']);


		$query = "SELECT * FROM usuarios WHERE email = '$email'";	 

	    $rasultado = mysqli_query($conexao, $query);

       $numrows = mysqli_num_rows($rasultado);
       if($numrows > 0){

           $obj = mysqli_fetch_object($rasultado);

           if($senha == $obj->senha){
               $return["erro"] = false;
               $return["sucesso"] = true;
               $return["codigo"] = $obj->codigo;
               $return["nome"] = $obj->nome;
               $return["senha"] = $obj->senha;
               $return["email"] = $obj->email;
               $return["cpf"] = $obj->cpf;
               $return["telefone"] = $obj->telefone;
               $return["estado"] = $obj->estado;
               $return["cidade"] = $obj->cidade;
               $return["bairro"] = $obj->bairro;
               $return["rua"] = $obj->rua;
               $return["numero"] = $obj->numero;
               $return["complemento"] = $obj->complemento;
               $return["usuario_chefe"] = $obj->usuario_chefe;
           }else{
               $return["erro"] = true;
               $return["mensagem"] = "Senha incorreta.";
           }
       }else{
           $return["erro"] = true;
           $return["mensagem"] = 'Email nao cadastrado.';
       }

  mysqli_close($conexao);

  header('Content-Type: application/json');

  echo json_encode($return);

	    ?>