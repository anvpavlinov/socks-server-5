## socks-server-5
Socks5 proxy server for Docker container.

### Clone repo
```
$ git clone https://github.com/anvpavlinov/socks-server-5
```

### Build image
```
$ cd socks-server-5
```
Edit ss5.passwd file and set username and password.
```
$ vi ss5.passwd
```
Build docker image with Dockerfile.
```
$ docker build -t localhost:5000/socks-server-5:latest .
```

### Run container
```
docker run --name ss5-proxy -p 1080:1080 --restart=always -d localhost:5000/socks-server-5:latest
```

### Add firewalld port
```
$ firewall-cmd --permanent --add-port=1080/tcp
$ firewall-cmd --reload
