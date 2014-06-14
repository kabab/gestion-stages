<?php

require 'vendor/autoload.php';

$klein = new Klein\Klein();

/**
 * run for all paths
 */
$klein->respond(function($request, $response, $service, $app) {
    
    // Configure serverices
    // Smarty template engine
    $app->register('smarty', function() {
        $smarty = new Smarty();

        $smarty->template_dir = __DIR__ . "cache/smarty/templates";
        $smarty->compile_dir  = __DIR__ . "cache/smarty/templates_c";
        $smarty->cache_dir    = __DIR__ . "cache/smarty/cache";
        $smarty->config_dir   = __DIR__ . "cache/smarty/configs";
        
        $smarty->assign('__DIR__', __DIR__);

        return $smarty;
    });
});

/**
 * /login 
 */
$klein->respond('/login', function($request, $response, $service, $app) {
    return $app->smarty->fetch(__DIR__ . '/web/tpl/login.tpl');
});

$klein->dispatch();
