app-install:
	gem install bundler
	bundle && yarn
	docker run -d -p 5432:5432 -e POSTGRES_USER=app --name db postgres:9.6
	make db-setup
	bin/rails c

db-setup:
	bin/rails db:create db:migrate db:fixtures:load

db-reset:
	bin/rails db:drop db:create db:migrate db:fixtures:load

server:
	bin/rails s

run:
	docker start db
	bin/rails c

lint:
	bundle exec rubocop

fix:
	bundle exec rubocop --auto-correct

test:
	bin/rake db:test:prepare
	bin/rails test -d

.PHONY: test
