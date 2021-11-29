<html>



<head>



    <meta charset="UTF-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="icon" type="imagem/png" href="../../ESPy_Web/assents/imagens/Logo_.png" />



    <title>ESPy | DashBoard</title>



    <link href="../../ESPy_Web/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

    <link href="../../ESPy_Web/css/style.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../../ESPy_Web/js/jquery-3.6.0.min.js"></script>

    <script type="text/javascript" src="../../ESPy_Web/js/bootstrap.min.js"></script>



    <link href="https://fonts.googleapis.com/css2?family=Material+Icons+Outlined" rel="stylesheet" />



    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>



    <script type="text/javascript">
        google.charts.load('current', {

            'packages': ['bar', 'corechart']

        });



        var i = 1;



        function GraficoBarrasIDK() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'IDK'],



                <?php

                include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";



                session_start();

                $codigoEmpresa = $_SESSION['codigoEmpresa'];

                $codigoCaixaColeta = $_GET['codigoCaixaColeta'];



                $resultado = mysqli_query($conexao, "SELECT * FROM caixas_coleta cc where cc.codigo_empresa = '$codigoEmpresa' and cc.codigo = '$codigoCaixaColeta'");

                $resultado2 = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");

                $numrows = mysqli_num_rows($resultado);

                $numrows2 = mysqli_num_rows($resultado2);



                if ($numrows2 <= 0) {

                    header("location: ../../ESPy_Web/Paginas/DashBoard/errorCaixaSemDados.php");
                }



                if ($numrows <= 0) {

                    header("location: ../../ESPy_Web/Paginas/DashBoard/caixasColeta_Page.php");
                }



                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $IDK = $dados['IDK'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $IDK ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Índice de confoto térmico",

                    subtitle: "IDK",



                },

                'colors': ['4A148C']

            };







            var chart = new google.charts.Bar(document.getElementById('IDK'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinhaIDK() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'IDK'],



                <?php

                include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";



                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $IDK = $dados['IDK'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $IDK ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Índice de confoto térmico",

                    subtitle: "IDK",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('IDK'));



            chart.draw(data, options);

        }



        function GraficoBarras_DHT11_Temperatura() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Temperatura (ºC)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $Temperatura = $dados['Temperatura_DHT11'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Temperatura ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Temperatura",

                    subtitle: "Sensor: DHT11",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('DHT11_Temperatura'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_DHT11_Temperatura() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Temperatura (ºC)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $Temperatura = $dados['Temperatura_DHT11'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Temperatura ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Temperatura",

                    subtitle: "Sensor: DHT11",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('DHT11_Temperatura'));



            chart.draw(data, options);

        }



        function GraficoBarras_DHT11_Umidade() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Umidade (%)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $Umidade = $dados['Umidade_DHT11'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Umidade ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Umidade",

                    subtitle: "Sensor: DHT11",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('DHT11_Umidade'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_DHT11_Umidade() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Umidade (%)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $Umidade = $dados['Umidade_DHT11'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Umidade ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Umidade",

                    subtitle: "Sensor: DHT11",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('DHT11_Umidade'));



            chart.draw(data, options);

        }



        function GraficoBarras_BMP180_Temperatura() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Temperatura (ºC)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $Temperatura = $dados['Temperatura_BMP180'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Temperatura ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Temperatura",

                    subtitle: "Sensor: BMP180",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('BMP180_Temperatura'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_BMP180_Temperatura() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Temperatura (ºC)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $Temperatura = $dados['Temperatura_BMP180'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Temperatura ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Temperatura",

                    subtitle: "Sensor: BMP180",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('BMP180_Temperatura'));



            chart.draw(data, options);

        }



        function GraficoBarras_BMP180_PressaoATM() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Pressao Atmosférica (Bar)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $Pressao = $dados['Pressao_BMP180'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Pressao ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Pressao Atmosférica",

                    subtitle: "Sensor: BMP180",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('BMP180_PressaoATM'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_BMP180_PressaoATM() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Pressao Atmosférica (Bar)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $Pressao = $dados['Pressao_BMP180'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Pressao ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Pressao Atmosférica",

                    subtitle: "Sensor: BMP180",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('BMP180_PressaoATM'));



            chart.draw(data, options);

        }



        function GraficoBarras_BMP180_Altitude() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Altitude (m)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $Altitude = $dados['Altitude_BMP180'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Altitude ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Altitude em relação ao nível do mar",

                    subtitle: "Sensor: BMP180",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('BMP180_Altitude'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_BMP180_Altitude() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Altitude (m)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $Altitude = $dados['Altitude_BMP180'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Altitude ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Altitude em relação ao nível do mar",

                    subtitle: "Sensor: BMP180",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('BMP180_Altitude'));



            chart.draw(data, options);

        }



        function GraficoBarras_MICS6814_CO() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Monóxido de Carbono (ppm)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $CO = $dados['MICS_CO'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $CO ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Monóxido de Carbono",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('MICS6814_CO'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_MICS6814_CO() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Monóxido de Carbono (ppm)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $CO = $dados['MICS_CO'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $CO ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Monóxido de Carbono",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('MICS6814_CO'));



            chart.draw(data, options);

        }



        function GraficoBarras_MICS6814_NO2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Dióxido de Nitrogénio (ppm)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $NO2 = $dados['MICS_NO2'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $NO2 ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Dióxido de Nitrogénio",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('MICS6814_NO2'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_MICS6814_NO2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Dióxido de Nitrogénio (ppm)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $NO2 = $dados['MICS_NO2'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $NO2 ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Dióxido de Nitrogénio",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('MICS6814_NO2'));



            chart.draw(data, options);

        }



        function GraficoBarras_MICS6814_NH3() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Hidróxido de Amônia (ppm)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $NH3 = $dados['MICS_NH3'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $NH3 ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Hidróxido de Amônia",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('MICS6814_NH3'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_MICS6814_NH3() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Hidróxido de Amônia (ppm)'],



                <?php

                $sql = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta'");



                while ($dados = mysqli_fetch_array($sql)) {

                    $NH3 = $dados['MICS_NH3'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $NH3 ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Hidróxido de Amônia",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('MICS6814_NH3'));



            chart.draw(data, options);

        }
    </script>

</head>



<body>

    <?php
    include '../../header2.php';
    ?>


    <a class="btn btn-primary btn-lg" id="BtnMudarTipoGrafico" onclick="mudarTipoGrafico()">



        <span class="material-icons-outlined " id="iconBarCharts">



        </span>



    </a>



    <div class="container-fluid p-5" id="IDK">

    </div>



    <div class="container-fluid p-5" id="DHT11_Temperatura">

    </div>



    <div class="container-fluid p-5" id="DHT11_Umidade">

    </div>



    <div class="container-fluid p-5" id="BMP180_Temperatura">

    </div>



    <div class="container-fluid p-5" id="BMP180_PressaoATM">

    </div>



    <div class="container-fluid p-5" id="BMP180_Altitude">

    </div>



    <div class="container-fluid p-5" id="MICS6814_CO">

    </div>



    <div class="container-fluid p-5" id="MICS6814_NO2">

    </div>



    <div class="container-fluid p-5" id="MICS6814_NH3">

    </div>



    <script>
        let btn = document.getElementById("iconBarCharts");



        btn.innerHTML = "show_chart";



        google.charts.setOnLoadCallback(GraficoBarrasIDK);



        google.charts.setOnLoadCallback(GraficoBarras_DHT11_Temperatura);

        google.charts.setOnLoadCallback(GraficoBarras_DHT11_Umidade);



        google.charts.setOnLoadCallback(GraficoBarras_BMP180_Temperatura);

        google.charts.setOnLoadCallback(GraficoBarras_BMP180_PressaoATM);

        google.charts.setOnLoadCallback(GraficoBarras_BMP180_Altitude);



        google.charts.setOnLoadCallback(GraficoBarras_MICS6814_CO);

        google.charts.setOnLoadCallback(GraficoBarras_MICS6814_NO2);

        google.charts.setOnLoadCallback(GraficoBarras_MICS6814_NH3);



        function mudarTipoGrafico() {



            if (i % 2 == 0) {



                btn.innerHTML = "show_chart";



                google.charts.setOnLoadCallback(GraficoBarrasIDK);



                google.charts.setOnLoadCallback(GraficoBarras_DHT11_Temperatura);

                google.charts.setOnLoadCallback(GraficoBarras_DHT11_Umidade);



                google.charts.setOnLoadCallback(GraficoBarras_BMP180_Temperatura);

                google.charts.setOnLoadCallback(GraficoBarras_BMP180_PressaoATM);

                google.charts.setOnLoadCallback(GraficoBarras_BMP180_Altitude);



                google.charts.setOnLoadCallback(GraficoBarras_MICS6814_CO);

                google.charts.setOnLoadCallback(GraficoBarras_MICS6814_NO2);

                google.charts.setOnLoadCallback(GraficoBarras_MICS6814_NH3);



            } else {



                btn.innerHTML = "bar_chart";



                google.charts.setOnLoadCallback(GraficoLinhaIDK);



                google.charts.setOnLoadCallback(GraficoLinha_DHT11_Temperatura);

                google.charts.setOnLoadCallback(GraficoLinha_DHT11_Umidade);



                google.charts.setOnLoadCallback(GraficoLinha_BMP180_Temperatura);

                google.charts.setOnLoadCallback(GraficoLinha_BMP180_PressaoATM);

                google.charts.setOnLoadCallback(GraficoLinha_BMP180_Altitude);



                google.charts.setOnLoadCallback(GraficoLinha_MICS6814_CO);

                google.charts.setOnLoadCallback(GraficoLinha_MICS6814_NO2);

                google.charts.setOnLoadCallback(GraficoLinha_MICS6814_NH3);

            }

            i++;

        }
    </script>



</body>



</html>