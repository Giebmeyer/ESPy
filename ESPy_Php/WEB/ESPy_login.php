<?php
include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

$email  = mysqli_real_escape_string($conexao, $_POST['email']);
$senha = mysqli_real_escape_string($conexao, $_POST['senha']);

$resultado = mysqli_query($conexao, "SELECT * FROM usuarios WHERE email = '$email' and senha = MD5('$senha')");

$numrows = mysqli_num_rows($resultado);
if ($numrows > 0) {
    session_start();
    $obj = mysqli_fetch_object($resultado);
    $_SESSION['codigo'] = (int) $obj->codigo;
    $codigoUser = (int) $obj->codigo;
    $_SESSION['nome'] = $obj->nome;
    $_SESSION['senha'] = $obj->senha;
    $_SESSION['email'] = $obj->email;
    $_SESSION['cpf'] = $obj->cpf;
    $_SESSION['telefone'] = (int) $obj->telefone;
    $_SESSION['estado'] = $obj->estado;
    $_SESSION['cidade'] = $obj->cidade;
    $_SESSION['bairro'] = $obj->bairro;
    $_SESSION['rua'] = $obj->rua;
    $_SESSION['numero'] = (int) $obj->numero;
    $_SESSION['complemento'] = $obj->complemento;
    $_SESSION['usuario_chefe'] = (int) $obj->usuario_chefe;
    $_SESSION['usuario_empregado'] = (int) $obj->usuario_empregado;

    if ($_SESSION['usuario_empregado'] || $_SESSION['usuario_chefe']) {
        $resultado2 = mysqli_query($conexao, "SELECT e.* FROM empresas e JOIN usuarios_empresas ue ON ue.codigo_empresa = e.codigo WHERE ue.codigo_usuario = '$codigoUser'");

        $numrows2 = mysqli_num_rows($resultado2);
        $obj2 = mysqli_fetch_object($resultado2);
        if ($numrows2 > 0) {

            $_SESSION["codigoEmpresa"] = (int) $obj2->codigo;
            $_SESSION["chaveConvite"] = (int) $obj2->chaveConvite;
            $_SESSION["nomeEmpresa"] = $obj2->nome;
            $_SESSION["ceoEmpresa"] = $obj2->ceo;
            $_SESSION["email_ceoEmpresa"] = $obj2->email_ceo;
            $_SESSION["telefoneEmpresa"] =  $obj2->telefone;
            $_SESSION["cnpjEmpresa"] =  $obj2->cnpj;
            $_SESSION["estadoEmpresa"] = $obj2->estado;
            $_SESSION["cidadeEmpresa"] = $obj2->cidade;
            $_SESSION["bairroEmpresa"] = $obj2->bairro;
            $_SESSION["ruaEmpresa"] = $obj2->rua;
            $_SESSION["numerEmpresao"] = (int) $obj2->numero;
            $_SESSION["complementoEmpresa"] = $obj2->complemento;
        }
    }
    header('Location: ../../ESPy_Web/Paginas/Usuario/inicial_Page.php');
} else {
    unset($_SESSION['senha']);
    unset($_SESSION['email']);
    header('location: ../../ESPy_Web/index.html');
    echo "Login ou Senha invalidos";
}

mysqli_close($conexao);
