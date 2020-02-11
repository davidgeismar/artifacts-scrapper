## FOR LOCAL DEV WITHOUT DOCKER
rake db:create db:migrate
bundle exec sidekiq -r ./artifacts_scrapper.rb
ruby scrap_sources.rb

## FOR LOCAL DEV WITH DOCKER
rake db:create db:migrate
builds and run docker image
docker-compose up  -d --build
run console into container
docker exec -it scrapper_1 /bin/bash
bundle exec sidekiq -r ./artifacts_scrapper.rb
ruby scrap_sources.rb
docker container kill $(docker ps -q)

## FOR PROD WITH DOCKER
rake db:create db:migrate
builds and run docker image
docker compose pull && docker-compose up  -d --build
run console into container
docker exec -it scrapper_1 /bin/bash
bundle exec sidekiq -r ./artifacts_scrapper.rb
ruby scrap_sources.rb
docker container kill $(docker ps -q)

 ## DB
 DB is located in VPC vpc-35c6b85d
 in security group sg-40137c20
 in order for ec2 to connect to the db you must allow EC2 IP in the security group

 ## EC2
 is located in VPC vpc-35c6b85d
