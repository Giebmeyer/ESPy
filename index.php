<!DOCTYPE html>
<html lang="pt-br">

<head>

    <meta charset="UTF-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="icon" type="imagem/png" href="ESPy_Web/assents/imagens/Logo_.png" />

    <title>ESPy</title>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <script src="/ESPy_Web/js/functons.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link href="/ESPy_Web/css/style.css" rel="stylesheet" type="text/css" />

</head>



<body>

    <div class="container-fluid col-11">

        <div class="jumbotron">

            <div class="m-3">

                <h1 class="display-4">Bem-Vindo ao ESPy!</h1>

                <p class="lead">Um sistema de monitoramento remoto de qualidade do ambiente para a sua empresa!</p>

            </div>

            <hr class="my-4">

        </div>

    </div>





    <section class="container-flex" id="ContainerLoginCentro">

        <form class="needs-validation" novalidate id="FormularioLogin" method="POST" action="ESPy_Php/WEB/ESPy_login.php">



            <!-- From email -->

            <div class="form-group">

                <label for="email">Endereço de email</label>

                <input type="email" class="form-control" id="emailLogin" name="email" placeholder="Seu email" title="Preencha com o seu email!" required>
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

            <div class="container-fluid" id="divBtnLogin">

                <input class="btn btn-primary" type="submit" id="BtnLogin" value="Entrar">

            </div>



            <!-- Botão Cadastre-se -->

            <div class="mt-2" id="DivLinkPageCadastro">

                Não possui login? <a href="ESPy_Web/Paginas/Usuario/CadastroUsuario_Page.html" id="LinkPageCadastro">Cadastre-se</a>

            </div>

        </form>

        <?php
        session_start();
        if ($_SESSION['sucessoLogin'] == 'erroLogin') {
            echo ' <div class="text-danger">
           Usuário  ou senha inválidos
         </div>  ';
        }
        ?>

    </section>





    <!-- Modal -->

    <div class="modal fade" id="modalRecoverPass" tabindex="-1" aria-labelledby="modalRecoverPass" aria-hidden="true">

        <div class="modal-dialog ">

            <div class="modal-content">

                <div class="modal-header">

                    <h5 class="modal-title" id="modalRecoverPass">Informe o email utilizado na criação da conta

                    </h5>

                </div>

                <div class="modal-body">

                    <form id="FormularioRecuperarSenha" method="POST" action="/ESPy_Php/WEB/ESPy_coletaDadosUsuario.php">

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


</html>