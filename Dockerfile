# Use an Alpine base image for a minimal footprint
FROM bitnami/pgbouncer:latest

# Install necessary packages
# RUN apk add --no-cache pgbouncer

# Create the PgBouncer configuration directory
# RUN mkdir -p /etc/pgbouncer /var/log/pgbouncer /var/run/pgbouncer && \
#     chown -R nobody:nobody /etc/pgbouncer /var/log/pgbouncer /var/run/pgbouncer

# Set up the configuration file
COPY pgbouncer.ini /etc/pgbouncer/pgbouncer.ini
COPY userlist.txt /etc/pgbouncer/userlist.txt

# Set correct permissions
# RUN chmod 600 /etc/pgbouncer/pgbouncer.ini /etc/pgbouncer/userlist.txt && \
#     chown nobody:nobody /etc/pgbouncer/pgbouncer.ini /etc/pgbouncer/userlist.txt

# Expose the default PgBouncer port
EXPOSE 6432

# Switch to a non-root user
USER nobody

# Run PgBouncer
CMD ["/usr/bin/pgbouncer", "/etc/pgbouncer/pgbouncer.ini"]