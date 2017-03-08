require 'dotenv/load'
require 'facebook/messenger'
require './app'
require './bot'

map("/webhook") do
	run Sinatra::Application
	run Facebook::Messenger::Server
end

run Sinatra::Application