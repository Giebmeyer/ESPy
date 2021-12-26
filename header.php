<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="/ESPy_Web/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/ESPy_Web/css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/ESPy_Web/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="/ESPy_Web/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/ESPy_Web/js/bootstrap.bundle.min.js"></script>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">

        <div class="container-fluid">

            <a class="navbar-brand" href="../Usuario/inicial_Page.php">

                <img src="../../assents/imagens/ic_launcher_foreground.png" width="50" height="50" alt="">

            </a>



            <a class="navbar-brand" href="../Usuario/inicial_Page.php">ESPy</a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">

                <span class="navbar-toggler-icon"></span>

            </button>



            <div class="collapse navbar-collapse" id="navbarSupportedContent">

                <ul class="navbar-nav mr-auto">



                    <li class="nav-link disabled">|</li>



                    <li class="nav-item dropdown">

                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">

                            Minha Empresa

                        </a>

                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">

                            <?php

                            if ($_SESSION['usuario_chefe'] == 1 || $_SESSION['usuario_empregado'] == 1) {

                                echo ('<li><a class="dropdown-item" href="../Empresa/funcionarios_Page.php">Funcionários</a></li>');
                            }

                            ?>

                            <li><a class="dropdown-item" href="../Empresa/minhaEmpresa_Page.php">Cadastro</a></li>

                        </ul>

                    </li>



                    <li class="nav-link disabled">|</li>

                    <li class="nav-item active">

                        <a class="nav-link" href="../Usuario/meuPerfil_Page.php">Meu Perfil</a>

                    </li>



                    <li class="nav-link disabled">|</li>

                    <li class="nav-item">

                        <a class="nav-link" href="../Usuario/inicial_Page.php">Principal</a>

                    </li>



                    <li class="nav-link disabled">|</li>

                    <li class="nav-item">

                        <a class="nav-link" href="../DashBoard/caixasColeta_Page.php">Caixas de Coleta</a>

                    </li>



                    <li class="nav-link disabled">|</li>

                    <li class="nav-item">

                        <a class="nav-link" href="../../../ESPy_Php/WEB/ESPy_logoff.php?sair=true">Sair</a>

                    </li>



            </div>

            </ul>

        </div>

    </nav>
</body>

</html>