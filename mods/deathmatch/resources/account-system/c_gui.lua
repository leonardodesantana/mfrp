-- This script is intended for the GUI of the login and registration step.

-- Client resolution disclaimer: when player logs in we'll get his resolution and if he's 800x600 club he'll get warned about bad GUI
local thisResource = getThisResource()
local resourceRoot = getResourceRootElement(thisResource)

addEventHandler("onClientResourceStart", root, function()
    x, y = guiGetScreenSize()
    if (x <= 800) and (y <= 600) then
        outputChatBox("AVISO: Você está utilizando a resolução de vídeo " ..x.. "x" ..y.. ". Problemas na interface gráfica podem ocorrer.")
    end
end)

addEventHandler("onClientRender", root, function() 
    local imageWidth = 320
    local imageHeight = 322
    local posX = (x-imageWidth)/2
    local posY = (y-imageHeight)/2
    local loginBg = "bglogin.png"
    if not fileExists(loginBg) then
        outputChatBox("Error: " ..loginBg.. " not found!")
    else
    dxDrawImage(posX, posY, imageWidth, imageHeight, loginBg)
    end
end)