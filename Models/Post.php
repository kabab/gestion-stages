<?php

/**
  Usage

  // forum.php

  $klein->respond('forum/posts/', function($request, $response, $service, $app) {
    $auth = new Authentication();

    if(!($auth->isAuthentified() [ || $auth->getUserRole() == 'SOMETHING' ]))
      $response->redirect('url');
    $postModel = new Post($app->pdo);

    $postModel->getPost();

    $app->smarty->assign([...]);
    return $app->smarty->fetch(__DIR__ . '/web/tpl/posts.tpl');
  });

  */


require_once 'Model.php';

class Post{

  function __construct($par){
    $this->table = 'POST';
    $this->dbh = $par;
  }
  
}