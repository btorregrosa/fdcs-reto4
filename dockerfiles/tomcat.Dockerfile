FROM vulhub/tomcat:8.0

ENV RUN_USER            tomcat
ENV RUN_GROUP           tomcat


# Crea un nuevo usuario no root
USER root

RUN sh -c "echo $(openssl rand -hex 16) > /root/root.txt"

# Copiar los archivos XML al contenedor
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
COPY context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml

# Exponer el puerto 8080 para Tomcat
EXPOSE 8080



# Iniciar Tomcat
CMD ["catalina.sh", "run"]
