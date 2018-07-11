# Headless Chrome Puppeteer

[DockerHub Repo](https://hub.docker.com/r/chromie/headless-chrome-puppeteer/)

This Dockerfile will build a Headless Chrome (Chromium) container with the same version of Chrome
used in [Puppeteer](https://github.com/GoogleChrome/puppeteer). Puppeteer will not be installed
inside this container. This was built primary for an easy way to use Puppeteer in a remote
container without having to reconcile which version of Chrome was required for the specific
version of Puppeteer.

Once a day this project will check for new versions of Puppeteer based on the release tag and
will automatically build a new container and tag it with the same version name as Puppeteer.
For example Puppeteer v1.5.0 will translate to `chromie/headless-chrome-puppeteer:v1.5.0`.

## Running the container

```bash
docker run -d -p 9222:9222 --cap-add=SYS_ADMIN chromie/headless-chrome-puppeteer
```

You can access the DevTools by pointing your browser to `http://localhost:9222/`

## Building the container
You should only need to build the container manually if you made modifications to the Dockerfile

```bash
docker build --build-arg CHROMIUM_REVISION=XXXX -t chromie/headless-chrome-puppeteer .
```

The `CHROMIUM_REVISION` is the Chromium version which can be found [here](https://storage.googleapis.com/chromium-browser-snapshots/index.html?prefix=Linux_x64/). For example `571375`.

If you're wondering how a Puppeteer version gets converted to a Chromium version you should take a look at the `.travis.yml` file. 
