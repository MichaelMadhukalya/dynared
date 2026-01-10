FROM eclipse-temurin:21-jdk

RUN apt-get update && \
    apt-get install -y && \
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

ENV DYNAMODB_HOME=/dynamodb_local

WORKDIR ${DYNAMODB_HOME}

COPY . .

RUN tar -xzf ${DYNAMODB_HOME}/dist/archive/dynamodb_local_latest.tar.gz -C ${DYNAMODB_HOME}/dist 

EXPOSE 8000

ENTRYPOINT java -Djava.library.path=${DYNAMODB_HOME}/dist/DynamoDBLocal_lib -jar ${DYNAMODB_HOME}/dist/DynamoDBLocal.jar -sharedDb -dbPath ${DYNAMODB_HOME}/data
