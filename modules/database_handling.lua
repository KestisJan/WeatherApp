package.path = package.path .. ';../?/init.lua;../?.lua'
local url = require("socket.url")

local DatabaseAPI = require("db.database_api")
local Output = require("modules.output_handling")

local DatabaseHandling = {}

--[[
    View Favorite Cities Weather Forecasts
    This function displays a list of favorite cities, prompting the user to choose a city by entering the corresponding number.
    It then fetches the weather forecast for the selected city using the WeatherAPI module and prints the results.
    @param api: An instance of the WeatherAPI module for fetching weather forecasts.
    @param db: An instance of the DatabaseAPI for interacting with the SQLite database.
]]

function DatabaseHandling:viewFavoriteWeather(api, db)
    print("Favorite Cities Weather Forecasts:")
    local favoriteList = db:viewFavorites()

    for i, city in ipairs(favoriteList) do
        print(i .. ". " .. city.city)
    end

    print("Choose a city to check its weather (enter the number):")
    local choice = tonumber(io.read())

    if choice and choice >= 1 and choice <= #favoriteList then
        local selectedCity = favoriteList[choice]
        local formattedCity = url.escape(selectedCity.city)
        local forecast = api:getWeatherForecast("city", formattedCity)
        Output:printWeatherForecast(forecast, "city")
        
    else
        print("Invalid choice. Please enter a valid number.")
    end
end



--[[
    addFavoriteCity - Adds cities to the favorites list in the database.

    This function prompts the user to enter one or more cities separated by commas.
    It validates the city names and adds them to the favorites in the specified database.
    The function prints the added cities and a success message.

    @param db: An instance of the DatabaseAPI for interacting with the SQLite database.
]]
function DatabaseHandling:addFavoriteCity(db)
    db:createTable()

    print("Enter city/cities separated by commas:")
    local input = io.read()

    local cities = {}
    for city in input:gmatch("([^,]+)") do
        if city:match("^[a-zA-Z%s]+$") then
            table.insert(cities, city)
        else
            print("Invalid city name:", city)
        end
    end

    if #cities > 0 then
        print("\nAdding cities to favorites: " .. table.concat(cities, ", "))
        for _, city in ipairs(cities) do
            db:insertIntoTable(city)
        end
        print("\nSuccessfully added to your favorite list: " .. table.concat(cities, ", "))

    else
        print("No valid cities provided.")
    end

end

--[[
    Delete Favorite City
    This function displays the current list of favorite cities, prompts the user to choose a city by entering the corresponding number,
    and asks for confirmation before deleting the selected city from favorites.
    @param db: An instance of the DatabaseAPI for interacting with the SQLite database.
]]

function DatabaseHandling:deleteFavoriteCity(db)
    print("\nCurrent favorite cities:")
    local favoriteList = db:viewFavorites()

    for i, city in ipairs(favoriteList) do
        print(i .. ", " .. city.city)
    end

    print("Enter the number of the city to delete from favorites:")
    local choice = tonumber(io.read())

    if choice and choice >= 1 and choice <= #favoriteList then
        local selectedCity = favoriteList[choice]

        print("\nAre you sure you want to delete '" .. selectedCity.city .. "' from favorites? (yes/no):")
        local confirmation = io.read()

        if confirmation:lower() == "yes" then
            db:deleteFromTable(selectedCity.city)
            print("\nCity deleted from favorites!")
        else
            print("\nDeletion canceled.")
        end
    else
        print("\nInvalid choice. Please enter a valid number.")
    end
end


return DatabaseHandling

