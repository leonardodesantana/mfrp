-- This script is intended for the GUI of the login and registration step.

-- Client resolution disclaimer: when player logs in we'll get his resolution and if he's 800x600 club he'll get warned about bad GUI
local thisResource = getThisResource()
local resourceRoot = getResourceRootElement(thisResource)

addEventHandler("onClientResourceStart", root, function()
    local x, y = guiGetScreenSize()
    if (x <= 800) and (y <= 600) then
        outputChatBox("AVISO: Você está utilizando a resolução de vídeo " ..x.. "x" ..y.. ". Problemas na interface gráfica podem ocorrer.")
    end
end)
-- Create window for login/registration GUI.

addEventHandler("onClientPlayerJoin", root, function()
    -- Define the size and position of the window as fractions of the screen size
    local windowWidth, windowHeight = 0.4, 0.4 -- 40% of screen width and height
    local windowX, windowY = (1 - windowWidth) / 2, (1 - windowHeight) / 2 -- Center the window

    -- Create the window
    local window = guiCreateWindow(windowX, windowY, windowWidth, windowHeight, "Login and Registration", true)
end)

