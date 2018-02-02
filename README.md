# Alexandre MORAT Eval 1!

Tous les fichiers se trouvent dans eval.
Pour lancer le script se mettre dans le dossier eval et taper **./start.sh** ou **./start-swarm.sh** pour la version swarm du projet

Ce script permet de passer par les différentes versions de l'outil V1 à V3 une à une.

##  Pour chaque version les étapes suivantes sont réalisés : 
- Suppressions des précédents containers
- Suppressions des anciens volumes
- Choix de la version 1, 2 ou 3
- Compilation
- Exécution du docker-compose

**A la fin du script les containers et volumes sont supprimés.**


## Version 1
### Nginx :
Le container Nginx utilise Nginx 1.13.7 et PHP 7.1.12.
Les ports exposés sont le 80 et 443
Le site internet écoute sur www.samplephpwebsite.com
Pour les besoins le docker-compose lui utilise le port 8080 au lieu du port 80.
Les volumes exposés sont /var/www/html pour le contenu du site et /var/log/nginx/ pour accéder aux logs

### Contenu Web :
Le site web utilisé est samplephpwebsite version 1

## Version 2
### Nginx :
Le container Nginx utilise Nginx 1.12.0 et PHP 7.1.3
Les ports exposés sont le 80 et 443
Le site internet écoute sur www.samplephpwebsite.com
Pour les besoins le docker-compose lui utilise le port 8080 au lieu du port 80.
Les volumes exposés sont /var/www/html pour le contenu du site et /var/log/nginx/ pour accéder aux logs

### Contenu Web :
Le site web utilisé est samplephpwebsite version 2

## Version 3
### Nginx :
Le container Nginx utilise Nginx 1.12.0 et PHP 7.1.3
Les ports exposés sont le 80 et 443
Le site internet écoute sur www.samplephpwebsite.com
Pour les besoins le docker-compose lui utilise le port 8080 au lieu du port 80.
Les volumes exposés sont /var/www/html pour le contenu du site et /var/log/nginx/ pour accéder aux logs

### Contenu Web :
Le site web utilisé est samplephpwebsite version 3

### Mariadb :
La version de mariadb utilisé est mariadb 10.1
