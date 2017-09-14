FROM ubuntu
MAINTAINER dayong.lu <ludayong20@gmail.com>



RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN apt-get update
RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:webupd8team/java

RUN apt-get update

RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN apt-get install -y oracle-java8-installer
RUN apt-get install -y oracle-java8-set-default
RUN apt-get install -y maven
RUN apt-get clean all

RUN mkdir hello-docker
ADD ./target/HelloDocker-0.0.1-SNAPSHOT.jar hello-docker
WORKDIR hello-docker
EXPOSE 8090
ENTRYPOINT ["sh","-c","java -Djava.security.egd=file:/dev/./urandom -jar HelloDocker-0.0.1-SNAPSHOT.jar > output.out"]
