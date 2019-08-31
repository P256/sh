# Build 
cd /root/.jenkins/workspace
tar cf 1.${BUILD_ID}.${SVN_REVISION}.tar.gz sns --exclude=.svn --exclude=.svn
mkdir sns/dist
mv 1.${BUILD_ID}.${SVN_REVISION}.tar.gz sns/dist

#
# Post-build Actions
# mkdir /home/web/src /home/web/sns
# cd /home/web/src
# rm -fr /home/web/sns/*
# tar xf 1.${BUILD_ID}.${SVN_REVISION}.tar.gz -C /home/web/
# chown -R web:web /home/web/