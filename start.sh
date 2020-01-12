#!/bin/bash
__run() {
  echo -e "123456\n123456" | (passwd)
  /usr/sbin/sshd -D
}

__start() {
if [ ! -d "/ym/" ];then
   mkdir -p /ym/www
   cp /var/www/xz-5.2.4.tar.bz2 /ym/www
   cp /var/www/ffmpeg-release-amd64-static.tar.xz /ym/www
   cd /ym/www
   tar -jxvf xz-5.2.4.tar.bz2
   cd /ym/www/xz-5.2.4
   ./configure --prefix=/opt/gnu/xz
    make install
    cd /ym/www
   xz -d ffmpeg-release-amd64-static.tar.xz
   tar -xvf ffmpeg-release-amd64-static.tar
else
echo "文件夹已经存在"
fi
  #程序名
  RUN_NAME="$1"
  #jar 位置
  JAVA_OPTS=/var/www/"$1".jar
  source /etc/profile
   java -jar $JAVA_OPTS   &
  echo "$RUN_NAME started success."
}

# Call all functions
__start $1
__run