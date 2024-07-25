# Simple Messenger - Backend NestJS Micro Service

Micro-service backend to messager App. 

 

### 🔑 what does this application do?
This application was developed for study purposes and has the following features:

* Uses tests in all layers [data / domain / presentation]
* Uses CLEAN architecture
* Tests with mocks
* Fetches data from a free API
* Uses block with block test
* Has a bounce in the call of one of the Bloc events (with the help of RxDart)
---
<br /><br /><br />

### ✔️ Topicos abordados  
 - TDD 
 - Mocks com Mockit 
 - teste de UI com bloc_test
---
<br /><br /><br />

 
 
 


## 🪄 NestJS cli / Libs do projeto
Alguns comandos usados na etapa de configuracao do firebase via CLI 
- [Documentacao](https://firebase.flutter.dev/docs/cli)
- [parte flutter](https://firebase.google.com/docs/flutter/setup?platform=android)
```console

  // criando novos apps (como o nestJS chama cada micro-servico)
  nest generate app [NOME_APP]

  // para criar Libs/Libray
  nest g library [NOME_LIB]

```

Libs adicionadas ao projeto 
```console
  npm i @nestjs/config @nestjs/microservices
  npm i --save amqplib amqp-connection-manager
  npm i --save @nestjs/typeorm typeorm pg
  npm i --save passport passport-jwt @nestjs/passport @nestjs/jwt bcrypt
  npm i --save -D @types/passport-jwt @types/bcrypt
  npm install @nestjs/cache-manager cache-manager --save
  npm i cache-manager redis cache-manager-redis-yet --save
  npm i -D @types/cache-manager --save


  npm i -D @types/cache-manager-redis-yet --save


  npm i cache-manager@5.2.1  cache-manager-redis-store@2.0.0 @nestjs/cache-manager@1.0.0 @types/cache-manager-redis-store@2.0.1

  npm i @nestjs/websockets socket.io @nestjs/platform-socket.io --save

  npm install --save   firebase-admin

```
---
<br /><br /><br />



### 🔥 Rabbit MQ
Some commands used in the Rabbit MQ configuration stage
```console

  // na pasta do projeto, inicie os containers:
  docker-compose up

  // em seguida acesse no navegador
  localhost:15672


```
 
---
<br /><br /><br />


## 🗺️ Access to Dockers
After the dockers are up (docker-compose up), you can access the instances through the ports indicated in the
in docker-compose.yaml and user/password in the .env file
- [Pg Admin user@teste.com/password ](http://localhost:15432/)
- [RabbitMQ user/password ](http://localhost:15672/)
```console

  // na pasta do projeto, inicie os containers:
  docker-compose up

  // em seguida acesse no navegador
  localhost:15672


```

 
---
<br /><br /><br />
 

 

#
<footer>
  <p style="float:right; width: 30%;"> Copyright © Moacir Jacomin 
</p>
