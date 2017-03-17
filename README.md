# lsocket
lsocket is socket support for lua.

# build

build lua
```
cd lua
make linux
```


copy lua to samples
```
cp lua ../lsocket-1.4.1-1/samples
```

build lsocket
```
cd lsocket-1.4.1-1
make
```
copy lsocket.so to samples

```
cp lsocket.so ./samples
```

# example

- use httpclient.lua to download webpage
```
./lua httpclient.lua http://www.baidu.com
```
![image](https://github.com/ThisisGame/lsocket/blob/master/lsocket-1.4.1-1/doc/httpclient.png)


- run httpserver.lua as httpserver
```
 ./lua httpserver.lua
 ```
 
![image](https://github.com/ThisisGame/lsocket/blob/master/lsocket-1.4.1-1/doc/httpserver-server.png)
![image](https://github.com/ThisisGame/lsocket/blob/master/lsocket-1.4.1-1/doc/httpserver-client.png)
