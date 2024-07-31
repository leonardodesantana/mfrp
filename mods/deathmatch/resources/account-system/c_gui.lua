-- This script is intended for the GUI of the login and registration step.

-- Client resolution disclaimer: when player logs in we'll get his resolution and if he's 800x600 club he'll get warned about bad GUI
local thisResource = getThisResource()
local resourceRoot = getResourceRootElement(thisResource)

addEventHandler("onClientResourceStart", resourceRoot, function()
    local x, y = guiGetScreenSize()
    if (x <= 800) and (y <= 600) then
        outputChatBox("AVISO: Você está utilizando a resolução de vídeo " .. x .. "x" .. y .. ". Problemas na interface gráfica podem ocorrer.")
    end
    local editBoxW = 272
    local editBoxH = 40
    local registerPosX = (x - editBoxW) / 2
    local registerPosY = (y - editBoxH) / 2

    -- Create username input box
    usernameInput = guiCreateEdit(registerPosX, registerPosY, editBoxW, editBoxH, "")
    guiBringToFront(usernameInput)

    -- Create password input box
    local passwordPosX = registerPosX
    local passwordPosY = registerPosY + 80
    passwordInput = guiCreateEdit(passwordPosX, passwordPosY, editBoxW, editBoxH, "")
    guiBringToFront(passwordInput)
    guiEditSetMasked(passwordInput, true)

    -- Show cursor
    showCursor(true)

    -- Initialize sign-in button after inputs are created
    initSignInBtn(passwordPosX, passwordPosY, editBoxW, editBoxH)
    changeAlpha()
end)
--Testing GUI get alpha
function changeAlpha()
    local alphaAmount = 0.25
    guiSetAlpha(usernameInput, alphaAmount)
    guiSetAlpha(passwordInput, alphaAmount)
end

function initSignInBtn(passwordPosX, passwordPosY, editBoxW, editBoxH)
    local buttonXPos = passwordPosX
    local buttonYPos = passwordPosY + 55
    local signInBtn = guiCreateButton(buttonXPos, buttonYPos, editBoxW, editBoxH, "Register", false)

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
-- function loginPanelLink()

