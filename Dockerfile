FROM eclipse-temurin:21-jdk

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        unzip \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_VERSION=21.0.5

ENV JAVA_HOME=/usr/lib/jvm/oracle-jdk-21

RUN mkdir -p ${JAVA_HOME} && \
    curl -L -o /tmp/jdk.tar.gz \
    "https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz" && \
    tar -xzf /tmp/jdk.tar.gz -C /tmp && \
    mv /tmp/jdk-21*/* ${JAVA_HOME}/ && \
    rm -rf /tmp/jdk.tar.gz /tmp/jdk-21*

ENV PATH=${JAVA_HOME}/bin:${PATH}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-venv \
        python3-pip \
        pipx \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*


RUN ln -s /usr/bin/python3 /usr/bin/python

ENV AWSCLI_HOME=/usr/lib/awscli

RUN mkdir -p ${AWSCLI_HOME} && \
    curl -L -o /tmp/awscliv2.zip "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" && \
    unzip /tmp/awscliv2.zip && \
    mv ./aws ${AWSCLI_HOME}/ && \
    ${AWSCLI_HOME}/aws/install && \
    rm -rf /tmp/awscliv2.zip

RUN mkdir -p .aws

RUN cat > /.aws/credentials <<'EOF'
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
EOF

RUN cat > /.aws/config <<'EOF'
[default]
region = us-east-1
output = json

[services dynamodb]
region = us-east-1
endpoint_url = http://localhost:8000
output = json
EOF

RUN chmod 660 /.aws/credentials
RUN chmod 660 /.aws/config

CMD [ "bash" ]
