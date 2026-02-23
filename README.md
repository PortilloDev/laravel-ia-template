# Laravel + AI + Postgres + Docker

Laravel 12 template with Inertia (React), AI tooling, PostgreSQL (with pgvector), and Docker. Use Make and environment variables to run the app and database with configurable ports.

## Requirements

- Docker and Docker Compose
- Make

## Quick start

1. Copy the Docker env file and set your database credentials and ports (optional):

   ```bash
   cp .env.docker .env
   # Edit .env: DB_*, APP_PORT, DB_HOST_PORT if needed
   ```

2. Start the stack with Make (uses `.env.docker` by default):

   ```bash
   make up
   ```

   The app is served at **http://localhost:8085** and Postgres at **localhost:5434** by default.

3. Run migrations and seed (inside the app container):

   ```bash
   make artisan cmd="migrate --force"
   make artisan cmd="db:seed"
   ```

## Environment variables (Make & Docker Compose)

These variables control ports and database settings. Define them in `.env.docker` (or in `.env` and pass `ENV_FILE=.env` to Make).

| Variable       | Default | Description                          |
|----------------|---------|--------------------------------------|
| `APP_PORT`     | 8085    | Host port for the web app (nginx)    |
| `DB_HOST_PORT` | 5434    | Host port for PostgreSQL             |
| `DB_PORT`      | 5432    | Port used by the app to talk to Postgres (inside Docker) |
| `DB_HOST`      | postgres| Database host (service name in Docker) |
| `DB_DATABASE`  | -       | Database name                        |
| `DB_USERNAME`  | -       | Database user                        |
| `DB_PASSWORD`  | -       | Database password                    |

Override from the shell when running Make:

```bash
APP_PORT=9090 DB_HOST_PORT=5435 make up
```

Or use a different env file:

```bash
make up ENV_FILE=.env
```

## Make targets

| Target       | Description                              |
|-------------|------------------------------------------|
| `make up`   | Start app, Postgres, and nginx (detached) |
| `make down` | Stop and remove containers               |
| `make restart` | down + up                            |
| `make logs` | Follow container logs                    |
| `make ps`   | List running services                    |
| `make build`| Rebuild images                           |
| `make app-shell` | Open a shell in the app container   |
| `make artisan cmd="..."` | Run Artisan in the app container (e.g. `cmd="migrate"`) |
| `make db-shell` | Open psql in the Postgres container  |

## Docker Compose

`docker-compose.yml` uses the same variables for ports and database:

- **App (nginx):** `$(APP_PORT):80` (default 8085:80)
- **Postgres:** `$(DB_HOST_PORT):5432` (default 5434:5432)

So you can run Compose directly with an env file:

```bash
docker compose --env-file .env.docker up -d
```

## Local development (without Docker)

Use `.env` with SQLite or a local Postgres. Run:

```bash
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
npm install && npm run dev
composer run dev
```

## Stack

- **Laravel** 12
- **Inertia.js** (React) + Vite
- **PostgreSQL** 16 with **pgvector**
- **PHP** 8.3 (in Docker)
- **Nginx** (in Docker)

## License

MIT
