package.path = package.path .. ';../?/init.lua;../?.lua'
local env = require('utils.env_utils')

local filePath = "../.env"
-- Attempt to execute the env.readEnvFile function in a protected call
local success, envValues = pcall(env.readEnvFile, filePath)


if not success then
    print("Error reading environment file:", envValues)
    envValues = {}
end


return {
    apiKey = envValues.WEATHER_API_KEY,
    lang = envValues.WEATHER_LANG,
    format = envValues.WEATHER_MODE
}
