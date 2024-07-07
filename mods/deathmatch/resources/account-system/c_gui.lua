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
addCommandHandler("registrar", function(source)
    outputChatBox("Informe seu usuário: ")
    
    local function onUsernameInput(text)
        username = text
        if type(username) == "string" and #username <= 30 and not tonumber(username) then
            outputChatBox("Seu usuário " .. username .. " foi registrado! Você usará esse usuário para seu login. Agora vamos criar sua senha.")
            removeEventHandler("onClientChatMessage", root, onUsernameInput)
            
            outputChatBox("DICA: use letras, números e símbolos para uma senha segura. A senha deve ter pelo menos 8 caracteres.")
            addEventHandler("onClientChatMessage", root, onPasswordInput)
        else
            outputChatBox("ERRO: Seu usuário deve ser composto por alguma letra, não apenas números.")
        end
    end

    local function onPasswordInput(text)
        password = text
        if type(password) == "string" and #password >= 8 then
            outputChatBox("Sua senha foi registrada!")
            removeEventHandler("onClientChatMessage", root, onPasswordInput)
            
            outputChatBox("Informe seu e-mail: ")
            addEventHandler("onClientChatMessage", root, onEmailInput)
        else
            outputChatBox("Escolha uma senha mais forte, sua senha não atende aos requisitos.")
        end
    end

    local function onEmailInput(text)
        useremail = text
        if type(useremail) == "string" then
            outputChatBox("Seu registro foi concluído, aproveite o MFRP!")
            removeEventHandler("onClientChatMessage", root, onEmailInput)
        else
            outputChatBox("ERRO: informe um e-mail válido!")
        end
    end
    
    -- Hashing the password for further storage on server
    local function onAccountCreationHashPassword()
        hashedPassword = passwordHash(password, "bcrypt", {})
    end

    -- Gathering metadata about account creation
    local function onAccountCreationMetadata()
        hwSerial = getPlayerSerial()
    end
    local function onAccountCreationGetTimestamp()
        return os.date("%Y-%m-%d %H:%M:%S")
    end
    local timestamp = onAccountCreationGetTimestamp()
    addEventHandler("onClientChatMessage", root, onUsernameInput)
end, false)