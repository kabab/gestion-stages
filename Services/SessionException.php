<?php

/**
 * class for throwing session related exceptions
 */
class SessionException extends Exception {

    public function __construct($message, $code, $previous) {
        parent::__construct($message, $code, $previous);
    }

}