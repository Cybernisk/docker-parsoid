# Docker image of Parsoid for MediaWiki

[![Docker Pulls](https://img.shields.io/docker/pulls/cybernick/parsoid.svg?style=flat-square)](https://hub.docker.com/r/thenets/parsoid/) [![Build Status](https://travis-ci.org/Cybernisk/docker-parsoid.svg?branch=master)](https://travis-ci.org/cybernisk/docker-parsoid)


This repo contains a [Docker](https://docs.docker.com/) image to run the [Parsoid](https://www.mediawiki.org/wiki/Parsoid) application. See the full [Parsoid/Setup documentation](https://www.mediawiki.org/wiki/Parsoid/Setup#Docker) for help.

And this repo was base on this [repo](https://github.com/thenets/docker-parsoid/) with little modifications and basically build to use Parsoid with this [MediaWiki docker repo]() both in docker.

## How to deploy
To start [Parsoid](https://www.mediawiki.org/wiki/Parsoid) standalone run the command below. Just pay attention to the MediaWiki version and choose a compatible Parsoid version.

```
# For MediaWiki = 1.31 and Parsoid build 0.9.0
docker run -it -e PARSOID_DOMAIN_localhost=http://localhost/w/api.php cybernick/parsoid:0.9.0

# For MediaWiki >= 1.31 and Parsoid build 0.10.0
docker run -it -p 8080:80 -e PARSOID_DOMAIN_localhost=http://localhost/w/api.php cybernick/parsoid:0.10.0
```
Pay attention to connect parsoid container with your MediaWiki container

## Examples

How to add more than one domain:

```
docker run -it -p 8080:80 \
            -e PARSOID_DOMAIN_foobar=http://foobar.com/w/api.php \
            -e PARSOID_DOMAIN_example=http://example.com/w/api.php \
            -e PARSOID_DOMAIN_localhost=http://localhost/w/api.php \
            cybernick/parsoid:0.10.0
```

## Settings (ENV vars)

- `PARSOID_DOMAIN_{domain}` defines URI and domain for the Parsoid service. The value of `{domain}` should be the same as the `MW_REST_DOMAIN` parameter in the MediaWiki web container. You can specify such variables multiple times (one for each domain the service should run for)
- `PARSOID_NUM_WORKERS` defines the number of worker processes to the parsoid service. Set to `0` to run everything in a single process without clustering. Use `ncpu` to run as many workers as there are CPU units.
- `PARSOID_LOGGING_LEVEL` by default `info`

For example, the environment variable `PARSOID_DOMAIN_web=http://web/w/api.php` creates following section in the Parsoid configuration:
```
mwApis:
  -
    uri: 'http://web/w/api.php'
    domain: 'web'
```

## Thanks 

- [pastakhov](https://github.com/pastakhov): Creator of the original code base.
- [muellermartin](https://github.com/muellermartin): Improved the documentation.
- [thenets](https://github.com/thenets/docker-parsoid) Creator of forked version