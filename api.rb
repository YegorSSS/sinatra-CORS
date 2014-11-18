require "sinatra"
require 'mongoid'
require 'json'

configure do
  Mongoid.load!("mongoid.yml")
end

class Weather
	include Mongoid::Document
	field :date, type: Date
	field :temp, type: String
end

set :port, 3000

get "/" do
	@s = Weather.all
	erb :api_home
end

get "/remove_base" do
	Weather.all.delete
	redirect "/"
end


get "/todays_weather.json" do
	response['Access-Control-Allow-Origin'] = '*'

	if Weather.all.count == 0
		Weather.create(date: Time.now, temp: "-3")
		Weather.create(date: Time.now + 86400, temp: "+10")
		Weather.create(date: Time.now + 86400 * 2, temp: "+13")
		Weather.create(date: Time.now + 86400 * 3, temp: "+15")
		Weather.create(date: Time.now + 86400 * 4, temp: "+20")
		Weather.create(date: Time.now + 86400 * 5, temp: "+25")
		Weather.create(date: Time.now + 86400 * 6, temp: "+30")
	end
	
	Weather.where(date: Time.now).to_json
end
