-- Database connection established.
addEventHandler("onResourceStart", root, function()
    dbConnection = dbConnect("sqlite",":/db/mfrp.db")
    if dbConnection then
        outputDebugString("DB connection was successful.")
    else
        outputDebugString("DB connection failed.")
    end
end)

