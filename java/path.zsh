#!/bin/sh

# export JAVA_HOME=$(/usr/libexec/java_home)
export MAVEN_OPTS="-Xmx1024m"
# export M2_HOME="/usr/local/Cellar/maven/3.6.0/libexec"
export M2_HOME=/usr/local/opt/maven/libexec
export PATH=$PATH:$M2HOME/bin
