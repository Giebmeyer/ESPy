<?php
    session_start();
    unset($_SESSION['email']);
    session_destroy();
    header("Location: ../../ESPy_Web/index.html")
?>