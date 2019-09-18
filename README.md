# README

Prepare postgresql (first run)

```
docker run -d -p 5432:5432 -e POSTGRES_USER=app --name db postgres:9.6
```

Next time use: `docker start db`

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...
