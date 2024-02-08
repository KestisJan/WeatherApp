-- Function to read an environment file and extract key-value pairs
-- 1. This function reads the contents of an environment file, typically in the format "KEY=VALUE" per line.
--    It extracts each key-value pair and stores them in a Lua table, returning the table.
-- 2. @param path: The path to the environment file that needs to be read.
--    It is a string representing the file path.
local env = {}

function env.readEnvFile(filePath)
    local envFile = io.open(filePath, "r")
    local envData = {}

    if envFile then
        for line in envFile:lines() do
            local key, value = line:match("([^=]+)=(.*)")
            if key and value then
                envData[key] = value
            end
        end
        envFile:close()
    end

    return envData
end


return env
  