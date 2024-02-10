-- OutputHandling.printWeatherForecast
-- Prints the weather forecast details based on the forecast data and the selected input option.
-- @param forecast: A table containing weather forecast data retrieved from the WeatherAPI module.
-- @param option: A string indicating the type of input (e.g., "city", "zipcode", "coordinates").

local OutputHandling = {}

function OutputHandling.printWeatherForecast(forecast, option)
    print()
    
    if option == "zipcode" or option == "city" then
        print("City: " .. (forecast.name or "N/A"))
    end

    if option == "coordinates" then
        print("Country: " .. (forecast.sys and forecast.sys.country or "N/A"))
        print("City: " .. (forecast.name or "N/A"))
    end

    print("Weather Forecast:")
    print("Temperature: " .. (forecast.main and forecast.main.temp or "N/A"))
    print("Description: " .. (forecast.weather and forecast.weather[1] and forecast.weather[1].description or "N/A"))
    print("Humidity: " .. (forecast.main and forecast.main.humidity or "N/A"))
    print("Wind Speed: " .. (forecast.wind and forecast.wind.speed or "N/A"))

    print()
end

return OutputHandling