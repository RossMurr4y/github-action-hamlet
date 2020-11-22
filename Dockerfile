FROM hamletio/hamlet:latest AS hamletschema
# github actions must be run as root in order to access GITHUB_WORKSPACE directory
USER root
COPY entrypoint.sh /entrypoint.sh
COPY scripts/* /scripts/
ENTRYPOINT ["/entrypoint.sh"]