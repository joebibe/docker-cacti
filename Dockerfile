FROM million12/nginx-php:php70
MAINTAINER Przemyslaw Ozgo <linux@ozgo.info>

ENV \
    DB_NAME=cacti \
    DB_USER=cactiuser \
    DB_PASS=cactipassword \
    DB_HOST=localhost \
    DB_PORT=3306 \
    RDB_NAME=cacti \
    RDB_USER=cactiuser \
    RDB_PASS=cactipassword \
    RDB_HOST=localhost \
    RDB_PORT=3306 \
    BACKUP_RETENTION=7 \
    BACKUP_TIME=0 \
    SNMP_COMMUNITY=public \
    REMOTE_POLLER=0 \
    INITIALIZE_DB=0 \
    INITIALIZE_INFLUX=0 \
    TZ=UTC \
    PHP_MEMORY_LIMIT=800M \
    PHP_MAX_EXECUTION_TIME=60

RUN \
    rpm --rebuilddb && yum clean all && \
    yum install -y rrdtool net-snmp net-snmp-devel net-snmp-utils mariadb-devel cronie && \
    git clone https://github.com/Cacti/cacti.git /cacti/ && \
    cd /cacti && git checkout ${CACTI_COMMIT_HASH} && \
    curl -o /tmp/cacti-spine.tgz http://www.cacti.net/downloads/spine/cacti-spine-${SPINE_VERSION}.tar.gz && \
    mkdir -p /tmp/spine && \
    tar zxvf /tmp/cacti-spine.tgz -C /tmp/spine --strip-components=1 && \
    rm -f /tmp/cacti-spine.tgz && \
    cd /tmp/spine/ && ./configure && make && make install && \
    rm -rf /tmp/spine && \
     yum remove -y gcc mariadb-devel net-snmp-devel && \
    yum clean all

COPY container-files /

EXPOSE 80 81 443
