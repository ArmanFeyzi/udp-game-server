FROM python:latest

ADD server.py /server/

WORKDIR /server/

# Expose port 7778 in the container
EXPOSE 7778/udp

CMD [ "python3", "/server/server.py" ]
