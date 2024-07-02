-- Database connection established.
addEventHandler("onResourceStart", root, function()
    dbConnection = dbConnect("sqlite",":/db/mfrp.db")
end)