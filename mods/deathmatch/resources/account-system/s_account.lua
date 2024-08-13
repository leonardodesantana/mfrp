-- Database connection established.
addEventHandler("onResourceStart", resourceRoot, function()
    dbConnection = dbConnect("sqlite", "devdb") -- Using the same directory as the resource scripts
    if dbConnection then
        outputDebugString("DB connection was successful.")
        
        -- Check if 'devusers' table exists
        local query = dbQuery(dbConnection, "SELECT name FROM sqlite_master WHERE type='table' AND name='devusers';")
        local result = dbPoll(query, -1)
        if result and #result > 0 then
            outputDebugString("Table 'devusers' exists.")
        else
            outputDebugString("Table 'devusers' does not exist. Creating table now.")
            
            -- Create the table if it doesn't exist
            local createTableQuery = [[
                CREATE TABLE IF NOT EXISTS devusers (
                    username VARCHAR(30) NOT NULL,
                    password VARCHAR(60) NOT NULL
                );
            ]]
            local createResult = dbExec(dbConnection, createTableQuery)
            if createResult then
                outputDebugString("Table 'devusers' created successfully.")
            else
                outputDebugString("Failed to create table 'devusers'.")
            end
        end
    else
        outputDebugString("DB connection failed.")
    end
end)

-- Function to insert user data into the database
function insertUserData(username, password)

    local hashedPassword = passwordHash(password, "bcrypt", {})
    if dbConnection then
        local query = dbExec(dbConnection, "INSERT INTO devusers(username, password) VALUES(?, ?)", username, hashedPassword)
    end
    
    hashedPassword = nil
    query = nil
end
addEvent("onUserDataReceived", true)
addEventHandler("onUserDataReceived", resourceRoot, insertUserData)
