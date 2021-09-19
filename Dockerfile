FROM openjdk:8-jdk-alpine As builder
RUN apk update && \
    apk add git && \
    git clone https://github.com/SecurityFTW/cs-suite.git
FROM openjdk:8-jdk-alpine
RUN apk update && \
    apk --update --no-cache add python3 bash curl py3-pip && \
    pip3 install --upgrade pip && \
    #pip3 install awscli boto3 detect-secrets
    #apk add --no-cache grep sshpass curl bash && \
    pip3 install -r requirements.txt && \
    pip3 install awscli --ignore-installed six
COPY --from=builder /cs-suite /app/
WORKDIR /app
ENTRYPOINT ["python", "/app/cs.py"]
