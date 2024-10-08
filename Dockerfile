# Use a base image with bash and mysql client
FROM mysql:5.7

# Install Node.js and cron
RUN apt-get update && apt-get install -y nodejs npm cron

# Set the working directory
WORKDIR /app

# Copy your backup script and upload.js to the container
COPY backup.sh .
COPY upload.js .

# Copy your .env file
COPY .env .

# Give execution permission to the backup script
RUN chmod +x backup.sh

# Create a cron job
RUN echo "0 3 * * * /app/backup.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/backup-cron

# Give cron job the right permissions
RUN chmod 0644 /etc/cron.d/backup-cron

# Apply cron job
RUN crontab /etc/cron.d/backup-cron

# Create the log file to be able to run the tail command
RUN touch /var/log/cron.log

# Start cron and your application
CMD cron && tail -f /var/log/cron.log
