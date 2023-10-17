# Use a basic Ubuntu image as the base
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y curl jq dialog apache2

# Enable CGI
RUN a2enmod cgi && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    service apache2 restart

# Copy the Bash script into the container
COPY travel.sh /usr/lib/cgi-bin/
RUN chmod +x /usr/lib/cgi-bin/travel.sh

# Add an HTML page to Apache's root
COPY index.html /var/www/html/

# Expose the port Apache runs on
EXPOSE 80

# Start Apache in the foreground
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
