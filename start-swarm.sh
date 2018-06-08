echo ""
echo "###############################"
echo " MORAT ALEXANDRE DOCKER EVAL 1 "
echo "###############################"
echo ""
read -p "Press any key to continue... " -n1 -s
echo ""
echo "###########"
echo " version 1 "
echo "###########"
echo ""
read -p "Press any key to continue... " -n1 -s

docker service rm up_nginx

cd eval
git checkout v1
cd nginx-php-fpm
docker build -t nginx-php-fpm:1.0 .
cd ../
docker stack deploy --compose-file docker-compose.yml up

read -p "Press any key to continue... " -n1 -s
echo ""
echo "###########"
echo " version 2 "
echo "###########"
echo ""
read -p "Press any key to continue... " -n1 -s

docker service rm up_nginx

cd eval
git checkout v2
cd nginx-php-fpm
docker build -t nginx-php-fpm:2.0 .
cd ../
docker stack deploy --compose-file docker-compose.yml up

read -p "Press any key to continue... " -n1 -s
echo ""
echo "###########"
echo " version 3 "
echo "###########"
echo ""
read -p "Press any key to continue... " -n1 -s
docker service rm up_nginx

cd eval
git checkout v3
cd nginx-php-fpm
docker build -t nginx-php-fpm:3.0 .
cd ../mariadb
docker build -t mariadb:10.1 .
cd ../
docker stack deploy --compose-file docker-compose.yml up

read -p "Press any key to continue... " -n1 -s
echo ""
echo "###################################"
echo " suppression containers et volumes "
echo "###################################"
echo ""
read -p "Press any key to continue... " -n1 -s

docker service rm up_nginx up_mariadb
