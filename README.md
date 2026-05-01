# Basic MySQL + Adminer Setup

This setup starts a MySQL database and an Adminer web UI using Docker Compose.

## Files

- `docker-compose.yml` - starts MySQL and Adminer
- `.env-sample` - example environment variables
- `schema.sql` - creates the tables
- `seed.sql` - inserts sample data

## Requirements

Install Docker and Docker Compose first.

Check if Docker works:

```bash
docker --version
docker compose version
```

## Start The Database

From this folder, run:

```bash
cp .env-sample .env
```

This creates the `.env` file that Docker Compose uses for the MySQL database name, username, and password.

Then start the containers:

```bash
docker compose up -d
```

This starts:

- MySQL on `localhost:3306`
- Adminer on `http://localhost:8080`

## Adminer Login

Open:

```text
http://localhost:8080
```

Use these values:

```text
System: MySQL
Server: db
Username: user
Password: userpassword
Database: appdb
```

These values come from `.env`.

## Check The Data

Run this command:

```bash
docker compose exec db mysql -uuser -puserpassword appdb
```

Then inside MySQL:

```sql
SHOW TABLES;
SELECT * FROM users;
SELECT * FROM posts;
```

Exit MySQL:

```sql
exit;
```

## Stop The Containers

```bash
docker compose down
```

This stops the containers but keeps the database data.

## Reset Everything

If you change `schema.sql` or `seed.sql`, Docker will not automatically run them again if the MySQL volume already exists.

To delete the old database and rerun `schema.sql` and `seed.sql`:

```bash
docker compose down -v
docker compose up -d
```

Warning: `docker compose down -v` deletes the database volume and removes all saved data for this setup.
