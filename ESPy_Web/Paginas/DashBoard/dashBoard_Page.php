<!DOCTYPE html>
<html lang="pt-br">
    
<?php
include "../../../ESPy_Php/WEB/ESPy_validaSessao.php";
?>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="imagem/png" href="../../assents/imagens/Logo_.png" />

    <title>ESPy</title>

    <link href="../../css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="../../js/bootstrap.min.js"></script>
</head>

<body>
    <div class="container-fluid col-11">
        <div class="jumbotron">
            <div class="m-3">
                <h1 class="display-4">Bem-Vindo ao ESPy!</h1>
                <p class="lead">O sistema de monitoramento de qualdiade do ambiente remoto para a sua empresa!</p>
            </div>
            <hr class="my-4">
        </div>
    </div>


    <div class="container col-4" id="ContainerLoginCentro">
        <form method="POST" action="../ESPy_Php/ESPy_login.php" id="FormularioLogin">

            <!-- From email -->
            <div class="form-group">
                <label for="InputEmail">Endereço de email</label>
                <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Seu email">
            </div>

            <!-- From senha -->
            <div class="form-group mt-4">
                <label for="InputSenha">Senha</label>
                <input type="password" class="form-control" id="senha" name="senha" placeholder="Sua senha">
            </div>

            <!-- Botão recuperar senha -->
            <div class="mt-1" id="divLinkRecoverPass">
                <button type="button" class="btn btn-link" data-bs-toggle="modal" data-bs-target="#modalRecoverPass" id="LinkPageRecoverPass">Esqueci minha senha</button>
            </div>

            <!-- Modal -->
            <div class="modal fade mt-4" id="modalRecoverPass" tabindex="-1" aria-labelledby="modalRecoverPass" aria-hidden="true">
                <div class="modal-dialog ">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalRecoverPass">Informe o email utilizado na criação da conta
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- From email -->
                            <div class="form-group">
                                <input type="email" class="form-control" id="emailRecoverPass" name="emailRecoverPass" aria-describedby="emailHelp" placeholder="Seu email cadastrado">
                            </div>
                            <!-- Botão Cadastre-se -->
                            <div class="mt-2" id="linkCadastroRecoverPass">
                                Não possui login? <a href="../ESPy_Web/Paginas/Usuario/CadastroUsuario_Page.html" id="linkCadastroRecoverPass">Cadastre-se</a>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="BtnCancelarRecoverPass">Cancelar</button>
                            <button type="button" class="btn btn-primary" id="BtnRecoverPass">Recuperar</button>

                        </div>
                    </div>
                </div>
            </div>

            <!-- Botão login -->
            <div class="container">
                <div class="row justify-content-md-center">
                    <div class="col-md-auto ">
                        <button type="submit" class="btn btn-primary" id="BtnLogin" value="Entrar">Entrar</button>
                    </div>
                </div>
            </div>

            <!-- Botão Cadastre-se -->
            <div class="mt-2" id="LinkPageCadastro">
                Não possui login? <a href="../ESPy_Web/Paginas/Usuario/CadastroUsuario_Page.html" id="LinkPageCadastro">Cadastre-se</a>
            </div>
        </form>
    </div>
</body>



</html>