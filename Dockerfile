FROM tomcat:10.1-jdk17-temurin

# Install MySQL
RUN apt-get update && apt-get install -y mysql-server && apt-get clean

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file
COPY EcommerceApp.war /usr/local/tomcat/webapps/ROOT.war

# Copy SQL schema
COPY ecommerce.sql /ecommerce.sql

# Copy entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 3306 8080

ENTRYPOINT ["/docker-entrypoint.sh"]