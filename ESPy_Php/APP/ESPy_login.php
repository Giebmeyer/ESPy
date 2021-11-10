<?php 
	include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

    $return["errorLogin"] = false;
    $return["mensagemLogin"] = "";
    $return["sucessoLogin"] = false;

        $email  = mysqli_real_escape_string ($conexao,$_POST['email']);
 	    $senha = mysqli_real_escape_string ($conexao,$_POST['senha']);

	    $resultado = mysqli_query($conexao, "SELECT * FROM usuarios WHERE email = '$email' and senha = MD5('$senha')");

       $numrows = mysqli_num_rows($resultado);
       if($numrows > 0){

           $obj = mysqli_fetch_object($resultado);
        
           if($senha == $obj->senha){


               $return["errorLogin"] = false;
               $return["sucessoLogin"] = true;
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
               $return["usuario_empregado"] = (int) $obj->usuario_empregado;


           }else{
               $return["errorLogin"] = true;
               $return["sucessoLogin"] = false;
               $return["mensagemLogin"] = "Senha incorreta.";
               
           }
       }else{
           $return["errorLogin"] = true;
           $return["sucessoLogin"] = false;
           $return["mensagemLogin"] = 'Email não cadastrado.';
       }
       
  mysqli_close($conexao);
  echo json_encode($return);
