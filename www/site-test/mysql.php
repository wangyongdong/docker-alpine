<?php
// 测试mysql链接是否成功
header("Content-Type:text/html;charset=utf-8");

$servername = isset($_GET['ip']) ? $_GET['ip'] : "mysql";
$username = isset($_GET['username']) ? $_GET['username'] : "root";
$password = isset($_GET['password']) ? $_GET['password'] : "123456";
$port = isset($_GET['port']) ? $_GET['port'] : 3306;

try {
    $conn = new PDO("mysql:host=$servername;port=$port;", $username, $password);
    print_r($conn);
    // 现在运行完成，在此关闭连接
//    $conn = null;
}
catch(PDOException $e)
{
    echo '连接失败：'.iconv('gbk', 'utf-8', $e->getMessage()) . PHP_EOL;
}
