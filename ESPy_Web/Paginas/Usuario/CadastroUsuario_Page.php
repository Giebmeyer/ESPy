<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="imagem/png" href="../../assents/imagens/Logo_.png" />

    <title>ESPy | Cadastro</title>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
        integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
        integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
        crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../js/functons.js"></script>
</head>

<body onload="loading()">
    <div id="load"></div>
    <div class="container-fluid col-11">
        <div class="jumbotron">
            <div class="m-3">
                <h1 class="display-4">Cadastre-se!</h1>
                <p class="lead">Faça parte da equipe ESPy e melhore o rendimento dos funcionários da sua empresa!</p>
            </div>
            <div class="m-1">
                <a id="LinkPageCadastro" href="/index.php">Voltar</a>
            </div>
            <hr class="my-4">
        </div>
    </div>


    <div class="container col-4" id="ContainerCadastroCentro">
        <form class="needs-validation" novalidate method="POST" action="../../../ESPy_Php/WEB/ESPy_cadastroUsuario.php"
            id="FormularioCadastro">
            <?php
        session_start();
        if($_SESSION['mensagemCadastroUser'] != ''){
            if ($_SESSION['mensagemCadastroUser'] == 'senhasDiferentes') {
                echo ' <div class="alert alert-danger" role="alert">
               As senhas não conferem.
             </div>  ';
            }else if($_SESSION['mensagemCadastroUser'] == 'erroCadastro'){
                echo ' <div class="alert alert-danger" role="alert">
               Erro ao cadastrar usuário, tente novamente mais tarde.
             </div>  ';
            }
        }else{
            echo '';
        }
        ?>
            <!-- From Nome -->
            <div class="form-group">
                <label for="nome">Seu nome</label>
                <input type="name" class="form-control" id="nome" name="nome" aria-describedby="name" placeholder="Nome"
                    title="Preencha este campo." required>
            </div>

            <!-- From email -->
            <div class="form-group mt-3">
                <label for="email">Endereço de email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Seu email"
                    title="Preencha este campo." required>
            </div>

            <!-- From senhas -->
            <div class="container px-4 mt-3">
                <div class="row gx-5">
                    <div class="col">
                        <label for="senha">Senha</label>
                        <input type="password" aria-label="senha" id="senha" name="senha" class="form-control"
                            placeholder="Senha" title="Preencha este campo." minlength="6" required>
                    </div>
                    <div class="col">
                        <label for="ConfirmarSenha">Confirma Senha</label>
                        <input type="password" aria-label="ConfirmarSenha" id="ConfirmarSenha" name="ConfirmarSenha"
                        class="form-control" placeholder="Confirmar Senha" title="Preencha este campo." minlength="6" required>
                    </div>
                </div>
            </div>

            <!-- From CPF -->
            <div class="form-group mt-3">
                <label for="CPF">CPF</label>
                <input type="text" class="form-control" id="cpf" name="cpf" placeholder="Seu CPF"
                    title="Preencha este campo." required maxlength="12">
            </div>

            <!-- From Telefone -->
            <div class="form-group mt-3">
                <label for="Telefone">Telefone celular</label>
                <input type="text" class="form-control" id="telefone" name="telefone" placeholder="Seu Telefone"
                    title="Preencha este campo." required maxlength="14">
            </div>
            <!-- From Estado/Cidade -->
            <div class="input-group mb-3 mt-3">
                <select id="UF" name="estado" title="Selecione um estado." required>
                    <option value="Null">Estado</option>
                    <option value="AC">AC</option>
                    <option value="AL">AL</option>
                    <option value="AP">AP</option>
                    <option value="AM">AM</option>
                    <option value="BA">BA</option>
                    <option value="CE">CE</option>
                    <option value="DF">DF</option>
                    <option value="ES">ES</option>
                    <option value="GO">GO</option>
                    <option value="MA">MA</option>
                    <option value="MS">MS</option>
                    <option value="MT">MT</option>
                    <option value="MG">MG</option>
                    <option value="PA">PA</option>
                    <option value="PB">PB</option>
                    <option value="PR">PR</option>
                    <option value="PE">PE</option>
                    <option value="PI">PI</option>
                    <option value="RJ">RJ</option>
                    <option value="RN">RN</option>
                    <option value="RS">RS</option>
                    <option value="RO">RO</option>
                    <option value="RR">RR</option>
                    <option value="SC">SC</option>
                    <option value="SP">SP</option>
                    <option value="SE">SE</option>
                    <option value="TO">TO</option>
                </select>
                <div class="col">
                    <label for="cidade">Sua Cidade</label>
                    <input type="text" class="form-control" id="cidade" name="cidade" placeholder="Cidade"
                        title="Preencha este campo." required>
                </div>
            </div>

            <!-- From Bairro -->
            <div class="form-group">
                <label for="bairro">Bairro</label>
                <input type="text" class="form-control" id="bairro" name="bairro" placeholder="Bairro"
                    title="Preencha este campo." required>
            </div>

            <!-- From Rua/Número -->
            <div class="input-group mb-3 mt-4" id="divRuaNumero">
                <div class="col m-1">
                    <label for="rua">Rua</label>
                    <input type="text" class="form-control" id="rua" name="rua" placeholder="Rua"
                        title="Preencha este campo." required>
                </div>
                <div class="col m-1">
                    <label for="numero">Número</label>
                    <input type="number" class="form-control" id="numero" name="numero" placeholder="Número"
                        title="Preencha este campo." required>
                </div>
            </div>

            <!-- From Complemento -->
            <div class="form-group">
                <label for="complemento">Complemento</label>
                <input type="text" class="form-control" id="complemento" name="complemento" placeholder="Complemento">
            </div>

            <!-- Botão Cadastro -->
            <div class="container-fluid" id="divBtnLogin">
                <input class="btn btn-primary" type="submit" id="BtnLogin" value="Cadastrar">
            </div>

        </form>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>
    <script type="text/javascript">
        $("#telefone").mask("(00) 0 0000-0000");
        $("#cpf").mask("000.000.000-00");
    </script>
</body>

</html>