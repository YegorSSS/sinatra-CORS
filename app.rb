require "sinatra"
require 'json'

set :port, 5000

get "/" do
	erb :home
end

