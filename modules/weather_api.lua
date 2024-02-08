local http_request = require("http.request")
local json = require("cjson.safe")

local WeatherAPI = {}

-- WeatherAPI constructor
-- Creates a new instance of the WeatherAPI class with the specified configuration parameters.
-- @param config: A table containing configuration parameters.
--                - apiKey: API key for accessing the weather API.
--                - lang: Language for the weather data (optional, default is nil).
--                - format: Format for the weather data (optional, default is nil).
-- @return: A new WeatherAPI instance.
function WeatherAPI:new(config)
    local newObj = {
        apiKey = config.apiKey or nil,
        lang = config.lang or nil,
        format = config.format or nil,
        weatherApiUrl = "https://api.openweathermap.org/data/2.5/weather"
    }
    setmetatable(newObj, self)
    self.__index = self
    return newObj
end

-- WeatherAPI:getWeatherForecast
-- Retrieves the weather forecast data from the OpenWeatherMap API based on the specified option and input.
-- @param option: A string indicating the type of input (e.g., "city", "zipcode", "coordinates").
-- @param input: A string containing the input data based on the chosen option.
--               - For "city": City name.
--               - For "zipcode": Zip code and country code separated by a comma (e.g., "12345,US").
--               - For "coordinates": Latitude and longitude separated by a comma (e.g., "40.7128,-74.0060").
-- @return: A table containing the weather forecast data.

function WeatherAPI:getWeatherForecast(option, input)
    local queryString

    if option == "city" then
        queryString = string.format("?q=%s&appid=%s&lang=%s&format=%s&units=metric", input, self.apiKey, self.lang, self.format) -- Change units to imperial if you prefer to see Fahrenheit
    elseif option == "zipcode" then
        local zip, country = input:match("([^,]+),(%u+)")
        queryString = string.format("?zip=%s,%s&appid=%s&lang=%s&units=metric", zip, country, self.apiKey, self.lang) -- Change units to imperial if you prefer to see Fahrenheit
    elseif option == "coordinates" then
        local lat, lon = input:match("([%d%.%-]+),%s*([%d%.%-]+)")
        queryString = string.format("?lat=%s&lon=%s&appid=%s&lang=%s&format=%s&units=metric") -- Change units to imperial if you prefer to see Fahrenheit
    else
        error("Invalid option: ", option)
    end

    local fullUrl = self.weatherApiUrl .. queryString
    local req = http_request.new_from_uri(fullUrl)
    local headers, stream = assert(req:go())
    local body = assert(stream:get_body_as_string())

    if headers:get(":status") ~= "200" then
        error(body)
    end
    
    local result = json.decode(body)

    return result

end



return WeatherAPI