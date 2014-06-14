<?php

/**
 * Manages User authentication
 */
class Authentication {

    /**
     * database connection
     * @var type PDO
     */
    private $pdo;

    /**
     * @param type $pdo an open PDO database connection instance
     */
    public function __construct(PDO $pdo) {
        $this->pdo = $pdo;
    }

    /**
     * Tries to log the user in 
     * @param type $email User's email
     * @param type $password User's password
     * @return boolean true if the user logged succefully
     */
    public function login($email, $password) {
        $hash = password_hash($password, PASSWORD_BCRYPT);

        $statement = $this->pdo->prepare(
                'select ID_UTILS, ROLE_UTILS' .
                'from UTILISATEUR' .
                'where EMAIL_UTILS = :email' .
                'and MOT_DE_PASSE_UTILIS = :hash'
        );

        $statement->execute([
            'email' => $email,
            'hash' => $hash
        ]);

        $result = $role = $statement->fetch(PDO::FETCH_OBJ);
        
        // If the user is found in the database
        // save in the database
        if ($result) {
            $session = new Session();
            $session->userRole = $result->ROLE_UTILS;
            $session->userId = $result->ID_UTILS;
            $session->hash = $hash;
            
            return true;
        } else {
            return false;
        }
    }
    
    /**
     * Logout the user
     * redirect after this to /login
     */
    public function logout() {
        $session = new Session();
        $session->remove('userRole');
        $session->remove('userId');
        $session->remove('hash');
    }
    
    /**
     * @return type True if the user is authentified
     */
    public function userIsAuthentified() {
        $session = new Session();
        return isset($session->userId);
    }

    /**
     * 
     * @return type The role of the user
     */
    public function getUserRole() {
        $session = new Session();
        return $session->userRole;
    }

}
