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

    <title>ESPy | Empresa</title>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../js/functons.js"></script>
</head>

<body onload="loading()">
<div id="load"></div>
    <?php
    include '../../../header.php';
    ?>

    <div id="divCamposEntrarEmpresa" class="container-fluid mt-3">
        <form id="FormularioEntrarEmpresa" method="POST" action="../../../ESPy_Php/WEB/ESPy_entrarEmpresa.php">
            <h4 id="txtEntrarEmpresa" class="display-4"> Digite o código de convite da sua empresa:</h4>
            <div class="form-group">
                <div class="container px-4 mt-3">
                    <div class="row gx-5">
                        <div class="col container">
                            <input type="number" class="form-control" id="txtCodigoEntrarEmpresa1" name="n1_CodigoEntrarEmpresa" title="Preencha esse campo!" required>
                        </div>
                        <div class="col container">
                            <input type="number" class="form-control" id="txtCodigoEntrarEmpresa2" name="n2_CodigoEntrarEmpresa" title="Preencha esse campo!" required>
                        </div>
                        <div class="col container">
                            <input type="number" class="form-control" id="txtCodigoEntrarEmpresa3" name="n3_CodigoEntrarEmpresa" title="Preencha esse campo!" required>
                        </div>
                        <div class="col container">
                            <input type="number" class="form-control" id="txtCodigoEntrarEmpresa4" name="n4_CodigoEntrarEmpresa" title="Preencha esse campo!" required>
                        </div>
                        <div class="col container">
                            <input type="number" class="form-control" id="txtCodigoEntrarEmpresa5" name="n5_CodigoEntrarEmpresa" title="Preencha esse campo!" required>
                        </div>
                        <div class="col container">
                            <input type="number" class="form-control" id="txtCodigoEntrarEmpresa6" name="n6_CodigoEntrarEmpresa" title="Preencha esse campo!" required>
                        </div>
                    </div>
                </div>
            </div>
<div id="divBtnEntrarEmpresa"> <button type="submit" class="btn btn-primary mb-4" id="BtnLogin">Entrar</button></div>
        </form>
    </div>
    


</body>

</html>