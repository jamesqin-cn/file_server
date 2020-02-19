FROM alpine

ADD file_server /bin/
ADD entrypoint.sh /bin/

RUN chmod +x /bin/file_server && chmod +x /bin/entrypoint.sh

ENTRYPOINT ["/bin/entrypoint.sh"]

EXPOSE 80
