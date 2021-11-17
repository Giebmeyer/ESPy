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

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script type="text/javascript">
        google.charts.load('current', {
            'packages': ['bar']
        });

        google.charts.setOnLoadCallback(GraficoBarrasIDK);

        google.charts.setOnLoadCallback(GraficoBarras_DHT11_Temperatura);
        google.charts.setOnLoadCallback(GraficoBarras_DHT11_Umidade);

        google.charts.setOnLoadCallback(GraficoBarras_BMP180_Temperatura);
        google.charts.setOnLoadCallback(GraficoBarras_BMP180_PressaoATM);
        google.charts.setOnLoadCallback(GraficoBarras_BMP180_Altitude);

        google.charts.setOnLoadCallback(GraficoBarras_MICS6814_CO);
        google.charts.setOnLoadCallback(GraficoBarras_MICS6814_NO2);
        google.charts.setOnLoadCallback(GraficoBarras_MICS6814_NH3);

        function GraficoBarrasIDK() {
            var data = google.visualization.arrayToDataTable([
                ['Sequencia', 'IDK'],

                <?php
                include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

                session_start();
                $codigoEmpresa = $_SESSION['codigoEmpresa'];
                $codigoCaixaColeta = $_GET['codigoCaixaColeta'];

                $resultado = mysqli_query($conexao, "SELECT * FROM caixas_coleta cc where cc.codigo_empresa = '$codigoEmpresa' and cc.codigo = '$codigoCaixaColeta'");
                $numrows = mysqli_num_rows($resultado);

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
                }
            };

            var chart = new google.charts.Bar(document.getElementById('IDK_GraficoBarra'));

            chart.draw(data, google.charts.Bar.convertOptions(options));
        }

        function GraficoBarras_DHT11_Temperatura() {
            var data = google.visualization.arrayToDataTable([
                ['Sequencia', 'Temperatura'],

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
                }
            };

            var chart = new google.charts.Bar(document.getElementById('DHT11_Temperatura_GraficoBarra'));

            chart.draw(data, google.charts.Bar.convertOptions(options));
        }

        function GraficoBarras_DHT11_Umidade() {
            var data = google.visualization.arrayToDataTable([
                ['Sequencia', 'Umidade'],

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
                }
            };

            var chart = new google.charts.Bar(document.getElementById('DHT11_Umidade_GraficoBarra'));

            chart.draw(data, google.charts.Bar.convertOptions(options));
        }

        function GraficoBarras_BMP180_Temperatura() {
            var data = google.visualization.arrayToDataTable([
                ['Sequencia', 'Temperatura'],

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
                }
            };

            var chart = new google.charts.Bar(document.getElementById('BMP180_Temperatura_GraficoBarra'));

            chart.draw(data, google.charts.Bar.convertOptions(options));
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
                }
            };

            var chart = new google.charts.Bar(document.getElementById('BMP180_PressaoATM_GraficoBarra'));

            chart.draw(data, google.charts.Bar.convertOptions(options));
        }

        function GraficoBarras_BMP180_Altitude() {
            var data = google.visualization.arrayToDataTable([
                ['Sequencia', 'Altitude'],

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
                }
            };

            var chart = new google.charts.Bar(document.getElementById('BMP180_Altitude_GraficoBarra'));

            chart.draw(data, google.charts.Bar.convertOptions(options));
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
                }
            };

            var chart = new google.charts.Bar(document.getElementById('MICS6814_CO_GraficoBarra'));

            chart.draw(data, google.charts.Bar.convertOptions(options));
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
                }
            };

            var chart = new google.charts.Bar(document.getElementById('MICS6814_NO2_GraficoBarra'));

            chart.draw(data, google.charts.Bar.convertOptions(options));
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
                }
            };

            var chart = new google.charts.Bar(document.getElementById('MICS6814_NH3_GraficoBarra'));

            chart.draw(data, google.charts.Bar.convertOptions(options));
        }

    </script>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <nav class="navbar navbar-light bg-light">
            <a class="navbar-brand" href="../../ESPy_Web/Paginas/Usuario/inicial_Page.php">
                <img src="../../ESPy_Web/assents/imagens/ic_launcher_foreground.png" width="50" height="50" alt="">
            </a>
        </nav>
        <a class="navbar-brand" href="../../ESPy_Web/Paginas/Usuario/inicial_Page.php">ESPy</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#conteudoNavbarSuportado" aria-controls="conteudoNavbarSuportado" aria-expanded="false" aria-label="Alterna navegação">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="conteudoNavbarSuportado">
            <ul class="navbar-nav mr-auto">
                <li class="nav-link disabled">|</li>
                <li class="nav-item active">
                    <a class="nav-link" href="../../ESPy_Web/Paginas/Empresa/minhaEmpresa_Page.php">Minha Epresa</a>
                </li>

                <li class="nav-link disabled">|</li>
                <li class="nav-item active">
                    <a class="nav-link" href="../../ESPy_Web/Paginas/Usuario/meuPerfil_Page.php">Meu Perfil</a>
                </li>

                <li class="nav-link disabled">|</li>
                <li class="nav-item">
                    <a class="nav-link" href="../../ESPy_Web/Paginas/Usuario/inicial_Page.php">Principal</a>
                </li>

                <li class="nav-link disabled">|</li>
                <li class="nav-item">
                    <a class="nav-link" href="../../ESPy_Web/Paginas/DashBoard/caixasColeta_Page.php">Caixas de Coleta</a>
                </li>

                <li class="nav-link disabled">|</li>
                <li class="nav-item">
                    <a class="nav-link" href="../../ESPy_Php/WEB/ESPy_logoff.php?sair=true">Sair</a>
                </li>

        </div>
        </ul>
        </div>
    </nav>

    <div class="container-fluid p-5" id="IDK_GraficoBarra">
    </div>

    <div class="container-fluid p-5" id="DHT11_Temperatura_GraficoBarra">
    </div>

    <div class="container-fluid p-5" id="DHT11_Umidade_GraficoBarra">
    </div>

    <div class="container-fluid p-5" id="BMP180_Temperatura_GraficoBarra">
    </div>

    <div class="container-fluid p-5" id="BMP180_PressaoATM_GraficoBarra">
    </div>

    <div class="container-fluid p-5" id="BMP180_Altitude_GraficoBarra">
    </div>

    <div class="container-fluid p-5" id="MICS6814_CO_GraficoBarra">
    </div>

    <div class="container-fluid p-5" id="MICS6814_NO2_GraficoBarra">
    </div>

    <div class="container-fluid p-5" id="MICS6814_NH3_GraficoBarra">
    </div>

</body>

</html>