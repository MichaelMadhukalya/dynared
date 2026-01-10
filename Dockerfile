FROM alpine:3.19

RUN apk add --no-cache \
    bash \
    curl \
    tar \
    unzip \
    gcompat \
    libc6-compat

ENV JAVA_VERSION=21.0.5

ENV JAVA_HOME=/usr/lib/jvm/oracle-jdk-21

RUN mkdir -p ${JAVA_HOME} && \
    curl -L -o /tmp/jdk.tar.gz \
    "https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz" && \
    tar -xzf /tmp/jdk.tar.gz -C /tmp && \
    mv /tmp/jdk-21*/* ${JAVA_HOME}/ && \
    rm -rf /tmp/jdk.tar.gz /tmp/jdk-21*

ENV PATH=${JAVA_HOME}/bin:${PATH}

CMD [ "/bin/sh" ]
