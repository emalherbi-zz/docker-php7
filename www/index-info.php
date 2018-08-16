<?php

/*
 * Eduardo Malherbi Martins (http://emalherbi.com/)
 * Copyright @emalherbi
 */

$info = array('Database' => 'master', 'UID' => 'USER', 'PWD' => 'PASSWORD');
$link = sqlsrv_connect('.', $info) or die('Error: '.json_encode(sqlsrv_errors()));
echo nl2br("Connection successfully completed! (mssql)\n");
sqlsrv_close($link);

$link = mysqli_connect('.', 'root', 'root') or die('Error: '.json_encode(mysqli_error()));
echo nl2br("Connection successfully completed! (mysql)\n");
mysqli_close($link);

echo nl2br("\n");
phpinfo();
