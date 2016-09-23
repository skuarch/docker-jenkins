 
docker build --no-cache=true -t skuarch/jenkins:latest .
docker run --name jenkins --net=host -i -t -d -p 9090:9090 -p 5000:5000 skuarch/jenkins:latest
docker start jenkins
