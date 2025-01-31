FROM sonarqube:9.4-community

ARG RUSSIAN_PACK=9.0
ARG BRANCH_PLUGIN_VERSION=1.12.0
ARG BSL_PLUGIN_VERSION=1.11.0

USER root

# Фикс ошибки https://github.com/SonarSource/docker-sonarqube/issues/544
RUN apk add --no-cache --upgrade "zlib>=1.2.12-r1"

WORKDIR /opt/sonarqube

# plugins
ADD --chown=sonarqube:sonarqube https://github.com/1c-syntax/sonar-l10n-ru/releases/download/v${RUSSIAN_PACK}/sonar-l10n-ru-plugin-${RUSSIAN_PACK}.jar extensions/plugins
ADD --chown=sonarqube:sonarqube https://github.com/1c-syntax/sonar-bsl-plugin-community/releases/download/v${BSL_PLUGIN_VERSION}/sonar-communitybsl-plugin-${BSL_PLUGIN_VERSION}.jar extensions/plugins

ADD --chown=sonarqube:sonarqube https://github.com/mc1arke/sonarqube-community-branch-plugin/releases/download/${BRANCH_PLUGIN_VERSION}/sonarqube-community-branch-plugin-${BRANCH_PLUGIN_VERSION}.jar extensions/plugins
ENV SONAR_WEB_JAVAADDITIONALOPTS=-javaagent:./extensions/plugins/sonarqube-community-branch-plugin-${BRANCH_PLUGIN_VERSION}.jar=web
ENV SONAR_CE_JAVAADDITIONALOPTS=-javaagent:./extensions/plugins/sonarqube-community-branch-plugin-${BRANCH_PLUGIN_VERSION}.jar=ce

USER sonarqube
