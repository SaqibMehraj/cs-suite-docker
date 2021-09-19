FROM openjdk:8-jdk-alpine As builder
RUN apk update && \
    apk add git && \
    git clone https://github.com/SecurityFTW/cs-suite.git
FROM openjdk:8-jdk-alpine
RUN apk update && apk add --no-cache grep sshpass curl bash py-pip \
    && pip install -r requirements.txt \
    && pip install awscli --ignore-installed six
COPY --from=builder /cs-suite /app/
WORKDIR /app
ENTRYPOINT ["python", "/app/cs.py"]
