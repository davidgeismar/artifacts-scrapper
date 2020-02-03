require './christies/christies'
require 'logger'
ActiveRecord::Base.logger = Logger.new(STDOUT)

Christies::Scrapper.new.run
