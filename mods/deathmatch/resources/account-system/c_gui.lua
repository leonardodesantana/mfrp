-- This script is intended for the GUI of the login and registration step.

-- Client resolution disclaimer: when player logs in we'll get his resolution and if he's 800x600 club he'll get warned about bad GUI
local thisResource = getThisResource()
local resourceRoot = getResourceRootElement(thisResource)

addEventHandler("onClientResourceStart", resourceRoot, function()
    local x, y = guiGetScreenSize()
    if (x <= 800) and (y <= 600) then
        outputChatBox("AVISO: Você está utilizando a resolução de vídeo " .. x .. "x" .. y .. ". Problemas na interface gráfica podem ocorrer.")
    end
    local registerEditBoxWidth = 272
    local registerEditBoxHeight = 40
    local registerPosX = (x - registerEditBoxWidth) / 2
    local registerPosY = (y - registerEditBoxHeight) / 2
    -- Copying edit boxes position cause why not
    loginPosX = registerPosX
    loginPosY = registerPosY
    loginEditBoxWidth = registerEditBoxHeight
    loginEditBoxHeight = registerEditBoxHeight
    -- Create username input box
    usernameInput = guiCreateEdit(registerPosX, registerPosY, registerEditBoxWidth, registerEditBoxHeight, "")
    guiBringToFront(usernameInput)

    -- Create password input box
    passwordPosX = registerPosX
    passwordPosY = registerPosY + 80
    passwordInput = guiCreateEdit(passwordPosX, passwordPosY, registerEditBoxWidth, registerEditBoxHeight, "")
    guiBringToFront(passwordInput)
    guiEditSetMasked(passwordInput, true)

    -- Show cursor
    showCursor(true)

    -- Initialize sign-in button after inputs are created
    initSignInBtn(passwordPosX, passwordPosY, registerEditBoxWidth, registerEditBoxHeight)
    changeAlpha()
    loginPanelLink()
end)
--Testing GUI get alpha
function changeAlpha()
    local alphaAmount = 0.25
    guiSetAlpha(usernameInput, alphaAmount)
    guiSetAlpha(passwordInput, alphaAmount)
end

function initSignInBtn(passwordPosX, passwordPosY, registerEditBoxWidth, registerEditBoxHeight)
    buttonXPos = passwordPosX
    buttonYPos = passwordPosY + 55
    signInBtn = guiCreateButton(buttonXPos, buttonYPos, registerEditBoxWidth, registerEditBoxHeight, "Register", false)

    -- Add event handler for sign-in button
    addEventHandler("onClientGUIClick", signInBtn, getEditBoxString, false)
    outputChatBox("Sign-in button initialized at (" .. buttonXPos .. ", " .. buttonYPos .. ")")
end

-- Debug strings input by the user
function getEditBoxString()
    local fedUsername = guiGetText(usernameInput)
    local fedPassword = guiGetText(passwordInput)
    local hashedPassword = passwordHash(fedPassword, "bcrypt", {})
    --local hashedPasswordLen = string.len(hashedPassword)

    if fedUsername and fedPassword then
        -- Send user data to the server
        triggerServerEvent("onUserDataReceived", resourceRoot, fedUsername, hashedPassword)
        outputChatBox("Obrigado por se registrar no MFRP, divirta-se muito e reclame muito pouco!")
        destroyElement(guiRoot)
        showCursor(false)
    else
        outputChatBox("Error: Failed to retrieve input values.")
    end
end
-- Adding text label so user can jump to login panel window
function loginPanelLink()
    loginLabelXPos = buttonXPos + 52
    loginLabelYPos = buttonYPos + 54
    loginLabel = guiCreateLabel(loginLabelXPos, loginLabelYPos, 1000, 100, "Já possui uma conta? Faça login.", false)

    -- Creating a button so the user can actually click it and then jump to login panel
    alreadyRegisteredBtn = guiCreateButton(loginLabelXPos - 16, loginLabelYPos, 200,18,"", false)
    guiMoveToBack(alreadyRegisteredBtn)
    guiSetAlpha(alreadyRegisteredBtn, 0)
    guiBringToFront(alreadyRegisteredBtn)
    addEventHandler("onClientGUIClick", alreadyRegisteredBtn, function()
        outputChatBox("Insira seu login e senha para jogar no MFRP!")
        destroyElement(guiRoot)
        initLoginPageGui()
    end, false)
end
-- Creating username GUI
function initLoginPageGui()
    loginPageGui = {}

    loginPageGui["usernameField"] = guiCreateEdit(loginPosX, loginPosY, 272, 40, "")
    loginPageGui["passwordField"] = guiCreateEdit(passwordPosX, passwordPosY, 272, 40, "")
    loginPageGui["loginBtn"] = guiCreateButton(buttonXPos, buttonYPos, 272, 40, "Login")
    showCursor(true)
end