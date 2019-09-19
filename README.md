## Docker-Hexo-Nginx

### 使用方法

1. 构建镜像(耐心等待)：

```bash
sh tools/build_images.sh
```

2. 运行容器：

```bash
sh tools/run_container.sh
```

3. 设置hexo命令：

```bash
echo 'alias hexo="docker exec -it hexo-nginx /usr/local/bin/hexo"' >> /etc/profile
source /etc/profile
```

4. 创建新文章：

```bash
hexo new NAME
```

5. 生成public文件夹：

```bash
hexo g
```

6. 部署：

```bash
hexo d
```

7. 重启容器：

```bash
docker restart hexo-nginx
```

8. 启动容器：

```bash
docker start hexo-nginx
```


***

