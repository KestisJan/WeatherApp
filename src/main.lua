package.path = package.path .. ';../?/init.lua;../?.lua'

local config = require("config.config")

local WeatherAPI = require("modules.weather_api")
local DatabaseAPI = require("db.database_api")

local InputHandling = require("modules.input_handling")
local DatabaseHandling = require("modules.database_handling")

local dbPath = "../db/weather.db"

local api = WeatherAPI:new(config)
local db = DatabaseAPI:new(dbPath)
local inputHandler = InputHandling
local databaseHandler = DatabaseHandling

function displayMainMenu()
    print("\nMain Menu:")
    print("1. Get weather forecast by city name")
    print("2. Get weather forecast by zipcode")
    print("3. Get weather forecast by coordinates")
    print("4. View favorite cities weather forecasts")
    print("5. Add a new city to favorites")
    print("6. Delete a city from favorites")
    print("7. Exit")
end

local options = {
    -- Option 1: Get weather forecast by city name
    -- Calls the getCityInput function from the InputHandling module,
    -- passing the inputHandler object and the api object as arguments.
    [1] = function()
        local success, result = pcall(inputHandler.getCityInput, inputHandler, api)
        if not success then
            print("Error:", result)
        end
    end,
    -- Option 2: Get weather forecast by ZIP code
    -- Calls the getZipcodeInput function from the InputHandling module,
    -- passing the inputHandler object and the api object as arguments.
    [2] = function()
        local success, result = pcall(inputHandler.getZipcodeInput, inputHandler, api)
        if not success then
            print("Error:", result)
        end
    end,
    -- Option 3: Get weather forecast by coordinates
    -- Calls the getCoordinatesInput function from the InputHandling module,
    -- passing the inputHandler object and the api object as arguments.
    [3] = function()
        local success, result = pcall(inputHandler.getCoordinatesInput, inputHandler, api)
        if not success then
            print("Error:", result)
        end
    end,
--[[
    Option 4: Viewing favorite cities weather forecasts
    This option prints a message indicating that the user is viewing weather forecasts for favorite cities.
    It then calls the viewFavoriteWeather function from the databaseHandler, passing the api and db as arguments.
    If an error occurs during the execution, it prints an error message.
    @param databaseHandler: The module handling database operations.
    @param api: An instance of the WeatherAPI for fetching weather forecasts.
    @param db: An instance of the DatabaseAPI for interacting with the SQLite database.
]]
    [4] = function()
        print("Viewing favorite cities weather forecasts")
        local success, errorMessage = pcall(databaseHandler.viewFavoriteWeather, databaseHandler, api, db)
        if not success then
            print("Error:", errorMessage)
        end
    end,
--[[
    Option 5: Adding a new city to favorites
    This option prompts the user to enter one or more cities separated by commas.
    It validates the city names, adds them to the favorites in the database, and prints the results.
    @param databaseHandler: The module handling database operations.
    @param db: An instance of the DatabaseAPI for interacting with the SQLite database.
]]
    [5] = function()
        print("Adding a new city to favorites")
        local success, errorMessage = pcall(databaseHandler.addFavoriteCity, databaseHandler, db)
        if not success then
            print("Error:", errorMessage)
        end
    end,
--[[
    Option 6: Deleting a city from the favorites list
    This option prints a message indicating that the user is deleting a city from the favorites list.
    It then calls the deleteFavoriteCity function from the databaseHandler, passing the db as an argument.
    If an error occurs during the execution, it prints an error message.
    @param databaseHandler: The module handling database operations.
    @param db: An instance of the DatabaseAPI for interacting with the SQLite database.
]]
    [6] = function()
        print("Delete a city from favorites list")
        local success, errorMessage = pcall(databaseHandler.deleteFavoriteCity, databaseHandler, db)
        if not success then
            print("Error:", errorMessage)
        end
    end,
    [7] = function()
        print("Exiting the program. Goodbye!")
        os.exit()
    end,
}

while true do
    displayMainMenu()
    print("Enter your choice:")
    local choice = tonumber(io.read())

    local selectedOption = options[choice]
    if selectedOption then
        selectedOption()
    else
        print("Invalid option. Please choose a valid option.")
    end
end