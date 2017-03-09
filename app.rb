require 'sinatra'

get '/' do
	if params['hub.verify_token'] == ENV["VERIFY_TOKEN"]
		return params['hub.challenge']
	end

	erb :index
end

get '/privacy' do
	erb :privacy
end