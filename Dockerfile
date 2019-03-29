FROM ubuntu:18.04

################################################################################

ENV PROXY_USER user
ENV PROXY_PASSWORD password
ENV PROXY_SERVER server.com
ENV PROXY_PORT 80

ENV PROXY_FULL ${PROXY_USER}:${PROXY_PASSWORD}@${PROXY_SERVER}:${PROXY_PORT}


# [ ENVIRONMENT ] ----------------------

ENV HTTP_PROXY http://${PROXY_FULL}
ENV HTTPS_PROXY http://${PROXY_FULL}
ENV FTP_PROXY http://${PROXY_FULL}
ENV http_proxy http://${PROXY_FULL}
ENV https_proxy http://${PROXY_FULL}
ENV ftp_proxy http://${PROXY_FULL}


# [ APT ] ------------------------------

RUN echo Aquire::ftp::Proxy '"'http://${PROXY_FULL}'";' >> /etc/apt/apt.conf
RUN echo Aquire::http::Proxy '"'http://${PROXY_FULL}'";' >> /etc/apt/apt.conf
RUN echo Aquire::https::Proxy '"'http://${PROXY_FULL}'";' >> /etc/apt/apt.conf

RUN echo Aquire::ftp::Proxy '"'http://${PROXY_FULL}'";' >> /etc/apt/apt.conf.d/proxy.conf
RUN echo Aquire::http::Proxy '"'http://${PROXY_FULL}'";' >> /etc/apt/apt.conf.d/proxy.conf
RUN echo Aquire::https::Proxy '"'http://${PROXY_FULL}'";' >> /etc/apt/apt.conf.d/proxy.conf

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install wget -y
RUN apt-get install git -y


# # [ YUM ] ------------------------------
# 
# RUN echo proxy=http://${PROXY_SERVER}:${PROXY_PORT} >> /etc/yum.conf
# RUN echo proxy_username=${PROXY_USER} >> /etc/yum.conf
# RUN echo proxy_password=${PROXY_PASSWORD} >> /etc/yum.conf


# [ GIT ] ------------------------------

RUN git config --global http.proxy http://${PROXY_FULL}
RUN git config --global https.proxy http://${PROXY_FULL}


# [ PIP ] ------------------------------

RUN mkdir -p /root/.pip
RUN echo [global] >> /root/.pip/pip.conf
RUN echo "proxy = ${PROXY_FULL}" >> /root/.pip/pip.conf
RUN mkdir -p /root/.config/pip
RUN echo [global] >> /root/.config/pip/pip.conf
RUN echo "proxy = ${PROXY_FULL}" >> /root/.config/pip/pip.conf


# [ CONDA ] ----------------------------

RUN echo proxy_servers: >> /root/.condarc
RUN echo '   'http: http://${PROXY_FULL} >> /root/.condarc
RUN echo '   'https: http://${PROXY_FULL} >> /root/.condarc


# [ WGET ] -----------------------------

RUN echo use_proxy = on >> /root/.wgetrc
RUN echo proxy_user = ${PROXY_USER} >> /root/.wgetrc
RUN echo proxy_passwd = ${PROXY_PASSWORD} >> /root/.wgetrc
RUN echo http_proxy = http://${PROXY_FULL} >> /root/.wgetrc
RUN echo https_proxy = http://${PROXY_FULL} >> /root/.wgetrc
RUN echo ftp_proxy = http://${PROXY_FULL} >> /root/.wgetrc
RUN echo progress = bar:force:noscroll >> /root/.wgetrc


# [ CURL ] -----------------------------

RUN echo proxy=http://${PROXY_FULL} >> /root/.curlrc


### NORMAL DOCKERFILE COMMANDS FOLLOW BELOW ####################################
