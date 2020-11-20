FROM hamletio/hamlet:latest AS hamletschema

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]