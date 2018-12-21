FROM debian:stretch-slim
# FROM debian:stretch  # for debugging docker build
RUN \
    groupadd --gid 10001 app && \
    useradd --uid 10001 --gid 10001 --home /app --create-home app && \
    \
    apt-get -qq update && \
    apt-get -qq install -y default-libmysqlclient-dev libssl-dev ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists && \
    mkdir -p -m 755 /app/bin && \
    mkdir -p -m 755 /app/bin/config

COPY /app /app

USER app

ENV FXA_EMAIL_ENV production
ENV ROCKET_ENV production

CMD ["/app/bin/fxa_email_send"]
