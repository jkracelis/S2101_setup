# Basic MySQL + Adminer Setup

This setup starts a MySQL database and an Adminer web UI using Docker Compose.

## Files

- `docker-compose.yml` - starts MySQL and Adminer
- `.env-sample` - example environment variables
- `migrations/` - stores database schema changes that should run only once
- `seeds/` - stores sample data that you can run manually

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

Then run the migrations:

```bash
docker compose run --rm migrate
```

This creates the database tables from the SQL files inside `migrations/`.

To insert sample data manually:

```bash
docker compose run --rm seed
```

Run seeds after migrations because the tables must exist first.

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

## Check The Tables

Run this command:

```bash
docker compose exec db mysql -uuser -puserpassword appdb
```

Then inside MySQL:

```sql
SHOW TABLES;
DESCRIBE users;
DESCRIBE posts;
SELECT * FROM users;
SELECT * FROM posts;
```

Exit MySQL:

```sql
exit;
```

## Run Migrations

Use migrations when you want to change the database without deleting all data.

This project already has:

```text
migrations/V000_001__create_users_posts.sql
migrations/V000_002__add_phone.sql
migrations/V000_003__rename_phone.sql
```

`V000_001` creates the `users` and `posts` tables.

`V000_002` adds the `phone` column to `users`.

`V000_003` renames `phone` to `phones`.

Flyway runs migration files in version order and records what already ran. If you run this again:

```bash
docker compose run --rm migrate
```

Flyway will skip old migration files because they already ran.

## Manual Seed Data

Seed data is separate from migrations in this setup.

This project uses:

```text
seeds/seed.sql
```

That file inserts sample rows into `users` and `posts`.

Run it manually:

```bash
docker compose run --rm seed
```

Use `INSERT IGNORE` for basic sample seeds so running the seed command more than once avoids duplicate primary-key errors.

For a new change, create a higher version number:

```text
migrations/V000_004__add_status.sql
migrations/V000_005__create_comments.sql
```

Migration files must follow this format or Flyway will not run them:

```text
V000_001__verb_target.sql
```

Examples:

```text
V000_004__add_post_status.sql
V000_005__create_comments.sql
V000_006__drop_age.sql
V000_007__rename_phone.sql
V000_008__fix_user_email.sql
```

Rules:

- Start with capital `V`
- Use a version number that has not been used yet, like `000_004`
- Put two underscores `__` after the version number
- Use `verb_target` for the name after `__`
- Keep the name lowercase
- Use underscores, not spaces
- Keep the name short, usually 2 to 4 words
- End with `.sql`

Good verbs:

```text
create
add
drop
rename
update
fix
```

Bad:

```text
V000_004__add_status_column_to_posts_table_because_we_need_to_filter_published_posts.sql
```

Good:

```text
V000_004__add_post_status.sql
```

Example `V000_004`:

```sql
ALTER TABLE posts ADD COLUMN status VARCHAR(30);
```

Then run:

```bash
docker compose run --rm migrate
```

## Stop The Containers

```bash
docker compose down
```

This stops the containers but keeps the database data.

## Reset Everything

If you want to delete the database and rerun all migrations from the start:

```bash
docker compose down -v
docker compose up -d
docker compose run --rm migrate
docker compose run --rm seed
```

Warning: `docker compose down -v` deletes the database volume and removes all saved data for this setup.
