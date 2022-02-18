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
        $dataInicial = $_GET['dataInicial'];
        $dataFinal = $_GET['dataFinal'];


        ?>

        google.charts.load('current', {

            'packages': ['bar', 'corechart']

        });



        var i = 1;



        function GraficoBarrasIDK() {
            var data = google.visualization.arrayToDataTable([

                ['Sequencia', 'IDK'],



                <?php

                include "../../ESPy_MySql/ESPy_MySqlCredenciais.php";


                $sqlPrincipal = "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta' and DATE(Data_Hora) >= '$dataInicial' and DATE(Data_Hora) <= '$dataFinal'";



                $resultado = mysqli_query($conexao, "SELECT * FROM caixas_coleta cc where cc.codigo_empresa = '$codigoEmpresa' and cc.codigo = '$codigoCaixaColeta'");

                $resultado2 = mysqli_query($conexao, $sqlPrincipal);

                $numrows = mysqli_num_rows($resultado);

                $numrows2 = mysqli_num_rows($resultado2);


                $sql = mysqli_query($conexao, $sqlPrincipal);

                if ($numrows <= 0) {
                    $_SESSION['caixaColetaSemDados'] = "NaoPertence";
                    header("location: ../../ESPy_Web/Paginas/DashBoard/caixasColeta_Page.php");
                } else {
                    if ($numrows2 <= 0) {
                        $_SESSION['caixaColetaSemDados'] = "SemDados";
                        header("location: ../../ESPy_Web/Paginas/DashBoard/caixasColeta_Page.php");
                    }else{
                    $resultado3 = mysqli_query($conexao, "SELECT * FROM dados where codigo_caixa = '$codigoCaixaColeta' order by sequencia desc limit 1");
                while ($dados = mysqli_fetch_array($resultado3)) {
            
                $IDK = $dados['IDK'];
            
                $sequencia = $dados['sequencia']; 
                
                $Ult_TemperaturaDHT11 = $dados['Temperatura_DHT11'];
                $Ult_UmidadeDHT11 = $dados['Umidade_DHT11'];
                
                $Ult_TemperaturaBMP180 = $dados['Temperatura_BMP180'];
                $Ult_PressaoBMP180 = $dados['Pressao_BMP180'];
                $Ult_AltitudeBMP180 = $dados['Altitude_BMP180'];
                
                $Ult_MICS_CO = $dados['MICS_CO'];
                $Ult_MICS_NO2 = $dados['MICS_NO2'];
                $Ult_MICS_NH3 = $dados['MICS_NH3'];
            
                    }
                    
                                            function validaEstadoIDK($idk){
                            if($idk > 80){
                                return 'Estresse devido ao calor';
                            }else if( $idk > 75 && $idk <= 80){
                                return 'Desconforto devido ao calor';
                            }else if( $idk > 60 && $idk <= 75){
                                return 'Confortável';
                            }else if( $idk > 55 && $idk <= 60){
                                return 'Desconforto devido ao frio';
                            }else{
                                return 'Estresse devido ao frio';
                            }
                        }
                        $estadosConforto = validaEstadoIDK($IDK); 
                    
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



                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                ['Sequencia', 'Pressao Atmosférica (Pa)'],



                <?php

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                ['Sequencia', 'Pressao Atmosférica (Pa)'],



                <?php

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

                $sql = mysqli_query($conexao, $sqlPrincipal);



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

      <div class="row justify-content-center align-items-center">
         
             Ultimos dados coletados:
        
         <div class="row justify-content-center align-items-center" id="UltimosDadosColetados">
            </br>
            <?php
               echo " 
               <div id='UltimosDadosColetadosInternos'>
                    <b>Índice de conforto térmico:</b> $IDK</br>
                        <b>Estado de conforto:</b> $estadosConforto</br>
               </div>
               
               <div id='UltimosDadosColetadosInternos'>
               <div class='row justify-content-center align-items-center'>
                    Sensor DHT11
               </div>
                   <b> Temperatura: </b> $Ult_TemperaturaDHT11 (ºC)</br>
                   <b> Umidade: </b>$Ult_UmidadeDHT11</br>
               </div>   
               
               <div id='UltimosDadosColetadosInternos'>
                      <div class='row justify-content-center align-items-center'>
                 Sensor BMP180
                   </div>
                    <b> Temperatura:</b> $Ult_TemperaturaBMP180 (ºC)</br>
                     <b> Pressão Atmosférica:</b> $Ult_PressaoBMP180 (Pa)</br>
                    <b> Altitude:</b> $Ult_AltitudeBMP180 (m)</br>
               </div>   
               
               <div id='UltimosDadosColetadosInternos'>
                      <div class='row justify-content-center align-items-center'>
                  Sensor MICS-6814
               </div>
                     <b> Monóxido de Carbono </b>$Ult_MICS_CO (ppm)</br>
                    <b> Dióxido de Nitrogénio </b>$Ult_MICS_NO2</br>
                    <b> Hidróxido de Amônia </b>$Ult_MICS_NH3</br>
               </div>";
                  
               ?>
         </div>
      </div>

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