require 'sidekiq'
require './config/sidekiq'
require './christies/christies'
require 'logger'
require 'yaml'
require 'dotenv'


Dotenv.load
binding.pry
info = YAML::load(IO.read("./db/config.yml"))
ActiveRecord::Base.establish_connection(info[ENV["ARTIFACTS_ENV"]])
ActiveRecord::Base.logger = Logger.new(STDOUT)
