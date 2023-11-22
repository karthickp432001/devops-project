# Nodejs applicaition deployment with mysql using docker-compose and k8s minikube.
  ## Application description
- Simple todo-list web application using mysql to store tasks in mysql backend.
- front technology is based on javascript, css, html using nodejs as runtime.

- 
## Deployment Using docker-compose
## Pre-requisites
```sh
- Docker to containerise front-end and back-end
  - Ref: https://docs.docker.com/engine/install/

- docker-compose to run multi-container applications as a service
  - Ref: https://docs.docker.com/compose/install/
```

## Docker images:
  Here we are using NodeJs as base image to run front-end and mysql:5.6 base image for back-end and adding custom layers on top of them.
  By default, docker uses images from DockerHub. In order to fetch images from your own private repote, use 'docker login' to point docker to your own repo.
  OR, write custom dockerfile and build images.
  
# Running application
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
 
- Below are the environment variables to be used to deploy mysql and connect front-end with backend.

    ```sh
    env. variables to be passed in mysql image.
     MY_SQL_ROOT_PASSWORD=<enter_your_password>
     MYSQL_DATABASE=<database_name>
    
    env. variables to be passed in nodejs/front-end.
     use above declared mysql env details while passing values for below variables inorder to connect nodejs to mysql.
     MYSQL_HOST=<DB_hostname>
     MYSQL_USER=<user_name>
     MYSQL_PASSWORD=<user_password>
     MYSQL_DB=<database_name>
    ```
- Refer environment variables as file unde each service section in compose file   using 'env_file' parameter.
     
- Use the below command to rub compose serivces.
  cmd: docker-compose up -d
    -d to run as daemon.

Access application at : http://<host_ip>:Port

## Deployment using Kubernetes minikube
## Pre-requisites
```sh
- Docker to containerise front-end and back-end
  - Ref: https://docs.docker.com/engine/install/

- minikube installation.
  - Ref: https://minikube.sigs.k8s.io/docs/start/
```
# running minikube cluster:
 After installing minikube, run minikube cluster with docker driver using below command,
   cmd: minikube start --driver=docker 
 To check the status of cluster:
   cmd: minikube status
   
## Docker images:
  1. Nodejs as base for front-end (build image from the dockerfile as mentioned in above docker-compose section)
  2. mysql:5.7 as backend.
 ```sh
 NOTE: minikube refers its own repo to fetch images. In order to use our local images managerd by docker to be used by minikube, use any one of the below mentioned methood.  
  1. set env in order allow minikube to use local docker daemon images.
     cmd:  $ eval $(minikube docker-env)
  2. Load local images to minikube repo
     cmd: minikube load image <image-name>
```
## Running application
- Fork and clone the repository.
- kubernetes-projec/ directory includes all manifest files required to run the       application.

## Connectiong front-end and backend.
- In order to run stateful application we need database to pesist the data.
- However, in this project I'm using "StatefulSet" kubernetes object to achieve this.
- Considering k8s pod's ephemeral lifecycle, it is critical to maintain sticy identity on our backend database so that front-end can always point to that irrespective of lifecycle.

```sh
NOTE: Use correct environment variables to get acccess into the database.
        MYSQL_HOST=<DB_hostname>
        MYSQL_USER=<user_name>
        MYSQL_PASSWORD=<user_password> 
        
    Use "ConfigMap" and "Secrets" objects to store database configuration and database root password respectively.
```

  
## Autoscaling
- In this project we are using "HorizontalPodAutoscaler" object to perform autoscaling on front-end deployment by using "targetCPUUtilizationPercentage" parameter to tune scaling 
- Metric server is responsible for tracking defined metric to achieve autoscaling.
- Enable metric server on minikube using below command
   cmd: minikube addons enable metrics-server

## Expose application to public
- As we know minikube itself runs as a container in the cluster. using "minikube ip" we can only access within the cluster, in oder to expose to the public we need to perform port-forwarding.
  To check minikube's cluster ip; 
     cmd: minikube ip
- Use the below command to perform port-forwarding.
  cmd: kubectl port-forward --address 0.0.0.0 service/<service_name> <port-to-expose>:<serivce-port>
  



















