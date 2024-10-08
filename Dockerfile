# Use Alpine as the base image
FROM alpine:latest

# Install cron, bash, curl, and Node.js
RUN apk add --no-cache bash curl mysql-client nodejs npm

# Create a directory for the backup script
WORKDIR /usr/src/app

# Copy the backup script, .env file, and upload.js
COPY . /usr/src/app/

# Make the script executable
RUN chmod +x /usr/src/app/

# Add the cron job
RUN echo "0 3 * * * /usr/src/app/script.sh >> /var/log/cron.log 2>&1" > /etc/crontabs/root

# Create the log file for cron output
RUN touch /var/log/cron.log

# Start cron
CMD ["crond", "-f"]
