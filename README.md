## FOR LOCAL DEV WITHOUT DOCKER
rake db:create db:migrate
bundle exec sidekiq -r ./artifacts_scrapper.rb
ruby scrap_sources.rb

## FOR LOCAL DEV WITH DOCKER
rake db:create db:migrate
builds and run docker image
docker-compose up --build
run console into container
docker exec -it ec2-user_scrapper_1 /bin/bash
bundle exec sidekiq -r ./artifacts_scrapper.rb
ruby scrap_sources.rb
