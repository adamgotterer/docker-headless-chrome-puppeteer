# Headless Chrome Puppeteer

[DockerHub Repo](https://hub.docker.com/r/chromie/headless-chrome-puppeteer/)

This Dockerfile is used build a Headless Chrome (Chromium) container with the same version of Chrome
used in [Puppeteer](https://github.com/GoogleChrome/puppeteer). This was built primary as an easy way to
use Puppeteer in a remote container without having to figure out what version of Chromium needs to be installed
with every Puppeteer release (Puppeteer will not be installed in this container). This Dockerfile is also used as a base 
image for [Chromie](https://github.com/adamgotterer/chromie) a Headless Chrome proxy server I built. Check
it out!

Once a day TravisCI will check for new versions of Puppeteer based on the release tag and
will automatically build a new container and tag it with the same version number as Puppeteer.
For example Puppeteer v1.5.0 will translate to `chromie/headless-chrome-puppeteer:v1.5.0`.

## Running the container

```bash
docker run -d -p 9222:9222 --cap-add=SYS_ADMIN chromie/headless-chrome-puppeteer:v1.5.0
```

You can access the DevTools by pointing your browser to `http://localhost:9222/`
