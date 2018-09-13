# tunnel

A configurable dockerised SSH server.

## Getting started

To get up and running the quickest way is to run the image from Docker Hub:

```
docker run --name tunnel -p 2200:22 -e USER=foobar -e AUTHORIZED_KEY="..." everydayhero/tunnel:latest
```

If you would like to build and run your own image:

* Clone this repo: `git clone git@github.com:everydayhero/tunnel.git`
* Build the image: `docker build -t tunnel tunnel`

## Options

`USER`: The username. Defaults to `tunnel`.

`PASSWORD`: The password to authenticate. Defaults to disabled.

`AUTHORIZED_KEY`: The authorized pubkey to authenticate with. Required unless `PASSWORD` provided.

`RSA_HOST_KEY`: The server's RSA private key. Default is randomly generated when launched.

`BANNER`: The banner to display when connected. Default to blank.
