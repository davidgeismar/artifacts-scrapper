
require 'standalone_migrations'
require './artifacts_scrapper'
require 'pry-byebug'
StandaloneMigrations::Tasks.load_tasks

namespace :scrap_sources do
  desc "scraps the different sources"
  task :scrap, [:sources, :month, :year] do |task, args|
    sources = args.sources || ['christies']
    sources.each do |source|
      source.capitalize.constantize::Scrapper.new(args.month, args.year).run
    end
  end
end
