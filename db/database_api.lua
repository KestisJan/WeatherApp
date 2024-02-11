local sqlite3 = require("lsqlite3")

local DatabaseAPI = {}


--[[
    new - Creates a new instance of the DatabaseAPI.

    This constructor function initializes a new SQLite database connection based on the provided
    database file path. It returns a new object with the database connection and the specified
    table name for favorites.

    @param dbPath: A string representing the file path to the SQLite database.
    @return: A new instance of the DatabaseAPI with an open database connection.
]]
function DatabaseAPI:new(dbPath)
    local loadDatabase = sqlite3.open(dbPath)

    local newObj = {
        connection = loadDatabase,
        tableName = 'favorites'
    }

    setmetatable(newObj, self)
    self.__index = self
    
    return newObj
end

--[[
    closeConnection - Closes the SQLite database connection.

    This method closes the connection to the SQLite database associated with the DatabaseAPI instance.
    It is important to call this method to ensure proper resource cleanup after using the database.

    @return: None
]]
function DatabaseAPI:closeConnection()
    self.connection:close()
end

--[[
    createTable - Creates the 'favorites' table if it doesn't exist.

    This method executes an SQL query to create the 'favorites' table in the SQLite database.
    The table has two columns: 'id' (integer primary key) and 'city' (text).

    @return: None
]]
function DatabaseAPI:createTable()
    local query = [[
        CREATE TABLE IF NOT EXISTS favorites (
            id INTEGER PRIMARY KEY,
            city TEXT
        )
    ]]

    self.connection:exec(query)
end

-- DatabaseAPI:insertIntoTable
-- Inserts a new city into the 'favorites' table of the SQLite database.
-- @param city: The name of the city to be inserted into the database.
function DatabaseAPI:insertIntoTable(city)
    local query = string.format("INSERT INTO %s (city) VALUES ('%s')",
        self.tableName, city)
    
    self.connection:exec(query)
end

-- DatabaseAPI:viewFavorites
-- Retrieves all records from the 'favorites' table in the SQLite database.
-- @return: A table containing all rows from the 'favorites' table.
function DatabaseAPI:viewFavorites()
    local query = string.format("SELECT * FROM %s", self.tableName)
    local results = {}

    for row in self.connection:nrows(query) do
        table.insert(results, row)
    end

    return results
end


-- DatabaseAPI:deleteFromTable
-- Deletes a record from the 'favorites' table based on the provided city name.
-- @param city: The name of the city to be deleted from the 'favorites' table.
function DatabaseAPI:deleteFromTable(city)
    local query = string.format("DELETE FROM %s WHERE city = '%s'", self.tableName, city)

    self.connection:exec(query)
end

return DatabaseAPI