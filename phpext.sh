#!/usr/bin/bash
clear
#
#
# Taint可以用来检测隐藏的XSS code,SQL注入,Shell注入等漏洞
# beast可以用来加密代码
# XHProf轻量级的分层性能测量分析器
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
#修改config.m4
vi config.m4
#动态编译选项,通过.so的方式链接,去掉dnl注释
#PHP_ARG_WITH(f256, for f256 support,
#[  --with-f256             Include f256 support])
#
#静态编译选项,通过enable来启用,去掉dnl注释
#PHP_ARG_ENABLE(f256, whether to enable f256 support,
#[  --enable-f256           Enable f256 support])

#

#

#beast

#

#