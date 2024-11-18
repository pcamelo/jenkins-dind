# Jenkins DinD (Docker-in-Docker)

This project extends the official Jenkins LTS image by adding support for running Docker commands inside the Jenkins container (Docker-in-Docker).

## How It Works

The custom Jenkins image includes the following modifications:
- Installs Docker CLI inside the Jenkins container.
- Adds the `jenkins` user to the `docker` group, allowing it to run Docker commands.

## Usage

### Building Locally

To build this image locally, run:

```bash
docker build -t my-jenkins-dind .
```

### Running Locally

To run this image locally with access to your host's Docker daemon:

```bash
docker run --name jenkins-dind --rm -d \
  --privileged \
  -p 8080:8080 -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  my-jenkins-dind
```

## CI/CD Pipeline

This repository uses GitHub Actions for CI/CD. Each time a new tag is pushed, a new version of the Jenkins DinD image is built and pushed automatically to Docker Hub with a maximum delay of 24h.