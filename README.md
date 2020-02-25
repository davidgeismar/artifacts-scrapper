## FOR LOCAL DEV WITHOUT DOCKER
rake db:create db:migrate
bundle exec sidekiq -r ./artifacts_scrapper.rb 2>&1 | tee ./log/sidekiq.log
bundle exec sidekiq -r ./artifacts_scrapper.rb
ruby scrap_sources.rb

## FOR LOCAL DEV WITH DOCKER
rake db:create db:migrate
builds and run docker image
docker-compose up  -d --build
run console into container
docker exec -it scrapper_1 /bin/bash
bundle exec sidekiq -r ./artifacts_scrapper.rb
bundle exec sidekiq -r ./artifacts_scrapper.rb 2>&1 | tee ./log/sidekiq.log
ruby scrap_sources.rb
docker container kill $(docker ps -q)

## FOR PROD WITH DOCKER
rake db:create db:migrate
builds and run docker image
docker-compose pull && docker-compose up --build
docker-compose pull && docker-compose up  -d --build
run console into container
docker exec -it ec2-user_scrapper_1 /bin/bash
bundle exec sidekiq -r ./artifacts_scrapper.rb
ruby scrap_sources.rb
docker container kill $(docker ps -q)

 ## DB
 DB is located in VPC vpc-35c6b85d
 in security group sg-40137c20
 in order for ec2 to connect to the db you must allow EC2 IP in the security group
 bundle exec rake db:drop RAILS_ENV=production
 bundle exec rake db:create RAILS_ENV=production
 bundle exec rake db:migrate RAILS_ENV=production
 bundle exec rake db:drop db:create db:migrate RAILS_ENV=production
 ## EC2
 is located in VPC vpc-35c6b85d


## README
redis-cli FLUSHALL
=> get read of all jobs

 bundle exec rake scrap_sources:scrap"[[christies],2,3]"
