#!/usr/bin/bash
PGSOURCE="/var/tmp/postgresql-9.5.3.tar.bz2"
PGUSER="postgres"
PGGROUP="postgres"
PGHOME="/u01/app/postgres/product/95/db_3"
SEGSIZE=2
BLOCKSIZE=8
mkdir -p /u01/app
chown ${PGUSER}:${PGGROUP} /u01/app
su - ${PGUSER} -c "cd /var/tmp/; tar -axf ${PGSOURCE}"
su - ${PGUSER} -c "cd /var/tmp/postgresql-9.5.3; ./configure --prefix=${PGHOME} \
            --exec-prefix=${PGHOME} \
            --bindir=${PGHOME}/bin \
            --libdir=${PGHOME}/lib \
            --sysconfdir=${PGHOME}/etc \
            --includedir=${PGHOME}/include \
            --datarootdir=${PGHOME}/share \
            --datadir=${PGHOME}/share \
            --with-pgport=5432 \
            --with-perl \
            --with-python \
            --with-tcl \
            --with-openssl \
            --with-pam \
            --with-ldap \
            --with-libxml \
            --with-libxslt \
            --with-segsize=${SEGSIZE} \
            --with-blocksize=${BLOCKSIZE} \
            --with-wal-segsize=16  \
            --with-extra-version=\" dbi services build\""
su - ${PGUSER} -c "cd /var/tmp/postgresql-9.5.3; make world"
su - ${PGUSER} -c "cd /var/tmp/postgresql-9.5.3; make install"
su - ${PGUSER} -c "cd /var/tmp/postgresql-9.5.3/contrib; make install"
rm -rf /var/tmp/postgresql*
