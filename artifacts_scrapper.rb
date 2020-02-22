require 'sidekiq'
require './config/sidekiq'
require './christies/christies'
require 'logger'
require 'yaml'
require 'dotenv'
require 'erb'

Dotenv.load
