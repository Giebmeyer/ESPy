<html>



<head>



    <meta charset="UTF-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="icon" type="imagem/png" href="../../ESPy_Web/assents/imagens/Logo_.png" />



    <title>ESPy | DashBoard</title>



    <link href="../../ESPy_Web/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

    <link href="../../css/style.css" rel="stylesheet" type="text/css" />
    <script src="../../js/functons.js"></script>

    <script type="text/javascript" src="../../ESPy_Web/js/jquery-3.6.0.min.js"></script>

    <script type="text/javascript" src="../../ESPy_Web/js/bootstrap.min.js"></script>



    <link href="https://fonts.googleapis.com/css2?family=Material+Icons+Outlined" rel="stylesheet" />



    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

    <script>
        <?php
        session_start();

        $codigoEmpresa = $_SESSION['codigoEmpresa'];
        $codigoCaixaColeta = $_GET['codigoCaixaColeta'];
        $dataInicialp1 = $_GET['dataInicialp1'];
        $dataFinalp1 = $_GET['dataFinalp1'];
        $dataInicialp2 = $_GET['dataInicialp2'];
        $dataFinalp2 = $_GET['dataFinalp2'];

        $sqlP1 = "select * from dados d where d.codigo_caixa = '$codigoCaixaColeta' and DATE(Data_Hora) >= '$dataInicialp1' and DATE(Data_Hora) <= '$dataFinalp1' order by d.sequencia asc";
        $sqlP2 = "select * from dados d where d.codigo_caixa = '$codigoCaixaColeta' and DATE(Data_Hora) >= '$dataInicialp2' and DATE(Data_Hora) <= '$dataFinalp2' order by d.sequencia asc";

        ?>



        google.charts.load('current', {

            'packages': ['bar', 'corechart']

        });



        var i = 1;



        function GraficoBarrasIDKp1() {
            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'IDK'],



                <?php

                include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";


                $resultado = mysqli_query($conexao, "SELECT * FROM caixas_coleta cc where cc.codigo_empresa = '$codigoEmpresa' and cc.codigo = '$codigoCaixaColeta'");

                $resultado2 = mysqli_query($conexao, $sqlP1);

                $numrows = mysqli_num_rows($resultado);

                $numrows2 = mysqli_num_rows($resultado2);


                $sql = mysqli_query($conexao, $sqlP1);

                if ($numrows <= 0) {
                    $_SESSION['caixaColetaSemDados'] = "NaoPertence";
                    header("location: ../../ESPy_Web/Paginas/DashBoard/caixasColeta_Page.php");
                } else {
                    if ($numrows2 <= 0) {
                        $_SESSION['caixaColetaSemDados'] = "SemDados";
                        header("location: ../../ESPy_Web/Paginas/DashBoard/caixasColeta_Page.php");
                    }else{
                    $resultadop1 = mysqli_query($conexao, "select * from dados d where d.codigo_caixa = '$codigoCaixaColeta' and DATE(Data_Hora) >= '$dataInicialp1' and DATE(Data_Hora) <= '$dataFinalp1' order by d.sequencia desc limit 1");
                    $resultadop2 = mysqli_query($conexao, "select * from dados d where d.codigo_caixa = '$codigoCaixaColeta' and DATE(Data_Hora) >= '$dataInicialp2' and DATE(Data_Hora) <= '$dataFinalp2' order by d.sequencia desc limit 1");
                while ($dados = mysqli_fetch_array($resultadop1)) {
            
                $IDKp1 = $dados['IDK'];
            
                $sequenciap1 = $dados['sequencia']; 
                
                $Ult_TemperaturaDHT11p1 = $dados['Temperatura_DHT11'];
                $Ult_UmidadeDHT11p1 = $dados['Umidade_DHT11'];
                
                $Ult_TemperaturaBMP180p1 = $dados['Temperatura_BMP180'];
                $Ult_PressaoBMP180p1 = $dados['Pressao_BMP180'];
                $Ult_AltitudeBMP180p1 = $dados['Altitude_BMP180'];
                
                $Ult_MICS_COp1 = $dados['MICS_CO'];
                $Ult_MICS_NO2p1 = $dados['MICS_NO2'];
                $Ult_MICS_NH3p1 = $dados['MICS_NH3'];
            
                    }
                    
                    while ($dados = mysqli_fetch_array($resultadop2)) {
            
                $IDKp2 = $dados['IDK'];
            
                $sequenciap2 = $dados['sequencia']; 
                
                $Ult_TemperaturaDHT11p2 = $dados['Temperatura_DHT11'];
                $Ult_UmidadeDHT11p2 = $dados['Umidade_DHT11'];
                
                $Ult_TemperaturaBMP180p2 = $dados['Temperatura_BMP180'];
                $Ult_PressaoBMP180p2 = $dados['Pressao_BMP180'];
                $Ult_AltitudeBMP180p2 = $dados['Altitude_BMP180'];
                
                $Ult_MICS_COp2 = $dados['MICS_CO'];
                $Ult_MICS_NO2p2 = $dados['MICS_NO2'];
                $Ult_MICS_NH3p2 = $dados['MICS_NH3'];
                
                
            
                        }
                   
                    
                        function validaEstadoIDK($idk){
                            if($idk > 80){
                                return 'Estresse devido ao calor';
                            }else if( $idk > 75 && $idk <= 80){
                                return 'Desconforto devido ao calor';
                            }else if( $idk > 60 && $idk <= 75){
                                return 'Confort??vel';
                            }else if( $idk > 55 && $idk <= 60){
                                return 'Desconforto devido ao frio';
                            }else{
                                return 'Estresse devido ao frio';
                            }
                        }
                        $estadosConfortop1 = validaEstadoIDK($IDKp1); 
                        $estadosConfortop2 = validaEstadoIDK($IDKp2); 
                    }
                }


                while ($dados = mysqli_fetch_array($sql)) {

                    $IDK = $dados['IDK'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $IDK ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "??ndice de confoto t??rmico",

                    subtitle: "IDK",



                },

                'colors': ['4A148C']

            };







            var chart = new google.charts.Bar(document.getElementById('IDKp1'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinhaIDKp1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'IDK'],



                <?php

                include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";



                $sql = mysqli_query($conexao, $sqlP1);



                while ($dados = mysqli_fetch_array($sql)) {

                    $IDK = $dados['IDK'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $IDK ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "??ndice de confoto t??rmico",

                    subtitle: "IDK",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('IDKp1'));



            chart.draw(data, options);

        }



        function GraficoBarras_DHT11_Temperaturap1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Temperatura (??C)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



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



            var chart = new google.charts.Bar(document.getElementById('DHT11_Temperaturap1'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_DHT11_Temperaturap1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Temperatura (??C)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



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



            var chart = new google.visualization.LineChart(document.getElementById('DHT11_Temperaturap1'));



            chart.draw(data, options);

        }



        function GraficoBarras_DHT11_Umidadep1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Umidade (%)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



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



            var chart = new google.charts.Bar(document.getElementById('DHT11_Umidadep1'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_DHT11_Umidadep1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Umidade (%)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



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



            var chart = new google.visualization.LineChart(document.getElementById('DHT11_Umidadep1'));



            chart.draw(data, options);

        }



        function GraficoBarras_BMP180_Temperaturap1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Temperatura (??C)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



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



            var chart = new google.charts.Bar(document.getElementById('BMP180_Temperaturap1'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_BMP180_Temperaturap1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Temperatura (??C)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



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



            var chart = new google.visualization.LineChart(document.getElementById('BMP180_Temperaturap1'));



            chart.draw(data, options);

        }



        function GraficoBarras_BMP180_PressaoATMp1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Pressao Atmosf??rica (Pa)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



                while ($dados = mysqli_fetch_array($sql)) {

                    $Pressao = $dados['Pressao_BMP180'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Pressao ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Pressao Atmosf??rica",

                    subtitle: "Sensor: BMP180",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('BMP180_PressaoATMp1'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_BMP180_PressaoATMp1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Pressao Atmosf??rica (Pa)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



                while ($dados = mysqli_fetch_array($sql)) {

                    $Pressao = $dados['Pressao_BMP180'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Pressao ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Pressao Atmosf??rica",

                    subtitle: "Sensor: BMP180",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('BMP180_PressaoATMp1'));



            chart.draw(data, options);

        }



        function GraficoBarras_BMP180_Altitudep1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Altitude (m)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



                while ($dados = mysqli_fetch_array($sql)) {

                    $Altitude = $dados['Altitude_BMP180'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Altitude ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Altitude em rela????o ao n??vel do mar",

                    subtitle: "Sensor: BMP180",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('BMP180_Altitudep1'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_BMP180_Altitudep1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Altitude (m)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



                while ($dados = mysqli_fetch_array($sql)) {

                    $Altitude = $dados['Altitude_BMP180'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Altitude ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Altitude em rela????o ao n??vel do mar",

                    subtitle: "Sensor: BMP180",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('BMP180_Altitudep1'));



            chart.draw(data, options);

        }



        function GraficoBarras_MICS6814_COp1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Mon??xido de Carbono (ppm)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



                while ($dados = mysqli_fetch_array($sql)) {

                    $CO = $dados['MICS_CO'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $CO ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Mon??xido de Carbono",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('MICS6814_COp1'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_MICS6814_COp1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Mon??xido de Carbono (ppm)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



                while ($dados = mysqli_fetch_array($sql)) {

                    $CO = $dados['MICS_CO'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $CO ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Mon??xido de Carbono",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('MICS6814_COp1'));



            chart.draw(data, options);

        }



        function GraficoBarras_MICS6814_NO2p1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Di??xido de Nitrog??nio (ppm)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



                while ($dados = mysqli_fetch_array($sql)) {

                    $NO2 = $dados['MICS_NO2'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $NO2 ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Di??xido de Nitrog??nio",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('MICS6814_NO2p1'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_MICS6814_NO2p1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Di??xido de Nitrog??nio (ppm)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



                while ($dados = mysqli_fetch_array($sql)) {

                    $NO2 = $dados['MICS_NO2'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $NO2 ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Di??xido de Nitrog??nio",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('MICS6814_NO2p1'));



            chart.draw(data, options);

        }



        function GraficoBarras_MICS6814_NH3p1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Hidr??xido de Am??nia (ppm)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



                while ($dados = mysqli_fetch_array($sql)) {

                    $NH3 = $dados['MICS_NH3'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $NH3 ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Hidr??xido de Am??nia",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('MICS6814_NH3p1'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_MICS6814_NH3p1() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Hidr??xido de Am??nia (ppm)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP1);



                while ($dados = mysqli_fetch_array($sql)) {

                    $NH3 = $dados['MICS_NH3'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $NH3 ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Hidr??xido de Am??nia",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('MICS6814_NH3p1'));



            chart.draw(data, options);

        }




        google.charts.load('current', {

            'packages': ['bar', 'corechart']

        });



        var i = 1;



        function GraficoBarrasIDKp2() {
            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'IDK'],



                <?php

                include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";

                $sql = mysqli_query($conexao, $sqlP2);



                while ($dados = mysqli_fetch_array($sql)) {

                    $IDK = $dados['IDK'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $IDK ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "??ndice de confoto t??rmico",

                    subtitle: "IDK",



                },

                'colors': ['4A148C']

            };







            var chart = new google.charts.Bar(document.getElementById('IDKp2'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinhaIDKp2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'IDK'],



                <?php

                include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";



                $sql = mysqli_query($conexao, $sqlP2);



                while ($dados = mysqli_fetch_array($sql)) {

                    $IDK = $dados['IDK'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $IDK ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "??ndice de confoto t??rmico",

                    subtitle: "IDK",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('IDKp2'));



            chart.draw(data, options);

        }



        function GraficoBarras_DHT11_Temperaturap2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Temperatura (??C)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



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



            var chart = new google.charts.Bar(document.getElementById('DHT11_Temperaturap2'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_DHT11_Temperaturap2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Temperatura (??C)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



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



            var chart = new google.visualization.LineChart(document.getElementById('DHT11_Temperaturap2'));



            chart.draw(data, options);

        }



        function GraficoBarras_DHT11_Umidadep2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Umidade (%)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



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



            var chart = new google.charts.Bar(document.getElementById('DHT11_Umidadep2'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_DHT11_Umidadep2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Umidade (%)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



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



            var chart = new google.visualization.LineChart(document.getElementById('DHT11_Umidadep2'));



            chart.draw(data, options);

        }



        function GraficoBarras_BMP180_Temperaturap2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Temperatura (??C)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



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



            var chart = new google.charts.Bar(document.getElementById('BMP180_Temperaturap2'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_BMP180_Temperaturap2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Temperatura (??C)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



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



            var chart = new google.visualization.LineChart(document.getElementById('BMP180_Temperaturap2'));



            chart.draw(data, options);

        }



        function GraficoBarras_BMP180_PressaoATMp2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Pressao Atmosf??rica (Pa)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



                while ($dados = mysqli_fetch_array($sql)) {

                    $Pressao = $dados['Pressao_BMP180'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Pressao ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Pressao Atmosf??rica",

                    subtitle: "Sensor: BMP180",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('BMP180_PressaoATMp2'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_BMP180_PressaoATMp2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Pressao Atmosf??rica (Pa)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



                while ($dados = mysqli_fetch_array($sql)) {

                    $Pressao = $dados['Pressao_BMP180'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Pressao ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Pressao Atmosf??rica",

                    subtitle: "Sensor: BMP180",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('BMP180_PressaoATMp2'));



            chart.draw(data, options);

        }



        function GraficoBarras_BMP180_Altitudep2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Altitude (m)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



                while ($dados = mysqli_fetch_array($sql)) {

                    $Altitude = $dados['Altitude_BMP180'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Altitude ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Altitude em rela????o ao n??vel do mar",

                    subtitle: "Sensor: BMP180",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('BMP180_Altitudep2'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_BMP180_Altitudep2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Altitude (m)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



                while ($dados = mysqli_fetch_array($sql)) {

                    $Altitude = $dados['Altitude_BMP180'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $Altitude ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Altitude em rela????o ao n??vel do mar",

                    subtitle: "Sensor: BMP180",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('BMP180_Altitudep2'));



            chart.draw(data, options);

        }



        function GraficoBarras_MICS6814_COp2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Mon??xido de Carbono (ppm)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



                while ($dados = mysqli_fetch_array($sql)) {

                    $CO = $dados['MICS_CO'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $CO ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Mon??xido de Carbono",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('MICS6814_COp2'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_MICS6814_COp2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Mon??xido de Carbono (ppm)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



                while ($dados = mysqli_fetch_array($sql)) {

                    $CO = $dados['MICS_CO'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $CO ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Mon??xido de Carbono",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('MICS6814_COp2'));



            chart.draw(data, options);

        }



        function GraficoBarras_MICS6814_NO2p2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Di??xido de Nitrog??nio (ppm)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



                while ($dados = mysqli_fetch_array($sql)) {

                    $NO2 = $dados['MICS_NO2'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $NO2 ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Di??xido de Nitrog??nio",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('MICS6814_NO2p2'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_MICS6814_NO2p2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Di??xido de Nitrog??nio (ppm)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



                while ($dados = mysqli_fetch_array($sql)) {

                    $NO2 = $dados['MICS_NO2'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $NO2 ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Di??xido de Nitrog??nio",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('MICS6814_NO2p2'));



            chart.draw(data, options);

        }



        function GraficoBarras_MICS6814_NH3p2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Hidr??xido de Am??nia (ppm)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



                while ($dados = mysqli_fetch_array($sql)) {

                    $NH3 = $dados['MICS_NH3'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $NH3 ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Hidr??xido de Am??nia",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.charts.Bar(document.getElementById('MICS6814_NH3p2'));



            chart.draw(data, google.charts.Bar.convertOptions(options));

        }



        function GraficoLinha_MICS6814_NH3p2() {

            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'Hidr??xido de Am??nia (ppm)'],



                <?php

                $sql = mysqli_query($conexao, $sqlP2);



                while ($dados = mysqli_fetch_array($sql)) {

                    $NH3 = $dados['MICS_NH3'];

                    $sequencia = $dados['sequencia']; ?>



                    [<?php echo $sequencia ?>, <?php echo $NH3 ?>],



                <?php } ?>

            ]);



            var options = {

                chart: {

                    title: "Hidr??xido de Am??nia",

                    subtitle: "Sensor: MICS6814",

                },

                'colors': ['4A148C']

            };



            var chart = new google.visualization.LineChart(document.getElementById('MICS6814_NH3p2'));



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

    <?php
    $dataInicialp1 = DATE('d-m-Y', strtotime($dataInicialp1));
    $dataFinalp1 = DATE('d-m-Y', strtotime($dataFinalp1));
    $dataInicialp2 = DATE('d-m-Y', strtotime($dataInicialp2));
    $dataFinalp2 = DATE('d-m-Y', strtotime($dataFinalp2));
    ?>

    <div id="graficosP1">
<div class="row justify-content-center align-items-center">
         
             Ultimos dados coletados:
        <div class="row justify-content-center align-items-center">
            <?php echo "Periodo de filtro $dataInicialp1 a $dataFinalp1" ?>
        </div>
        
              
        
         <div class="row justify-content-center align-items-center" id="UltimosDadosColetados">
            </br>
            <?php
               echo " 
               <div id='UltimosDadosColetadosInternos'>
                    <b>??ndice de conforto t??rmico:</b> $IDKp1</br>
                    <b>Estado de conforto:</b> $estadosConfortop1</br>
               </div>
               
               <div id='UltimosDadosColetadosInternos'>
               <div class='row justify-content-center align-items-center'>
                    Sensor DHT11
               </div>
                   <b> Temperatura: </b> $Ult_TemperaturaDHT11p1 (??C)</br>
                   <b> Umidade: </b>$Ult_UmidadeDHT11p1</br>
               </div>   
               
               <div id='UltimosDadosColetadosInternos'>
                      <div class='row justify-content-center align-items-center'>
                 Sensor BMP180
                   </div>
                    <b> Temperatura:</b> $Ult_TemperaturaBMP180p1 (??C)</br>
                     <b> Press??o Atmosf??rica:</b> $Ult_PressaoBMP180p1 (Pa)</br>
                    <b> Altitude:</b> $Ult_AltitudeBMP180p1 (m)</br>
               </div>   
               
               <div id='UltimosDadosColetadosInternos'>
                      <div class='row justify-content-center align-items-center'>
                  Sensor MICS-6814
               </div>
                     <b> Mon??xido de Carbono </b>$Ult_MICS_COp1 (ppm)</br>
                    <b> Di??xido de Nitrog??nio </b>$Ult_MICS_NO2p1</br>
                    <b> Hidr??xido de Am??nia </b>$Ult_MICS_NH3p1</br>
               </div>";
                  
               ?>
         </div>
      </div>

        <div class="container-fluid p-5" id="IDKp1">

        </div>



        <div class="container-fluid p-5" id="DHT11_Temperaturap1">

        </div>



        <div class="container-fluid p-5" id="DHT11_Umidadep1">

        </div>



        <div class="container-fluid p-5" id="BMP180_Temperaturap1">

        </div>



        <div class="container-fluid p-5" id="BMP180_PressaoATMp1">

        </div>



        <div class="container-fluid p-5" id="BMP180_Altitudep1">

        </div>



        <div class="container-fluid p-5" id="MICS6814_COp1">

        </div>



        <div class="container-fluid p-5" id="MICS6814_NO2p1">

        </div>



        <div class="container-fluid p-5" id="MICS6814_NH3p1">

        </div>
    </div>


    <div id="graficosP2">
                      <div class="row justify-content-center align-items-center">
         
             Ultimos dados coletados:
        
        <div class="row justify-content-center align-items-center">
            <?php echo "Periodo de filtro $dataInicialp2 a $dataFinalp2" ?>
        </div>
        
                 <div class="row justify-content-center align-items-center" id="UltimosDadosColetados">
            </br>
            <?php
               echo " 
               <div id='UltimosDadosColetadosInternos'>
                    <b>??ndice de conforto t??rmico:</b> $IDKp2</br>
                      <b>Estado de conforto:</b> $estadosConfortop2</br>
               </div>
               
               <div id='UltimosDadosColetadosInternos'>
               <div class='row justify-content-center align-items-center'>
                    Sensor DHT11
               </div>
                   <b> Temperatura: </b> $Ult_TemperaturaDHT11p2 (??C)</br>
                   <b> Umidade: </b>$Ult_UmidadeDHT11p2</br>
               </div>   
               
               <div id='UltimosDadosColetadosInternos'>
                      <div class='row justify-content-center align-items-center'>
                 Sensor BMP180
                   </div>
                    <b> Temperatura:</b> $Ult_TemperaturaBMP180p2 (??C)</br>
                     <b> Press??o Atmosf??rica:</b> $Ult_PressaoBMP180p2 (Pa)</br>
                    <b> Altitude:</b> $Ult_AltitudeBMP180p2 (m)</br>
               </div>   
               
               <div id='UltimosDadosColetadosInternos'>
                      <div class='row justify-content-center align-items-center'>
                  Sensor MICS-6814
               </div>
                     <b> Mon??xido de Carbono </b>$Ult_MICS_COp2 (ppm)</br>
                    <b> Di??xido de Nitrog??nio </b>$Ult_MICS_NO2p2</br>
                    <b> Hidr??xido de Am??nia </b>$Ult_MICS_NH3p2</br>
               </div>";
                  
               ?>
         </div>
      </div>
        <div class="container-fluid p-5" id="IDKp2">

        </div>



        <div class="container-fluid p-5" id="DHT11_Temperaturap2">

        </div>



        <div class="container-fluid p-5" id="DHT11_Umidadep2">

        </div>



        <div class="container-fluid p-5" id="BMP180_Temperaturap2">

        </div>



        <div class="container-fluid p-5" id="BMP180_PressaoATMp2">

        </div>



        <div class="container-fluid p-5" id="BMP180_Altitudep2">

        </div>



        <div class="container-fluid p-5" id="MICS6814_COp2">

        </div>



        <div class="container-fluid p-5" id="MICS6814_NO2p2">

        </div>



        <div class="container-fluid p-5" id="MICS6814_NH3p2">

        </div>
    </div>



    <script>
        let btn = document.getElementById("iconBarCharts");



        btn.innerHTML = "show_chart";



        google.charts.setOnLoadCallback(GraficoBarrasIDKp1);



        google.charts.setOnLoadCallback(GraficoBarras_DHT11_Temperaturap1);

        google.charts.setOnLoadCallback(GraficoBarras_DHT11_Umidadep1);



        google.charts.setOnLoadCallback(GraficoBarras_BMP180_Temperaturap1);

        google.charts.setOnLoadCallback(GraficoBarras_BMP180_PressaoATMp1);

        google.charts.setOnLoadCallback(GraficoBarras_BMP180_Altitudep1);



        google.charts.setOnLoadCallback(GraficoBarras_MICS6814_COp1);

        google.charts.setOnLoadCallback(GraficoBarras_MICS6814_NO2p1);

        google.charts.setOnLoadCallback(GraficoBarras_MICS6814_NH3p1);




        google.charts.setOnLoadCallback(GraficoBarrasIDKp2);



        google.charts.setOnLoadCallback(GraficoBarras_DHT11_Temperaturap2);

        google.charts.setOnLoadCallback(GraficoBarras_DHT11_Umidadep2);



        google.charts.setOnLoadCallback(GraficoBarras_BMP180_Temperaturap2);

        google.charts.setOnLoadCallback(GraficoBarras_BMP180_PressaoATMp2);

        google.charts.setOnLoadCallback(GraficoBarras_BMP180_Altitudep2);



        google.charts.setOnLoadCallback(GraficoBarras_MICS6814_COp2);

        google.charts.setOnLoadCallback(GraficoBarras_MICS6814_NO2p2);

        google.charts.setOnLoadCallback(GraficoBarras_MICS6814_NH3p2);



        function mudarTipoGrafico() {



            if (i % 2 == 0) {



                btn.innerHTML = "show_chart";



                google.charts.setOnLoadCallback(GraficoBarrasIDKp1);



                google.charts.setOnLoadCallback(GraficoBarras_DHT11_Temperaturap1);

                google.charts.setOnLoadCallback(GraficoBarras_DHT11_Umidadep1);



                google.charts.setOnLoadCallback(GraficoBarras_BMP180_Temperaturap1);

                google.charts.setOnLoadCallback(GraficoBarras_BMP180_PressaoATMp1);

                google.charts.setOnLoadCallback(GraficoBarras_BMP180_Altitudep1);



                google.charts.setOnLoadCallback(GraficoBarras_MICS6814_COp1);

                google.charts.setOnLoadCallback(GraficoBarras_MICS6814_NO2p1);

                google.charts.setOnLoadCallback(GraficoBarras_MICS6814_NH3p1);

                google.charts.setOnLoadCallback(GraficoBarrasIDKp2);



                google.charts.setOnLoadCallback(GraficoBarras_DHT11_Temperaturap2);

                google.charts.setOnLoadCallback(GraficoBarras_DHT11_Umidadep2);



                google.charts.setOnLoadCallback(GraficoBarras_BMP180_Temperaturap2);

                google.charts.setOnLoadCallback(GraficoBarras_BMP180_PressaoATMp2);

                google.charts.setOnLoadCallback(GraficoBarras_BMP180_Altitudep2);



                google.charts.setOnLoadCallback(GraficoBarras_MICS6814_COp2);

                google.charts.setOnLoadCallback(GraficoBarras_MICS6814_NO2p2);

                google.charts.setOnLoadCallback(GraficoBarras_MICS6814_NH3p2);



            } else {



                btn.innerHTML = "bar_chart";



                google.charts.setOnLoadCallback(GraficoLinhaIDKp1);



                google.charts.setOnLoadCallback(GraficoLinha_DHT11_Temperaturap1);

                google.charts.setOnLoadCallback(GraficoLinha_DHT11_Umidadep1);



                google.charts.setOnLoadCallback(GraficoLinha_BMP180_Temperaturap1);

                google.charts.setOnLoadCallback(GraficoLinha_BMP180_PressaoATMp1);

                google.charts.setOnLoadCallback(GraficoLinha_BMP180_Altitudep1);



                google.charts.setOnLoadCallback(GraficoLinha_MICS6814_COp1);

                google.charts.setOnLoadCallback(GraficoLinha_MICS6814_NO2p1);

                google.charts.setOnLoadCallback(GraficoLinha_MICS6814_NH3p1);


                google.charts.setOnLoadCallback(GraficoLinhaIDKp2);



                google.charts.setOnLoadCallback(GraficoLinha_DHT11_Temperaturap2);

                google.charts.setOnLoadCallback(GraficoLinha_DHT11_Umidadep2);



                google.charts.setOnLoadCallback(GraficoLinha_BMP180_Temperaturap2);

                google.charts.setOnLoadCallback(GraficoLinha_BMP180_PressaoATMp2);

                google.charts.setOnLoadCallback(GraficoLinha_BMP180_Altitudep2);



                google.charts.setOnLoadCallback(GraficoLinha_MICS6814_COp2);

                google.charts.setOnLoadCallback(GraficoLinha_MICS6814_NO2p2);

                google.charts.setOnLoadCallback(GraficoLinha_MICS6814_NH3p2);

            }

            i++;

        }
    </script>



</body>



</html>