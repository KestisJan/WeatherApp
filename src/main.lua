package.path = package.path .. ';../?/init.lua;../?.lua'


local config = require("config.config")
local WeatherAPI = require("modules.weather_api")
local InputHandling = require("modules.input_handling")

local api = WeatherAPI:new(config)
local inputHandler = InputHandling

function displayMainMenu()
    print("Main Menu:")
    print("1. Get weather forecast by city name")
    print("2. Get weather forecast by zipcode")
    print("3. Get weather forecast by coordinates")
    print("4. Exit")
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
    [4] = function()
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