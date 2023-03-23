FROM alpine:3.17.2

RUN apk update && apk add --no-cache \
    bash \
    git \
    curl \
    build-base \
    make \
    cmake \
    linux-headers \
    jq

RUN git clone https://github.com/google/robotstxt.git robotstxt

WORKDIR /robotstxt

RUN mkdir c-build && cd c-build && \
    cmake ../ -DROBOTS_BUILD_TESTS=ON && \
    make && \
    make test

COPY validate.sh .
RUN chmod +x validate.sh

ENTRYPOINT [ "./validate.sh" ]
