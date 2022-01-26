<?php
include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

$return["erroColetaUser"] = false;
$return["mensagemColetaUser"] = "";
$return["sucessoColetaUser"] = false;

$email  = mysqli_real_escape_string($conexao, $_POST['emailUsuario']);

	    $resultado = mysqli_query($conexao, "SELECT usuarios.*, UNHEX(usuarios.senha) as senhaDescodificada FROM usuarios WHERE email = '$email'");
       $numrows = mysqli_num_rows($resultado);
       
       if($numrows > 0){

           $obj = mysqli_fetch_object($resultado);
               $return["mensagemColetaUser"] = 'Email cadastrado.';
               $return["erroColetaUser"] = false;
               $return["sucessoColetaUser"] = true;
               $return["codigo"] = (int) $obj->codigo;
               $return["nome"] = $obj->nome;
               $return["senha"] = $obj->senhaDescodificada;
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

} else {
    $return["erroColetaUser"] = true;
    $return["mensagemColetaUser"] = 'Email nao cadastrado.';
}

echo json_encode($return);
mysqli_close($conexao);
