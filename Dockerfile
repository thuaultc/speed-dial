FROM golang:1.11.0-alpine

ENV HUGO_VERSION 0.48 
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux-64bit 
ENV PATH=/usr/local/hugo:${PATH}

RUN set -x \
    && apk upgrade --update \
    && apk add --update ca-certificates bash curl wget \
    && rm -rf /var/cache/apk/* \
    && mkdir /usr/local/hugo \
    && wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz -O /usr/local/hugo/${HUGO_BINARY}.tar.gz \
    && tar xzf /usr/local/hugo/${HUGO_BINARY}.tar.gz -C /usr/local/hugo/ \
    && rm /usr/local/hugo/${HUGO_BINARY}.tar.gz \
    && rm -rf /tmp/* /var/cache/apk/* 

WORKDIR /srv/app
COPY app/ .
RUN hugo

FROM nginx:1.13.8
EXPOSE 80
WORKDIR /usr/share/nginx/html
COPY --from=0 /srv/app/public/ .