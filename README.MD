## To start this project you should use the next command:

```shell
make start
```

### .env files to configure:
[dockerize](.env)

[tps](./src/tps/.env)

[app for purchase service](./src/app-for-purchasing-service/.env)
###### You should check that params **HOST_UID** and **HOST_GID** equals the next values
```shell
id -u && id -g
```

### At first run the app you should execute

```shell
make jwt-keys
```

### to generate keys for auth

___

## The full commands list is [here](./Makefile)

### You can use [portainer](http://localhost:9000) to manage containers and to read logs


