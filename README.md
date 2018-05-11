# Resourcespace-docker

Inofficial docker container for resourcespace (https://www.resourcespace.com/) used to test the product.

Despite other containers this one using ubuntu 18.04 as base image and php 7.2.

# Run 
Use the docker-compose in this repo to run a full setup with mysql 5.6.

```
docker-compose up -d
```

The ENV *BASEURL* is used to set the servers FQDN during the installation.
It looks like there is a bug in the setup.php which sets this setting during the installation.