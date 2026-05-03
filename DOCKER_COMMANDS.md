# Docker Commands Cheat Sheet

Basic Docker commands for checking containers, images, volumes, logs, and cleanup.

## Containers

List running containers:

```bash
docker ps
```

List all containers, including stopped or hidden ones:

```bash
docker ps -a
```

List only container IDs:

```bash
docker ps -q
```

List all container IDs, including stopped ones:

```bash
docker ps -aq
```

Start a stopped container:

```bash
docker start <container_name_or_id>
```

Stop a running container:

```bash
docker stop <container_name_or_id>
```

Remove a stopped container:

```bash
docker rm <container_name_or_id>
```

## Docker Compose

Start services in the background:

```bash
docker compose up -d
```

Stop services but keep data:

```bash
docker compose down
```

Stop services and delete volumes/data:

```bash
docker compose down -v
```

List Compose services:

```bash
docker compose ps
```

List Compose services, including stopped ones:

```bash
docker compose ps -a
```

Run a one-time Compose service and remove its temporary container after:

```bash
docker compose run --rm <service_name>
```

Example:

```bash
docker compose run --rm migrate
docker compose run --rm seed
```

## Logs

Show logs for all Compose services:

```bash
docker compose logs
```

Show logs for one service:

```bash
docker compose logs db
```

Follow logs live:

```bash
docker compose logs -f
```

Follow logs for one service:

```bash
docker compose logs -f db
```

## Execute Commands Inside A Container

Open a shell inside a running container:

```bash
docker exec -it <container_name_or_id> sh
```

For MySQL container:

```bash
docker compose exec db mysql -uuser -puserpassword appdb
```

Run a SQL command directly:

```bash
docker compose exec db mysql -uuser -puserpassword appdb -e "SHOW TABLES;"
```

## Images

List downloaded images:

```bash
docker images
```

Remove an image:

```bash
docker rmi <image_name_or_id>
```

## Volumes

List volumes:

```bash
docker volume ls
```

Inspect a volume:

```bash
docker volume inspect <volume_name>
```

Remove a volume:

```bash
docker volume rm <volume_name>
```

Warning: removing a database volume deletes the saved database data.

## Networks

List networks:

```bash
docker network ls
```

Inspect a network:

```bash
docker network inspect <network_name>
```

## Cleanup

Remove stopped containers:

```bash
docker container prune
```

Remove unused images:

```bash
docker image prune
```

Remove unused volumes:

```bash
docker volume prune
```

Remove unused networks:

```bash
docker network prune
```

Remove unused containers, networks, images, and build cache:

```bash
docker system prune
```

Be careful with prune commands. They delete unused Docker resources.

