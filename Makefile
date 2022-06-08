rspec:
	docker-compose run --rm groundhog_test rspec
rubocop:
	docker-compose run --rm groundhog_app bundle exec rubocop
