#!/usr/bin/php
<?php 
/**
* vk.wallpost sample code
*
* @package vk.wallpost
* @author Ayrat Belyaev <xbreaker@gmail.com>
* @copyright (c) 2011 xbreaker
* @license http://creativecommons.org/licenses/by-sa/3.0/legalcode
*/
if ( !class_exists( 'vk_wallpost' ) )
		require('vk.wallpost.php' );
//vk_wallpost :: login, password, url to post to( default_to 'vk.com/yarkieludifestival'), group-id if you need to post as group, prepended with - (default to -39665521)
$vk = new vk_wallpost($argv[1], $argv[2], $argv[3], $argv[4]); 
//настройка прокси
$vk->proxyAddr="host:port";
$vk->proxyAuth="login:pass";
$vk->useProxy=false;
//отправка сообщения
// post_message :: link to post, message to post
$vk->postMessage($argv[5], $argv[6]);
echo $argv[1];
echo "\n";
echo $argv[2];
echo "\n";
echo $argv[3];
echo "\n";
echo $argv[4];
echo "\n";
echo $argv[5];
echo "\n";
echo $argv[6];
echo "\n";
?>
