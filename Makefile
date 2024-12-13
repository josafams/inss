docker-shell::
	docker-compose run rails bash

docker-build:
	docker-compose build --no-cache

docker-run:
	docker-compose up

docker-tests:
	docker-compose run --rm rails rspec

docker-rubocop:
	docker-compose run --rm rails rubocop -A
