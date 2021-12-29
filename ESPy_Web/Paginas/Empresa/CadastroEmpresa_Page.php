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



    <title>ESPy | Cadastro</title>


    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../js/functons.js"></script>
</head>



<body onload="loading()">
<div id="load"></div>
    <div class="container-fluid col-11">

        <div class="jumbotron">

            <div class="m-3">

                <h1 class="display-4">Cadastre-se!</h1>

                <p class="lead">Junte a sua empresa com o sistema ESPy e surpreenda-se!</p>

            </div>

            <div class="m-1">

                <a id="LinkPageCadastro" href="../Empresa/minhaEmpresa_Page.php">Voltar</a>

            </div>

            <hr class="my-4">

        </div>

    </div>



    <?php

    echo '

    <div class="container col-4 mt-4" id="ContainerMinhaEmpresaCentro">

              <form class="needs-validation" novalidate method="POST" action="../../../ESPy_Php/WEB/ESPy_cadastroEmpresa.php" id="FormularioCadastro">

      

                  <!-- From Nome -->

                  <div class="form-group">

                      <label for="nome">Nome da empresa</label>

                      <input type="name" class="form-control" id="nomeEmpresa" name="nomeEmpresa" placeholder="Nome da empresa">

                  </div>



                  <div class="form-group mt-3">

                      <label for="nome">CEO da empresa</label>

                      <input type="name" class="form-control" id="CEOEmpresa" name="ceo" placeholder="' . $_SESSION['nome'] . '" disabled="">

                  </div>



                    <div class="form-group mt-3">

                      <label for="nome">Email</label>

                      <input type="name" class="form-control" id="emailCeo" name="emailCeo" placeholder=' . $_SESSION['email'] . ' disabled="">

                  </div>

      

                  <!-- From CNPJ -->

                  <div class="form-group mt-3">

                      <label for="CPF">CNPJ</label>

                      <input type="text" class="form-control" id="cnpj" name="cnpj" placeholder="CNPJ da empresa">

                  </div>

      

                  <!-- From Telefone -->

                  <div class="form-group mt-3">

                      <label for="Telefone">Telefone</label>

                      <input type="text" class="form-control" id="TelefoneEmpresa" name="TelefoneEmpresa" placeholder="Telefone da Empresa">

                  </div>

      

                  <!-- From Estado/Cidade -->

                  <div class="input-group mb-3 mt-3">

                      <select id="UF" name="UFEmpresa">

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

                          <label for="cidade">Cidade</label>

                          <input type="text" class="form-control" id="cidade" name="cidadeEmpresa" placeholder="Cidade">

                      </div>

                  </div>

      

                  <!-- From Bairro -->

                  <div class="form-group">

                      <label for="bairro">Bairro</label>

                      <input type="text" class="form-control" id="bairroEmpresa" name="bairroEmpresa" placeholder="Bairro">

                  </div>

      

                  <!-- From Rua/Número -->

                  <div class="input-group mb-3 mt-4" id="divRuaNumeroCadastroEmpresa">

                      <div class="col m-1">

                          <label for="rua">Rua</label>

                          <input type="text" class="form-control" id="ruaEmpresa" name="ruaEmpresa" placeholder="Rua">

                      </div>

                      <div class="col m-1">

                          <label for="numero">Número</label>

                          <input type="number" class="form-control" id="numeroEmpresa" name="numeroEmpresa" placeholder="Número">

                      </div>

                  </div>

      

                  <!-- From Complemento -->

                  <div class="form-group">

                      <label for="complemento">Complemento</label>

                      <input type="text" class="form-control" id="complementoEmpresa" name="complementoEmpresa" placeholder="Complemento">

                  </div>

      

            <!-- Botão Cadastro -->

            <div class="container-fluid" id="divBtnLogin">

                <input class="btn btn-primary" type="submit" id="BtnLogin" value="Cadastrar">

            </div>

      

              </form>

          </div>'

    ?>



    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>

    <script type="text/javascript">
        $("#TelefoneEmpresa").mask("(00) 0000-0000");

        $("#cnpj").mask("000.000.000/0000-00");
    </script>

</body>



</html>