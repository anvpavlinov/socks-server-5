FROM centos:7.7.1908
MAINTAINER apavlinov <anvpavlinov@gmail.com>
ENV SS5_VERSION 3.8.9-8

RUN yum -y install yum-utils wget gcc gcc-c++ automake make pam-devel openssl-devel openldap-devel cyrus-sasl-devel \
    && wget -O ss5.tar.gz "http://downloads.sourceforge.net/project/ss5/ss5/$SS5_VERSION/ss5-$SS5_VERSION.tar.gz" \
    && mkdir -p /usr/src/ss5 \
    && tar -xzf ss5.tar.gz -C /usr/src/ss5 --strip-components=1 \
    && rm ss5.tar.gz \
    && cd /usr/src/ss5 \
    && ./configure \
    && make \
    && make install \
    && cd / \
    && rm -rf /usr/src/ss5 \
    && yum -y remove wget gcc gcc-c++ automake make pam-devel openssl-devel openldap-devel cyrus-sasl-devel \
    && yum -y remove `package-cleanup --leaves` \
    && yum -y remove yum-utils \
    && yum clean all \
    && sed -i "/#auth/a\auth 0.0.0.0\/0 - u" /etc/opt/ss5/ss5.conf \
    && sed -i "/#permit/a\permit u 0.0.0.0\/0 - 0.0.0.0\/0 - - - - -" /etc/opt/ss5/ss5.conf \
    && rm -rf /etc/opt/ss5/ss5.passwd \
    && touch /var/log/ss5/ss5.log

COPY ./ss5.passwd /etc/opt/ss5/ss5.passwd

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 1080

CMD ["tail", "-100f", "/var/log/ss5/ss5.log"]
