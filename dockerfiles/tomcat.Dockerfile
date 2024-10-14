FROM vulhub/tomcat:8.0

ENV RUN_USER            tomcat
ENV RUN_GROUP           tomcat


# Crea un nuevo usuario no root
USER root



# Copiar los archivos XML al contenedor
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
COPY context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml

# Exponer el puerto 8080 para Tomcat
EXPOSE 8080

RUN groupadd -r ${RUN_GROUP} && useradd -g ${RUN_GROUP} -d ${CATALINA_HOME} -s /bin/bash ${RUN_USER}
RUN chown -R tomcat:tomcat $CATALINA_HOME

RUN mkdir -p /home/${RUN_USER} && chown -R ${RUN_USER}:${RUN_GROUP} /home/${RUN_USER}
RUN sh -c "echo $(openssl rand -hex 16) > /home/${RUN_USER}/user.txt"

USER ${RUN_USER}

# Iniciar Tomcat
CMD ["catalina.sh", "run"]
