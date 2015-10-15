# Doing Docker..little notes that made my life easier

## Remove docker containers that you don't want anymore
```
$ pssh -vi -l core -h clusters/workers "docker rm -v \$(docker ps -a | grep "XXXXXXX" | cut -d' ' -f1)"
```
where "XXXXXX" is used to filter down what you want.  the *cut -d' ' -f1* part gets the container ID
