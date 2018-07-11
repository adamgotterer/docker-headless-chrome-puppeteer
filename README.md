# Headless Chrome Puppeteer

[DockerHub Repo](https://hub.docker.com/r/chromie/headless-chrome-puppeteer/)

This Dockerfile will build a Headless Chrome (Chromium) container with the same version of Chrome
used in [Puppeteer](https://github.com/GoogleChrome/puppeteer). Puppeteer will not be installed
inside this container. This was built primarly for an easy way to use Puppeteer in a remote
container without haveing to deal with trying to figure out which version of Chrome a specific
version of Puppeteer works with.

Once a day this project will check for new versions of Puppeteer based on the release tag and
will automatically build a new container and tag it with the same versioning name as Puppeteer.
For example Puppeteer v1.5.0 will translate to `chromie/headless-chrome-puppeteer:v1.5.0`.
