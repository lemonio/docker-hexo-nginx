FROM centos:7.5.1804

MAINTAINER Lemon

ENV NODEJS_VERSION "8.11.3"
ENV TZ "Asia/Shanghai"

RUN \
cp -f /usr/share/zoneinfo/${TZ} /etc/localtime && \
echo ${TZ} > /etc/timezone

# Install Dependency
RUN \
yum makecache fast && \
yum update -y && \
yum install -y git rsync wget

# Install Nginx
RUN \
wget http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm && \
rpm -ivh nginx-release-centos-7-0.el7.ngx.noarch.rpm && \
rm -f nginx-release-centos-7-0.el7.ngx.noarch.rpm && \
yum install -y nginx

# Install Node.js
RUN \
wget https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.xz -O node.txz && \
mkdir -p /usr/local/node/ && \
tar -Jxf node.txz --strip-components=1 -C /usr/local/node/ && \
ln -s /usr/local/node/bin/* /usr/local/bin/ && \
rm -f node.txz

WORKDIR /blog

# Install Hexo
RUN \
npm install -g --no-optional hexo-cli && \
ln -s /usr/local/node/bin/hexo /usr/local/bin/hexo && \
hexo init /blog && \
rm -rf /blog/themes/* /blog/source/* && \
npm install --no-optional --save-dev webpack && \
npm install --no-optional --save hexo-generator-sitemap && \
npm install --no-optional --save hexo-generator-baidu-sitemap && \
npm install --no-optional --save hexo-generator-feed && \
npm install --no-optional --save hexo-generator-search && \
npm install --no-optional --save hexo-generator-searchdb && \
npm install --no-optional --save hexo-generator-index && \
npm install --no-optional --save hexo-generator-archive && \
npm install --no-optional --save hexo-generator-tag && \
npm install --no-optional --save hexo-generator-category && \
npm install --no-optional --save hexo-tag-dplayer && \
npm install --no-optional --save hexo-tag-aplayer && \
npm install --no-optional --save hexo-deployer-rsync && \
npm install --no-optional --save hexo-deployer-git && \
npm install --no-optional --save hexo-symbols-count-time && \
npm install --no-optional --save hexo-renderer-less && \
npm install --no-optional --save hexo-generator-feed && \
npm install --no-optional --save hexo-generator-json-content && \
npm install --no-optional --save hexo-helper-qrcode && \
npm install --no-optional --save hexo-helper-live2d && \
npm install --no-optional --save live2d-widget-model-nipsilon

RUN yum clean all

# Custom Nginx config
COPY conf/nginx/nginx.conf /etc/nginx/nginx.conf
COPY conf/nginx/default.conf /etc/nginx/conf.d/default.conf

# Expose 80 and 443
EXPOSE 80 443

VOLUME ["/blog/source", "/blog/themes", "/root/.ssh"]

RUN \
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/root/bin

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
