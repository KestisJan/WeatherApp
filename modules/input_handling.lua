package.path = package.path .. ';../?/init.lua;../?.lua'

local WeaterAPI = require("modules.weather_api")

local InputHandling = {}

function InputHandling:getCityInput(api)
    print("Enter city/cities separated by commas:")
    local input = io.read()

    local cities = {}
    for city in input:gmatch("([^,]+)") do
        city = city:gsub(" ", "%%20")