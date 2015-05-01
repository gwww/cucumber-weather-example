Given /^I am authorized to use the Weather Underground API$/ do
end

When /^I search for "(.*?)" weather$/ do |location|
    @weather = get_weather( "geolookup/conditions/q/#{location}")
end

Then /^I should see a list of (\d+) locations$/ do |number_locations|
    expect(@weather['response']['results'].length).to eq(number_locations.to_i)
end

Then /^I should see the current weather observation$/ do
    expect(@weather['current_observation'].length).to be > 0
    expect(@weather['current_observation']['display_location']['city']).to eq('Ottawa')
end

When /^I search for "(.*?)" weather for date (\d+)$/ do |location, date|
    @weather = get_weather( "history_#{date}/q/#{location}")
end

Then /^I should see the temperature (\-?\d+)$/ do |temperature|
    expect(@weather['history']['dailysummary'][0]['mintempi']).to eq(temperature)
end

Then /^I should get the error "(.*?)"$/ do |error_msg|
    expect(@weather['response']['error']['type']).to eq(error_msg)
end
