FROM arm64v8/openjdk:21

ARG DB_URL
ARG DB_USERNAME
ARG DB_PASSWORD
ARG GITHUB_TOKEN
ARG REDIS_HOST
ARG REDIS_PORT
ARG GH_OAUTH_ID
ARG GH_OAUTH_SECRET
ARG INTERNAL_SECRET
ARG SLACK_TOKEN
ARG JWT_KEY
ARG TEST_SECRET

ARG JAR_FILE=./build/libs/*.jar
COPY ${JAR_FILE} gitanimals-api.jar

ENV db_url=${DB_URL} \
  db_username=${DB_USERNAME} \
  db_password=${DB_PASSWORD} \
  github_token=${GITHUB_TOKEN} \
  redis_host=${REDIS_HOST} \
  redis_port=${REDIS_PORT} \
  oauth_client_id_github=${GH_OAUTH_ID} \
  oauth_client_secret_github=${GH_OAUTH_SECRET} \
  internal_secret=${INTERNAL_SECRET} \
  slack_token=${SLACK_TOKEN} \
  jwt_key=${JWT_KEY} \
  test_secret=${TEST_SECRET}

ENTRYPOINT java -Djava.net.preferIPv4Stack=true -jar gitanimals-api.jar \
  --spring.datasource.url=${db_url} \
  --spring.datasource.username=${db_username} \
  --spring.datasource.password=${db_password} \
  --netx.host=${redis_host} \
  --netx.port=${redis_port} \
  --github.token=${github_token} \
  --oauth.client.id.github=${oauth_client_id_github} \
  --oauth.client.secret.github=${oauth_client_secret_github} \
  --internal.secret=${internal_secret} \
  --slack.token=${slack_token} \
  --jwt.key=${jwt_key} \
  --test.secret=${test_secret}
