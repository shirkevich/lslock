FROM ruby:2.1-onbuild

#RUN apt-get update && apt-get install -y lsof

CMD ["./bin/lslock"]
