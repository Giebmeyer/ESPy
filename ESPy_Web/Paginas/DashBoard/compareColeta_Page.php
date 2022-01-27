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



    <title>ESPy | DashBoard</title>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

    <div class="container p-5" id="divFiltroCadastroCaixasColeta">
        O que você deseja comparar?

        <form>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="compare_Datas">
                <label class="form-check-label" for="inlineRadio1">Periodos</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="compare_Sensores">
                <label class="form-check-label" for="inlineRadio2">Sensores</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="compare_Caixas">
                <label class="form-check-label" for="inlineRadio3">Caixas</label>
            </div>

            <div id="filtroData">
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio4" value="compare_Datas_1periodo">
                    <label class="form-check-label" for="inlineRadio4">1 Periodo</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio5" value="compare_Datas_2periodo">
                    <label class="form-check-label" for="inlineRadio5">2 periodos</label>

                </div>

            </div>

            <div id="periodo1Div">
                <label for="dataInicial">Data inicial: </label>
                <input id="dataInicial" type="date">
                <label for="dataFinal">Data final: </label>
                <input id="dataFinal" type="date">
            </div>
            <div id="periodo2Div">
                <div>
                    <label for="dataInicial_Periodo1">Data inicial: </label>
                    <input id="dataInicial_Periodo1" type="date">
                    <label for="dataFinal_Periodo1">Data final: </label>
                    <input id="dataFinal_Periodo1" type="date">
                </div>
                <div>
                    <label for="dataInicial_Periodo2">Data inicial: </label>
                    <input id="dataInicial_Periodo2" type="date">
                    <label for="dataFinal_Periodo2">Data Final: </label>
                    <input id="dataFinal_Periodo2" type="date">
                </div>
            </div>

            <div id="filtroSensores">
                Voce vai filtrar SENSORES.
            </div>
            <div id="filtroCaixas">
                Voce vai filtrar CAIXAS.
            </div>
    </div>
    </form>
    <script>
        $('#filtroSensores').hide();
        $('#filtroData').hide();
        $('#filtroCaixas').hide();

        $('#periodo1Div').hide();
        $('#periodo2Div').hide();

        document.getElementById('inlineRadio1').addEventListener('change', function() {
            $('#filtroSensores').hide();
            $('#filtroData').show();
            $('#filtroCaixas').hide();

            document.getElementById('inlineRadio4').addEventListener('change', function() {
                $('#periodo1Div').show();
                $('#periodo2Div').hide();
            });

            document.getElementById('inlineRadio5').addEventListener('change', function() {
                $('#periodo2Div').show();
                $('#periodo1Div').hide();
            });

        });
        document.getElementById('inlineRadio2').addEventListener('change', function() {
            $('#periodo1Div').hide();
            $('#periodo2Div').hide();

            $('#filtroSensores').show();
            $('#filtroData').hide();
            $('#filtroCaixas').hide();


        });
        document.getElementById('inlineRadio3').addEventListener('change', function() {
            $('#periodo1Div').hide();
            $('#periodo2Div').hide();

            $('#filtroSensores').hide();
            $('#filtroData').hide();
            $('#filtroCaixas').show();

        });
    </script>
</body>

</html>