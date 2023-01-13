FROM tomcat:latest

ADD ./target/SaiWebApplication*.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
