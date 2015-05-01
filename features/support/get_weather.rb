require 'open-uri'
require 'json'
# require 'ruby-debug'

def get_weather_from_web_application( weather_to_get )
	weather_file = open("http://api.wunderground.com/api/#{$runtime_config['weather_underground_api_key']}/#{weather_to_get}.json")
	weather = weather_file.read
	weather_file.close
	File.open("cache/#{weather_to_get.gsub('/','.')}.json", 'w') {|f| f.write(weather) }
	return weather
end

def get_weather_from_cache( weather_to_get )
	begin
		filename = "cache/#{weather_to_get.gsub('/','.')}.json"
		if Time.now() - File.stat(filename).mtime < $runtime_config['cache_time_in_minutes']*60
			weather_file = open(filename)
			weather = weather_file.read
		end
	rescue
	ensure
		weather_file.close unless weather_file.nil?
	end
	return weather
end

def get_weather( weather_to_get )
	weather = get_weather_from_cache(weather_to_get)
	weather = get_weather_from_web_application(weather_to_get) if weather.nil?
	JSON.parse(weather)
end
