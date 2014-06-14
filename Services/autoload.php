<?php

/**
 * Configuring a simple autoloader
 */
spl_autoload_register(function($classname) {
    $path = __DIR__ . "/$classname.php";
    if(file_exists($path)) {
        require_once $path;
    }
});