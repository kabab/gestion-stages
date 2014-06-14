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

require_once 'database.php';


class Post extends Database{

  public $table = 'POST';
  protected $dbh = null;

  function __construct($par){
    $this->dbh = $par
  }
  public function editPost($data, $condition = null){
    $query = "UPDATE ".$this->table." SET ";
    foreach ($data as $key => $value) {
      $query .= "$key = '$value' ,";
    }
    $query = substr($query, 0,strlen($query)-1);
    if($condition != null ){
      $query .= 'where ';
      foreach ($condition as $key => $value) {
        $query .= "$key = '$value' and ";
      } 
      $query = substr($query, 0,strlen($query)-4);
    }
    $sth = $this->dbh->prepare($query);
    $sth->execute();
  }  

  public function addPost($data){
    $query = "INSERT INTO ".$this->table."(";
    $struct = "";
    $values = " VALUES(";
    foreach ($data as $key => $value) {
      $struct .= "$key,";
      $values .= ":$key,"; 
    }
    $struct = substr($struct, 0, strlen($struct)-1).")";
    $values = substr($values, 0, strlen($values)-1).")";
    $query .= $struct.$values;
    $sth = $this->dbh->prepare($query);
    $sth->execute($data);
  }

  // 

  function delete($condition=array('1' => '1')){
    $query = "delete from ".$this->table." WHERE";
    $values = array();
    foreach ($condition as $key => $value) {
      $query .= " $key = ? AND ";
      $values[] = $value;
    }
    $query = substr($query, 0, strlen($query)-4);
    if($this->id != null){
      $query .= ' AND '.$this->primaryKey.' = ? ';
      $values[] = $this->id;

    }
    $stmt = $this->dbh->prepare($query);
    return $stmt->execute($values);
  }


  public function getPosts($condition=array('1'=>'1')) {
    $query = 'SELECT ';
    // @var array will contain execute parametres 
    $exec_param = array();
    // add fields name to the query
    // array will contain field0 , filed1 ... field$n
    $fields_names = array();
    // iniale fields counter 
    $query .= " * FROM ".$this->table." WHERE ";
    // add conditions
    foreach ($condition as $key => $value) {
      $query .= $key.' = ? AND ';
      $exec_param[] = $value;
    }
    $query = substr($query, 0,strlen($query)-4);
    $sth = $this->dbh->prepare($query);
    $sth->execute($exec_param);
    $result = $sth->fetchAll();
    return $result;
  }

}
