FROM openjdk:8-jdk-alpine As builder
RUN apk update && \
    apk add git && \
    git clone https://github.com/SecurityFTW/cs-suite.git
FROM openjdk:8-jdk-alpine
COPY --from=builder /cs-suite /app/
WORKDIR /app
RUN apk update && apk add --no-cache grep sshpass curl bash  && \
   pip install -r requirements.txt  && \
   pip install awscli --ignore-installed six
ENTRYPOINT ["python", "/app/cs.py"]
