<?php
try
{
        $bdd = new PDO('mysql:host=localhost;dbname=estiam;charset=utf8', 'alexandre', 'password');
}
catch(Exception $e)
{
        die('Erreur : '.$e->getMessage());
}

$name = "MyName";
// On ajoute une entrée dans la table Persons
$req = $bdd->prepare('INSERT INTO Persons(ID, LastName) VALUES(:ID, :LastName)');
$req->execute(array(
	'ID' => $id,
	'LastName' => $name
	));

echo 'Le jeu a bien été ajouté !';

?>
