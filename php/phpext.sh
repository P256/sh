#!/usr/bin/bash
clear
#
#
# Taint��������������ص�XSS code,SQLע��,Shellע���©��
# beast�����������ܴ���
# XHProf�������ķֲ����ܲ���������
#
#
# Dev tools
#yum install gcc make autoconf
#
cd /usr/local/php7.1/ext/
#
extName = f256
#
./ext_skel --extname=${extName}
#
#1.  $ cd ..
#2.  $ vi ext/f256/config.m4
#3.  $ ./buildconf
#4.  $ ./configure --[with|enable]-f256
#5.  $ make
#6.  $ ./sapi/cli/php -f ext/f256/f256.php
#7.  $ vi ext/f256/f256.c
#8.  $ make
#
cd ${extName}
#�޸�config.m4
vi config.m4
#��̬����ѡ��,ͨ��.so�ķ�ʽ����,ȥ��dnlע��
#PHP_ARG_WITH(f256, for f256 support,
#[  --with-f256             Include f256 support])
#
#��̬����ѡ��,ͨ��enable������,ȥ��dnlע��
#PHP_ARG_ENABLE(f256, whether to enable f256 support,
#[  --enable-f256           Enable f256 support])

#

#

#beast

#

#