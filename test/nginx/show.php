<?php
try
{
        $bdd = new PDO('mysql:host=localhost;dbname=estiam;charset=utf8', 'alexandre', 'password');
}
catch(Exception $e)
{
        die('Erreur : '.$e->getMessage());
}

$reponse = $bdd->query('SELECT * FROM Persons;');
$donnees = $reponse->fetch();

while ($donnees = $reponse->fetch())
{
?>
    <p>
    <strong>ID</strong> : <?php echo $donnees['ID']; ?><br />
    Name : <?php echo $donnees['LastName']; ?>
   </p>
<?php
}
$reponse->closeCursor();

?>
