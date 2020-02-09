require 'sidekiq'
require './config/sidekiq'
require './christies/christies'
require 'logger'
require 'yaml'
require 'dotenv'
require 'erb'


template = ERB.new File.new("./db/config.yml.erb").read
info = YAML::load template.result(binding)
ActiveRecord::Base.establish_connection(info[ENV["ARTIFACTS_ENV"]])
ActiveRecord::Base.logger = Logger.new(STDOUT)
