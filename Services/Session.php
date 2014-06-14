<?php

/**
 * Adding & removing session values
 * 
 * Usage:
 *  $session = new Session()
 *  $session->username = 'Youssef'
 *  echo $session->username;
 * 
 * That's it!
 */
class Session {

    public function __construct() {
        if (!isset($_SESSION)) {
            session_start();
        }
    }

    public function __get($name) {
        if (!isset($_SESSION[$name])) {
            throw new SessionException("Undefined session variable '$name'");
        }
        return $_SESSION[$name];
    }

    public function __set($name, $value) {
        $_SESSION[$name] = $value;
    }

}
