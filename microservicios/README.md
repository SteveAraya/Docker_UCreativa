# Microservicios
    Aplicación de suma y multiplicación para explicar microservicios, esta se compone de un cliente y un server.

## Se crea la net, en ocaciones si no se crea antes da error.
    docker network create mongo-network

## Configuración para mongo.
    docker run -e MONGO_INITDB_ROOT_USERNAME=<USER> \
               -e MONGO_INITDB_ROOT_PASSWORD=<PASSWORD> \
               --net mongo-network \
               --name mongo \
               -p 27017:27017 mongo

## Configuración para java.
    docker run --rm -d -p 8080:8080 \
               --name java \
               --net mongo-network \
               -e MONGO_SERVER=mongo java-service

## Configuración para python.
    docker run --rm -d \
               --net mongo-network \
               -e MONGO_SERVER=mongo \
               -p 8081:2000 \
               --name python python-service

## Configuracion mongo java.
    spring.data.mongodb.database=<DATABASE>
    spring.data.mongodb.host=<HOST>
    spring.data.mongodb.port=<PORT>
    spring.data.mongodb.username=<USER>
    spring.data.mongodb.password=<PASSWORD>