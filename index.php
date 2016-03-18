<?php
$dbUser = 'root';
$dbPass = 'meta4meta4';
$dbHost = 'localhost';
$dbDatabase = 'appTest';
$dbTable = 'Locations';


$dbConnection = new PDO('mysql:host=' . $dbHost . ';dbname=' . $dbDatabase . ';charset=utf8mb4', $dbUser, $dbPass);


$resultArray = array();
$tempArray = array();
foreach ($dbConnection->query('SELECT * FROM ' . $dbTable) as $dbData) {

    $tempArray = $dbData;
    array_push($resultArray, $tempArray);
}
echo json_encode($resultArray);