<?php
    $sair = false;
    $sair = $_GET['sair'];

    if($sair == true){
        session_start();
        setcookie(session_name(), '', 100);
        session_unset();
        session_destroy();
        $_SESSION = array();
        header("Location: /index.php");
    }


?>