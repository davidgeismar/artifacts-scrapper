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
 Traceback (most recent call last):
	19: from scrap_sources.rb:3:in `<main>'
	18: from /usr/src/artifacts_scrapper/christies/scrapper.rb:13:in `run'
	17: from /usr/src/artifacts_scrapper/christies/scrapper.rb:13:in `each'
	16: from /usr/src/artifacts_scrapper/christies/scrapper.rb:14:in `block in run'
	15: from /usr/src/artifacts_scrapper/christies/scrapper.rb:14:in `each'
	14: from /usr/src/artifacts_scrapper/christies/scrapper.rb:15:in `block (2 levels) in run'
	13: from /usr/src/artifacts_scrapper/christies/scrapper.rb:23:in `extract_sales'
	12: from /usr/src/artifacts_scrapper/christies/scrapper.rb:23:in `each'
	11: from /usr/src/artifacts_scrapper/christies/scrapper.rb:24:in `block in extract_sales'
	10: from /usr/src/artifacts_scrapper/christies/scrapper.rb:31:in `extract_lots'
	 9: from /usr/src/artifacts_scrapper/christies/scrapper.rb:31:in `each'
	 8: from /usr/src/artifacts_scrapper/christies/scrapper.rb:31:in `block in extract_lots'
	 7: from /usr/src/artifacts_scrapper/christies/scrapper.rb:36:in `extract_lot'
	 6: from /usr/local/bundle/gems/activerecord-5.2.4.1/lib/active_record/persistence.rb:35:in `create'
	 5: from /usr/local/bundle/gems/activerecord-5.2.4.1/lib/active_record/inheritance.rb:66:in `new'
	 4: from /usr/local/bundle/gems/activerecord-5.2.4.1/lib/active_record/inheritance.rb:66:in `new'
	 3: from /usr/local/bundle/gems/activerecord-5.2.4.1/lib/active_record/core.rb:315:in `initialize'
	 2: from /usr/local/bundle/gems/activemodel-5.2.4.1/lib/active_model/attribute_assignment.rb:35:in `assign_attributes'
	 1: from /usr/local/bundle/gems/activerecord-5.2.4.1/lib/active_record/attribute_assignment.rb:16:in `_assign_attributes'
/usr/local/bundle/gems/activerecord-5.2.4.1/lib/active_record/attribute_assignment.rb:16:in `each': ret: 2, hash modified during iteration (RuntimeError)
