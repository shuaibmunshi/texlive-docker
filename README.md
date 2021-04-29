# Texlive-docker

## About

This container builds a minimalist (lol as if latex can be minimalist) docker image with xetex using livetex. 

It can be used to compile the popular [deedy latex resume template](https://github.com/deedy/Deedy-Resume).

[dockerhub](https://hub.docker.com/r/shuaibmunshi/texlive-docker)

## Usage

```
docker run --rm -i --user="$(id -u):$(id -g)" --net=none -v "$PWD:/data" shuaibmunshi/resume
xetex resume.tex
```

## Credits

- https://github.com/brokenpylons/docker-lualatex
- https://github.com/blang/latex-docker