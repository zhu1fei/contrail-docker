#!/usr/bin/env bash
set -x
set -e
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# configure services and start them using ansible code within contrail-ansible
contrailctl config sync -c cephcontroller -F -v

HOSTNAME=`hostname`

sudo -u ceph /usr/bin/ceph-mon --cluster=ceph -i $HOSTNAME -f --setuser ceph --setgroup ceph &

ceph_pid=`ps -ef|grep ceph-mon|grep -v grep|grep sudo| awk '{print $2}'`

wait "$ceph_pid"