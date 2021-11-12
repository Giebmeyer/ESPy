<?php
include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

session_start();
$chaveConvite1  = mysqli_real_escape_string($conexao, $_POST['n1_CodigoEntrarEmpresa']);
$chaveConvite2  = mysqli_real_escape_string($conexao, $_POST['n2_CodigoEntrarEmpresa']);
$chaveConvite3  = mysqli_real_escape_string($conexao, $_POST['n3_CodigoEntrarEmpresa']);
$chaveConvite4  = mysqli_real_escape_string($conexao, $_POST['n4_CodigoEntrarEmpresa']);
$chaveConvite5  = mysqli_real_escape_string($conexao, $_POST['n5_CodigoEntrarEmpresa']);
$chaveConvite6  = mysqli_real_escape_string($conexao, $_POST['n6_CodigoEntrarEmpresa']);
$chaveConviteUser = "";
$chaveConviteUser = $chaveConvite1 . "" . $chaveConvite2 . "" . $chaveConvite3 . "" . $chaveConvite4 . "" . $chaveConvite5 . "" . $chaveConvite6;
$codigoUsuario  = $_SESSION['codigo'];

$resultado = mysqli_query($conexao, "SELECT * FROM empresas WHERE chaveConvite = '$chaveConviteUser';");
$numrows = mysqli_num_rows($resultado);

if ($numrows > 0) {
    $obj = mysqli_fetch_object($resultado);

    $_SESSION["codigoEmpresa"] = (int) $obj->codigo;
    $codigoEmp = $obj->codigo;
    $_SESSION["chaveConvite"] = (int) $obj->chaveConvite;
    $_SESSION["nomeEmpresa"] = $obj->nome;
    $nomeEmp = $obj->nome;
    $_SESSION["ceoEmpresa"] = $obj->ceo;
    $_SESSION["email_ceoEmpresa"] = $obj->email_ceo;
    $_SESSION["telefoneEmpresa"] =  $obj->telefone;
    $_SESSION["cnpjEmpresa"] =  $obj->cnpj;
    $_SESSION["estadoEmpresa"] = $obj->estado;
    $_SESSION["cidadeEmpresa"] = $obj->cidade;
    $_SESSION["bairroEmpresa"] = $obj->bairro;
    $_SESSION["ruaEmpresa"] = $obj2->rua;
    $_SESSION["numerEmpresao"] = (int) $obj->numero;
    $_SESSION["complementoEmpresa"] = $obj->complemento;


    if (mysqli_query($conexao, "INSERT INTO usuarios_empresas (`codigo_usuario`, `codigo_empresa`) VALUES ('$codigoUsuario', '$codigoEmp');") > 0) {

        if (mysqli_query($conexao, "UPDATE usuarios SET usuario_empregado = 1 WHERE codigo = '$codigoUsuario';") > 0) {

            $result2 = mysqli_query($conexao, "SELECT usuario_empregado, usuario_chefe FROM usuarios WHERE codigo = '$codigoUsuario'");
            $numrows2 = mysqli_num_rows($result2);
            if ($numrows2 > 0) {
                $obj2 = mysqli_fetch_object($result2);
                $_SESSION['usuario_chefe'] = (int) $obj2->usuario_chefe;
                $_SESSION['usuario_empregado'] = (int) $obj2->usuario_empregado;
            }

            header("Location: ../../ESPy_Web/Paginas/Usuario/inicial_Page.php");
            $return["mensagemEntrarEmpresa"] = "Seja bem-vindo a $nomeEmp!";

        } else {
            $return["mensagemEntrarEmpresa"] = "Ocorreu um erro ao inserir o código '$codigoUsuario' no grupo de empregados...";
            header("Location: ../../ESPy_Web/Paginas/Empresa/entrarEmpresa_Page.php");
        }
    } else {
        $return["mensagemEntrarEmpresa"] = "Ocorreu um erro ao inserir você na empresa...";
        header("Location: ../../ESPy_Web/Paginas/Empresa/entrarEmpresa_Page.php");
    }
} else {
    $return["mensagemEntrarEmpresa"] = "Código inválido.";
    header("Location: ../../ESPy_Web/Paginas/Empresa/entrarEmpresa_Page.php");
}
