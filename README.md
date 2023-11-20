# Nodejs applicaition deployment with mysql using docker-compose and k8s minikube.

## <Using docker-compose>
## application description
- Simple todo-list web application using mysql to store tasks in mysql backend.

##Pre-requisites
```sh
- Docker to containerise front-end and back-end
  - Ref: https://docs.docker.com/engine/install/

- docker-compose to run multi-container applications as a service
  - Ref: https://docs.docker.com/compose/install/
```

##Docker images:
  Here we are using NodeJs as base image to run front-end and mysql:5.6 base image for back-end and adding custom layers on top of them.
  By default, docker uses images from DockerHub. In order to fetch images from your own private repote, use 'docker login' to point docker to your own repo.
  OR, write custom dockerfile and build images.
  
##Running application
- Fork and clone the repository.
- app/ directory includes all the files required to run the application.
- build the custom noodejs image to run front-end 
    - cmd: docker build -t <tag> . 
- Use the above generated image to in docker-compose file.
- Here I'm using mysql:5.7 to run database.
- While using mysql:5.7 in compose file along with mentioning image we should also    define 'MYSQL_ROOT_PASSWORD' as an envivonment variable.
- Store credential in '.env' file and refer this in docker-compose.
   ```sh
   NOTE: Add add confidential or hidden files to '.gitingore' file (create if not exist) to avoid pushing those files.
 
- Add nodejs image in compose file and set environment variable for the application   to connect with database
    ```sh
    MYSQL_HOST=<DB_hostname>
    MYSQL_USER=<user_name>
    MYSQL_PASSWORD=<user_password>
    ```
- Refer environment variables as file unde each service section in compose file   using 'env_file' parameter.
     
- Use the below command to rub compose serivces.
  cmd: docker-compose up -d
    -d to run as daemon.

Access application at : http://<host_ip>:Port




