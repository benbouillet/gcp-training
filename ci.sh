#!/bin/bash

deploy() {
  docker compose run --rm gcp-training-ci deploy
}

destroy() {
  docker compose run --rm gcp-training-ci destroy
}

build() {
  docker compose build
}

list() {
  docker compose run --rm gcp-training-ci list
}

show() {
  docker compose run --rm gcp-training-ci show -- $1
}

output() {
  docker compose run --rm gcp-training-ci output -- $1
}

help() {
  echo "Usage: ci <command>"
  echo
  echo "Available commands:"
  echo "  build   - Builds the CI docker image"
  echo "  deploy  - Deploys the terraform stack"
  echo "  destroy - Destroys the terraform stack"
}

case "$1" in
  build)
    build
    ;;
  deploy)
    deploy
    ;;
  destroy)
    destroy
    ;;
  list)
    list
    ;;
  show)
    show $2
    ;;
  output)
    output $2
    ;;
  *)
    echo "Unknown command. Use 'ci help' for available commands."
    ;;
esac
