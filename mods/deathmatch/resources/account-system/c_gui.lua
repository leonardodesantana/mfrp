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
-- Drawing static login GUI background and centering it
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

-- Adding a edit box for input data
addEventHandler("onClientResourceStart", root, function()
    local editBoxW = 272
    local editBoxH = 40
    local posX = (x-editBoxW)/2
    local posY = (y-editBoxH)/2
    -- Bringing the edit box from the front of the background image
    local usernameInput = guiCreateEdit(posX, posY, editBoxW, editBoxH, "Usuário")
    guiBringToFront(usernameInput)
end)