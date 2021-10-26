# mall

## 前言

[mall](https://github.com/macrozheng/mall) 项目致力于打造一个完整的电商系统，包括前台商城系统及后台管理系统，基于SpringBoot+MyBatis实现。前台商城系统包含首页门户、商品推荐、商品搜索、商品展示、购物车、订单流程、会员中心、客户服务、帮助中心等模块。后台管理系统包含商品管理、订单管理、会员管理、促销管理、运营管理、内容管理、统计报表、财务管理、权限管理、设置等模块。本项目是将 mall 项目 serverless 化，让开发者能够在1小时内构建弹性、高可用、低成本的微服务。

## 架构

Mall 包括 mall-admin，mall-portal，mall-search 3个服务。

## Serverless 化

借助阿里云函数计算的 [custom container](https://help.aliyun.com/document_detail/179368.html) 功能，开发者能够快速的将 mall 项目以容器镜像的方式运行在函数计算上。函数计算默认提供了流量治理，灰度发布，自动伸缩，高可用等功能，开发者只需要专注于应用本身逻辑开发，而无需关注底层平台的管理，开发和运维效率大幅提升。

### 0. 前置条件
1. 安装好 docker。
2. 安装 Serverless Devs 开发工具。

### 1. 依赖服务部署
Mall 项目依赖了 MySQL，Redis，RabbitMQ，ElasticSearch 等项目，这些软件在公有云上都有对应的云产品。对于生产环境的应用，建议使用云产品获得更好的性能和稳定性。

对于个人开发者尝鲜或者快速实现原型而言，找一台虚拟机部署上述组件是更简单、成本更低的方式。我们提供了对应的组件的 Dockerfile，只需要两条命令就能完成依赖组件的容器镜像的编译和单机部署。

### 2. Mall 应用服务部署

修改 `mall-admin/src/main/resources/`，`mall-portal/src/main/resources/`，`mall-search/src/main/resources/` 目录下的 `application-prod.yml` 文件，将 `host` 的值设置为第一步部署依赖组件所在机器的 ip。 

执行下述命令生成 mall 应用的容器镜像。在 Linux 上，docker 需要 root 权限，因此需要以 `sudo` 的方式执行命令。
```shell
sudo -E mvn package
```

执行 `sudo docker images`，显示已经生成了 `mall/mall-admin`，`mall/mall-portal`，`mall/mall-search` 的容器镜像。

将上述镜像 push 到阿里云的容器镜像仓库中。


### 应用日志收集



#### 后台管理系统

前端项目`mall-admin-web`地址：https://github.com/macrozheng/mall-admin-web

项目演示地址： [http://www.macrozheng.com/admin/index.html](http://www.macrozheng.com/admin/index.html)  

![后台管理系统功能演示](http://img.macrozheng.com/mall/project/mall_admin_show.png)

#### 前台商城系统

前端项目`mall-app-web`地址：敬请期待......

项目演示地址：[http://www.macrozheng.com/app/mainpage.html](http://www.macrozheng.com/app/mainpage.html)

![前台商城系统功能演示](http://img.macrozheng.com/mall/project/mall_app_show.png)

### 组织结构

``` lua
mall
├── mall-common -- 工具类及通用代码
├── mall-mbg -- MyBatisGenerator生成的数据库操作代码
├── mall-security -- SpringSecurity封装公用模块
├── mall-admin -- 后台商城管理系统接口
├── mall-search -- 基于Elasticsearch的商品搜索系统
├── mall-portal -- 前台商城系统接口
└── mall-demo -- 框架搭建时的测试代码
```

### 技术选型

#### 后端技术

| 技术                 | 说明                | 官网                                           |
| -------------------- | ------------------- | ---------------------------------------------- |
| SpringBoot           | 容器+MVC框架        | https://spring.io/projects/spring-boot         |
| SpringSecurity       | 认证和授权框架      | https://spring.io/projects/spring-security     |
| MyBatis              | ORM框架             | http://www.mybatis.org/mybatis-3/zh/index.html |
| MyBatisGenerator     | 数据层代码生成      | http://www.mybatis.org/generator/index.html    |
| Elasticsearch        | 搜索引擎            | https://github.com/elastic/elasticsearch       |
| RabbitMQ             | 消息队列            | https://www.rabbitmq.com/                      |
| Redis                | 分布式缓存          | https://redis.io/                              |
| MongoDB              | NoSql数据库         | https://www.mongodb.com                        |
| LogStash             | 日志收集工具        | https://github.com/elastic/logstash            |
| Kibina               | 日志可视化查看工具  | https://github.com/elastic/kibana              |
| Nginx                | 静态资源服务器      | https://www.nginx.com/                         |
| Docker               | 应用容器引擎        | https://www.docker.com                         |
| Jenkins              | 自动化部署工具      | https://github.com/jenkinsci/jenkins           |
| Druid                | 数据库连接池        | https://github.com/alibaba/druid               |
| OSS                  | 对象存储            | https://github.com/aliyun/aliyun-oss-java-sdk  |
| MinIO                | 对象存储            | https://github.com/minio/minio                 |
| JWT                  | JWT登录支持         | https://github.com/jwtk/jjwt                   |
| Lombok               | 简化对象封装工具    | https://github.com/rzwitserloot/lombok         |
| Hutool               | Java工具类库        | https://github.com/looly/hutool                |
| PageHelper           | MyBatis物理分页插件 | http://git.oschina.net/free/Mybatis_PageHelper |
| Swagger-UI           | 文档生成工具        | https://github.com/swagger-api/swagger-ui      |
| Hibernator-Validator | 验证框架            | http://hibernate.org/validator                 |

#### 前端技术

| 技术       | 说明                  | 官网                                   |
| ---------- | --------------------- | -------------------------------------- |
| Vue        | 前端框架              | https://vuejs.org/                     |
| Vue-router | 路由框架              | https://router.vuejs.org/              |
| Vuex       | 全局状态管理框架      | https://vuex.vuejs.org/                |
| Element    | 前端UI框架            | https://element.eleme.io               |
| Axios      | 前端HTTP框架          | https://github.com/axios/axios         |
| v-charts   | 基于Echarts的图表框架 | https://v-charts.js.org/               |
| Js-cookie  | cookie管理工具        | https://github.com/js-cookie/js-cookie |
| nprogress  | 进度条控件            | https://github.com/rstacruz/nprogress  |

#### 架构图

##### 系统架构图

![系统架构图](http://img.macrozheng.com/mall/project/mall_micro_service_arch.jpg)

##### 业务架构图

![系统架构图](http://img.macrozheng.com/mall/project/mall_business_arch.png)

#### 模块介绍

##### 后台管理系统 `mall-admin`

- 商品管理：[功能结构图-商品.jpg](document/resource/mind_product.jpg)
- 订单管理：[功能结构图-订单.jpg](document/resource/mind_order.jpg)
- 促销管理：[功能结构图-促销.jpg](document/resource/mind_sale.jpg)
- 内容管理：[功能结构图-内容.jpg](document/resource/mind_content.jpg)
- 用户管理：[功能结构图-用户.jpg](document/resource/mind_member.jpg)

##### 前台商城系统 `mall-portal`

[功能结构图-前台.jpg](document/resource/mind_portal.jpg)

#### 开发进度

![项目开发进度图](http://img.macrozheng.com/mall/project/mall_dev_flow.png)

## 环境搭建

### 开发工具

| 工具          | 说明                | 官网                                                  |
| ------------- | ------------------- | ----------------------------------------------------- |
| IDEA          | 开发IDE             | https://www.jetbrains.com/idea/download               |
| RedisDesktop  | redis客户端连接工具 | https://github.com/qishibo/AnotherRedisDesktopManager |
| Robomongo     | mongo客户端连接工具 | https://robomongo.org/download                        |
| SwitchHosts   | 本地host管理        | https://oldj.github.io/SwitchHosts/                   |
| X-shell       | Linux远程连接工具   | http://www.netsarang.com/download/software.html       |
| Navicat       | 数据库连接工具      | http://www.formysql.com/xiazai.html                   |
| PowerDesigner | 数据库设计工具      | http://powerdesigner.de/                              |
| Axure         | 原型设计工具        | https://www.axure.com/                                |
| MindMaster    | 思维导图设计工具    | http://www.edrawsoft.cn/mindmaster                    |
| ScreenToGif   | gif录制工具         | https://www.screentogif.com/                          |
| ProcessOn     | 流程图绘制工具      | https://www.processon.com/                            |
| PicPick       | 图片处理工具        | https://picpick.app/zh/                               |
| Snipaste      | 屏幕截图工具        | https://www.snipaste.com/                             |
| Postman       | API接口调试工具     | https://www.postman.com/                              |
| Typora        | Markdown编辑器      | https://typora.io/                                    |

### 开发环境

| 工具          | 版本号 | 下载                                                                                 |
| ------------- | ------ | ------------------------------------------------------------------------------------ |
| JDK           | 1.8    | https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html |
| Mysql         | 5.7    | https://www.mysql.com/                                                               |
| Redis         | 5.0    | https://redis.io/download                                                            |
| MongoDB       | 4.2.5  | https://www.mongodb.com/download-center                                              |
| RabbitMQ      | 3.7.14 | http://www.rabbitmq.com/download.html                                                |
| Nginx         | 1.10   | http://nginx.org/en/download.html                                                    |
| Elasticsearch | 7.6.2  | https://www.elastic.co/downloads/elasticsearch                                       |
| Logstash      | 7.6.2  | https://www.elastic.co/cn/downloads/logstash                                         |
| Kibana        | 7.6.2  | https://www.elastic.co/cn/downloads/kibana                                           |

### 搭建步骤

> Windows环境部署

- Windows环境搭建请参考：[mall在Windows环境下的部署](http://www.macrozheng.com/#/deploy/mall_deploy_windows);
- 注意：只启动mall-admin,仅需安装Mysql、Redis即可;
- 克隆`mall-admin-web`项目，并导入到IDEA中完成编译：[前端项目地址](https://github.com/macrozheng/mall-admin-web);
- `mall-admin-web`项目的安装及部署请参考：[mall前端项目的安装与部署](http://www.macrozheng.com/#/deploy/mall_deploy_web)。

> Docker环境部署

- 使用虚拟机安装CentOS7.6请参考：[虚拟机安装及使用Linux，看这一篇就够了](http://www.macrozheng.com/#/reference/linux_install);
- Docker环境的安装请参考：[开发者必备Docker命令](http://www.macrozheng.com/#/reference/docker);
- 本项目Docker镜像构建请参考：[使用Maven插件为SpringBoot应用构建Docker镜像](http://www.macrozheng.com/#/reference/docker_maven);
- 本项目在Docker容器下的部署请参考：[mall在Linux环境下的部署（基于Docker容器）](http://www.macrozheng.com/#/deploy/mall_deploy_docker);
- 本项目使用Docker Compose请参考： [mall在Linux环境下的部署（基于Docker Compose）](http://www.macrozheng.com/#/deploy/mall_deploy_docker_compose);
- 本项目在Linux下的自动化部署请参考：[mall在Linux环境下的自动化部署（基于Jenkins）](http://www.macrozheng.com/#/deploy/mall_deploy_jenkins);

> 相关环境部署

- ELK日志收集系统的搭建请参考：[SpringBoot应用整合ELK实现日志收集](http://www.macrozheng.com/#/technology/mall_tiny_elk);
- 使用MinIO存储文件请参考：[前后端分离项目，如何优雅实现文件存储](http://www.macrozheng.com/#/technology/minio_use);
- 读写分离解决方案请参考：[你还在代码里做读写分离么，试试这个中间件吧](http://www.macrozheng.com/#/reference/gaea);
- Redis集群解决方案请参考：[Docker环境下秒建Redis集群，连SpringBoot也整上了！](http://www.macrozheng.com/#/reference/redis_cluster)。

## 公众号

学习不走弯路，关注公众号「**macrozheng**」，回复「**学习路线**」，获取mall项目专属学习路线！

加微信群交流，公众号后台回复「**加群**」即可。

![公众号图片](http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/banner/qrcode_for_macrozheng_258.jpg)

## 许可证

[Apache License 2.0](https://github.com/macrozheng/mall/blob/master/LICENSE)

Copyright (c) 2018-2021 macrozheng
