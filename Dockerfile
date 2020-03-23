# first, we will build ami3 with maven
FROM maven:3-jdk-8 as builder
SHELL ["/bin/bash", "-c"]

ENV PATH /opt/ami3/target/appassembler/bin:$PATH
RUN git clone https://github.com/petermr/ami3 /opt/ami3
RUN cd /opt/ami3 \
    && mvn install -Dmaven.test.skip=true

RUN rm /opt/ami3/target/appassembler/bin/*.bat

# now, we can copy the compiled binaries across to a jdk8 container
FROM openjdk:8

# install nvm & node
ENV NVM_DIR /opt/nvm
ENV NODE_VERSION 7.10.1
RUN git clone https://github.com/nvm-sh/nvm.git $NVM_DIR && cd $NVM_DIR && git checkout v0.35.3 && cd /root \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# install getpapers
RUN npm install --global getpapers

# copy across binaries from builder
COPY --from=builder /opt/ami3/target /bin/ami3
ENV PATH /bin/ami3/appassembler/bin:$PATH


VOLUME [ "/workspace" ]
WORKDIR /workspace

# put the user into a bash env when running container
CMD [ "/bin/bash" ]
