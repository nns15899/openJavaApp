FROM OpenJDK:8
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN javac Kick.java
EXPOSE 5000
ENTRYPOINT ["java", "Kick"]
