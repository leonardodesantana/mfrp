-- This script is intended for the GUI of the login and registration step.

-- Client resolution disclaimer: when player logs in we'll get his resolution and if he's 800x600 club he'll get warned about bad GUI
local thisResource = getThisResource()
local resourceRoot = getResourceRootElement(thisResource)

addEventHandler("onClientResourceStart", root, function()
    x, y = guiGetScreenSize()
    if (x <= 800) and (y <= 600) then
        outputChatBox("AVISO: Você está utilizando a resolução de vídeo " ..x.. "x" ..y.. ". Problemas na interface gráfica podem ocorrer.")
    end
--end)
--[[ Drawing static login GUI background and centering it
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
end)]]--

-- Adding a edit box for input data
--addEventHandler("onClientResourceStart", root, function()
    editBoxW = 272
    editBoxH = 40
    loginPosX = (x-editBoxW)/2
    loginPosY = (y-editBoxH)/2
    -- Bringing the edit box from the front of the background image
    usernameInput = guiCreateEdit(loginPosX, loginPosY, editBoxW, editBoxH, "")
    guiBringToFront(usernameInput)

    passwordPosX = loginPosX
    passwordPosY = loginPosY + 80
    
    passwordInput = guiCreateEdit(passwordPosX, passwordPosY, editBoxW, editBoxH, "")
    guiBringToFront(passwordInput)
    guiEditSetMasked(passwordInput, true)

    -- Creating a sign in button
    buttonXPos = passwordPosX
    buttonYPos = passwordPosY + 55
    button = guiCreateButton(buttonXPos, buttonYPos, editBoxW, editBoxH, "Sign in", false)
--end)

addEventHandler("onClientGUIClick", button, function() 
    fedUsername = guiGetText(usernameInput)
    fedPassword = guiGetText(passwordInput)
    -- Lil debug sumthing
    outputChatBox("Login feito com suceesso. Seja bem-vindo " ..fedUsername.. "! Proteja sua senha " ..fedPassword.. ". Não aprenda pela dor anal.")
    end)
end)
