FROM tomcat:8.5.58-jdk8-openjdk


ENV REDIS_HOST  "redis"

ADD target/clickCount.war /usr/local/tomcat/webapps/

#EXPOSE 8080

#CMD ["catalina.sh", "run"]