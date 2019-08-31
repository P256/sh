<?php
//默认连接
$conn=mysql_connect('103.21.143.121','web','web101');
var_dump($conn);

$mysqli = new mysqli('127.0.0.1','web','web101','test');
var_dump($mysqli);

//PDO连接
$pdo=new PDO('mysql:host=127.0.0.1;port=3306; dbname=test','web','web101',array(PDO::ATTR_PERSISTENT=>true));
var_dump($pdo);

?>
    
