
require './artifacts_scrapper'
require 'pry-byebug'

namespace :scrap_sources do
  desc "scraps the different sources"
  task :scrap, [:sources, :month, :year] do |task, args|
    sources = eval(args.sources) || ['christies']
    sources.each do |source|
      source.capitalize.constantize::Scrapper.new(args.month, args.year).run
    end
  end
end
