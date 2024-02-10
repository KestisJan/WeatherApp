package.path = package.path .. ';../?/init.lua;../?.lua'

local Output = require("modules.output_handling")


local InputHandling = {}


-- InputHandling:getCityInput
-- Prompts the user to enter one or more cities separated by commas.
-- Processes the input, converts spaces to URL-encoded format, and fetches weather forecasts for each city.
-- @param api: An instance of the WeatherAPI module for retrieving weather forecasts.
-- @return: A table containing the processed city names.

function InputHandling:getCityInput(api)
    print("Enter city/cities separated by commas:")
    local input = io.read()
    local cities = {}
    for city in input:gmatch("([^,]+)") do
        city = city:gsub(" ", "%%20")
        table.insert(cities, city)
    end
    
    local cityCount = #cities
    
    if cityCount > 0 then
        for _, city in ipairs(cities) do
            local forecast = api:getWeatherForecast("city", city)
            Output.printWeatherForecast(forecast, "city")
        end
    else
        print("No cities provided.")
    end

    return cities
end


-- InputHandling:getZipcodeInput
-- Prompts the user to enter one or more ZIP codes and country codes separated by commas.
-- Processes the input, extracts ZIP code and country pairs, and fetches weather forecasts for each pair.
-- @param api: An instance of the WeatherAPI module for retrieving weather forecasts.
-- @return: A table containing the processed ZIP code and country code pairs.

function InputHandling:getZipcodeInput(api)
    print("Enter ZIP code(s) and country code(s) separated by commas:")
    local input = io.read()

    local zipcodes = {}

    for zip, country in input:gmatch("([^,]+),(%u+)") do
        table.insert(zipcodes, { zip = zip, country = country })
    end

    local zipcodeCount = #zipcodes

    if zipcodeCount > 0 then
        for _, data in ipairs(zipcodes) do
            local zip = data.zip
            local country = data.country

            local forecast = api:getWeatherForecast("zipcode", zip .. "," .. country)
            Output.printWeatherForecast(forecast, 'zipcode')
        end
    else
        print("No zip & country codes provided")
    end
    
    return zipcodes
end

-- InputHandling.getCoordinatesInput
-- Prompts the user to enter latitude and longitude pairs separated by commas.
-- Processes the input, extracts latitude and longitude pairs, and fetches weather forecasts for each pair.
-- @param api: An instance of the WeatherAPI module for retrieving weather forecasts.
-- @return: A table containing the processed latitude and longitude pairs.

function InputHandling:getCoordinatesInput(api)
    print("Enter latitude and longitude(s) separated by commas:")
    local input = io.read()
    local coordinates = {}
    for lat, lon in input:gmatch("([%d%.%-]+),%s*([%d%.%-]+)") do
        table.insert(coordinates, { lat = lat, lon = lon })
    end
    
    local coordinatesCount = #coordinates
    
    if coordinatesCount > 0 then
        for _, data in ipairs(coordinates) do
            local lat = data.lat
            local lon = data.lon
            
            print("Searching for coordinates:", lat, lon)
            local forecast = api:getWeatherForecast("coordinates", lat .. "," .. lon)
            Output.printWeatherForecast(forecast, "coordinates")
        end
    else
        print("No coordinates provided.")
    end

    return coordinates
end


return InputHandling