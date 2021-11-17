<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="imagem/png" href="../ESPy_Web/assents/imagens/Logo_.png" />

    <title>ESPy</title>

    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
</head>

<body>
    <div class="container-fluid col-11">
        <div class="jumbotron">
            <div class="m-3">
                <h1 class="display-4">Bem-Vindo ao ESPy!</h1>
                <p class="lead">Um sistema de monitoramento remoto de qualdiade do ambiente para a sua empresa!</p>
            </div>
            <hr class="my-4">
        </div>
    </div>


    <div class="container col-4" id="ContainerLoginCentro">
        <form id="FormularioLogin" method="POST" action="../../ESPy/ESPy_Php/WEB/ESPy_login.php">

            <!-- From email -->
            <div class="form-group">
                <label for="email">Endereço de email</label>
                <input type="email" class="form-control" id="emailLogin" name="email" aria-describedby="emailHelp" placeholder="Seu email" title="Preencha com o seu email!" required>
            </div>

            <!-- From senha -->
            <div class="form-group mt-4">
                <label for="senha">Senha</label>
                <input type="password" class="form-control" id="senhaLogin" name="senha" placeholder="Sua senha" title="Preencha com a sua senha" required>
            </div>

            <!-- Botão recuperar senha -->
            <div class="mt-1" id="DivLinkRecoverPass">
                <button type="button" class="btn btn-link" data-bs-toggle="modal" data-bs-target="#modalRecoverPass" id="DivLinkRecoverPass">Esqueci minha senha</button>
            </div>

            <!-- Botão login -->
            <div class="col-md-auto row justify-content-md-center">
                <input class="btn btn-primary" type="submit" id="BtnLogin" value="Entrar">
            </div>

            <!-- Botão Cadastre-se -->
            <div class="mt-2" id="DivLinkPageCadastro">
                Não possui login? <a href="../ESPy_Web/Paginas/Usuario/CadastroUsuario_Page.html" id="LinkPageCadastro">Cadastre-se</a>
            </div>
        </form>
    </div>


    <!-- Modal -->
    <div class="modal fade" id="modalRecoverPass" tabindex="-1" aria-labelledby="modalRecoverPass" aria-hidden="true">
        <div class="modal-dialog ">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalRecoverPass">Informe o email utilizado na criação da conta
                    </h5>
                </div>
                <div class="modal-body">
                    <form id="FormularioRecuperarSenha" method="POST" action="../../ESPy/ESPy_Php/WEB/ESPy_coletaDadosUsuario.php">
                        <!-- From email -->
                        <div class="form-group">
                            <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="Seu email cadastrado">
                        </div>
                        <!-- Botão Cadastre-se -->
                        <div class="mt-2" id="linkCadastroRecoverPass">
                            Não possui login? <a href="../ESPy_Web/Paginas/Usuario/CadastroUsuario_Page.html" id="linkCadastroRecoverPass">Cadastre-se</a>
                        </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="BtnCancelarRecoverPass">Cancelar</button>
                    <input type="submit" id="BtnRecoverPass" value="Recuperar">
                </div>
                </form>
            </div>
        </div>
    </div>

</body>

</html>