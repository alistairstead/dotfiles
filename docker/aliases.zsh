#!/bin/sh

alias d='docker'

docker_prune() {
	docker system prune --volumes -f
}

docker_clean() {
	docker volume rm $(docker volume ls -qf dangling=true)
}

postgres_start() {
	docker run --name postgres -d --restart=unless-stopped \
		-e POSTGRES_PASSWORD=postgres \
		-e POSTGRES_USER=postgres \
		-p 5432:5432 postgres
}

postgres_stop() {
	docker rm postgres -f
}

ubuntu_here() {
  docker run -it -v $(pwd):/opt ubuntu /bin/bash
}

redis_start() {
	docker run --name redis -d --restart=unless-stopped -p 6379:6379 redis
}

redis_stop() {
	docker rm redis -f
}
