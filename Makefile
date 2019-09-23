app-install:
	gem install bundler
	bundle install
	docker run -d -p 5432:5432 -e POSTGRES_USER=app --name db postgres:9.6
	sleep 5
	bin/rails db:create db:migrate db:fixtures:load
	bin/rails c

db-reset:
	bin/rails db:drop db:create db:migrate db:fixtures:load

run:
	docker start db
	bin/rails c

lint:
	bundle exec rubocop

fix:
	bundle exec rubocop --auto-correct

.PHONY: test
