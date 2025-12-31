<?php
$servername = "mysql-service";
$username = "root";
$password = "Senha123";
$database = "db_mensagens";

// Criar conexão


$link = new mysqli($servername, $username, $password, $database);

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

?>
