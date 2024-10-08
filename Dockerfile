FROM alpine:latest

# Install cron and bash
RUN apk add --no-cache bash curl mysql-client

# Create a directory for the backup script
WORKDIR /usr/src/app

# Copy the backup script and .env file
COPY script.sh /usr/src/app/script.sh
COPY .env /usr/src/app/.env

# Make the script executable
RUN chmod +x /usr/src/app/script.sh

# Add the cron job
RUN echo "0 3 * * * /usr/src/app/script.sh" > /etc/crontabs/root

# Start cron
CMD ["crond", "-f"]
