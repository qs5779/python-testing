# [`python-testing`]

## Dockerfiles(s)

This is a single purpose repository intended to provide a mechanism for building docker images I use for testing. The builds are handled automatically by github actions when you push a branch with a name that matches one of:

```
      - 'ubuntu20.04-[0-9].[0-9]+.[0-9]+'
      - 'rocky8-[0-9].[0-9]+.[0-9]+'
      - 'rocky9-[0-9].[0-9]+.[0-9]+'
      - 'arch-[0-9].[0-9]+.[0-9]+'
```
an action is triggered, that builds the images based on images specified by the (distro)- part of the branch name, with python installed via [https://github.com/pyenv/pyenv](pyenv) version -(python_version) part of the branch name.

If the distro base image supports arm64, the images built will support platforms amd64, arm64. At the present time the archlinux base image does not support arm64.

If you fork this repo you will need to update the github action workflows to use your username / credentials.

## Dockerhub

The images I use are available on [https://hub.docker.com](dockerhub) at: [https://hub.docker.com/repository/docker/qs5779/python-testing](python-testing)

