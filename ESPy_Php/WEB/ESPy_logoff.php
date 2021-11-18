<?php
    $sair = false;
    $sair = $_GET['sair'];

    if($sair == true){
        session_start();
        unset($_SESSION['email']);
        session_destroy();
        header("Location: ../../index.php");
    }


?>