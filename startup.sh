bundle exec sidekiq -r ./artifacts_scrapper.rb 2>&1 | tee ./log/sidekiq.log
ruby scrap_sources.rb
