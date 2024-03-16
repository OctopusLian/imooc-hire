# 慕聘网  

包含用户端、企业端、管理端三大平台，可以实现用户求职、HR招聘、企业管理、平台运营等综合业务功能。  

## 服务配置项  

用户微服务端口号：7001  
企业微服务端口号：6001  

## 安装  

### Nacos  

```shell
docker pull nacos/nacos-server:v2.1.1

docker run  --name nacos \
-e MODE=standalone \
-p 8848:8848 \
-d nacos/nacos-server:v2.1.1
```
