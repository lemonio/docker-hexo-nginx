docker run -dit -p 80:80 --name "hexo-nginx" \
-v /opt/blog/source:/blog/source \
-v /opt/blog/themes:/blog/themes \
-v /opt/blog/_config.yml:/blog/_config.yml \
--restart=always \
docker-hexo-nginx
#/bin/bash
