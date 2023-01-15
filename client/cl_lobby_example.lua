local Blash = exports['blash-core']:GetObject()

RegisterNetEvent('lobbymenu:OpenMainMenu', function() TriggerEvent('lobbymenu:OpenMenu', 'critMenu.ExampleMenu', true) end)

local function addDetails()
    TriggerEvent('lobbymenu:SetTextBoxToColumn', 'critMenu.ExampleMenu', 1, Config.Menus.main_menu.welcome.header, Config.Menus.main_menu.welcome.message, "Blash by boppe.")
    TriggerEvent('lobbymenu:ResetDetailsRowList', 'critMenu.ExampleMenu')

    for _, v in pairs(Config.Menus.main_menu.information) do
        TriggerEvent('lobbymenu:AddDetailsRow', 'critMenu.ExampleMenu', v.header, v.message)
    end

    TriggerEvent('lobbymenu:UpdateMenu', 'critMenu.ExampleMenu')
end

local function addButtons()
    TriggerEvent('lobbymenu:AddButton', 'critMenu.ExampleMenu', {text = "Showing button 1"}, "View Active Lobbies", "", false, 0, "lobby.viewLobbies")
    TriggerEvent('lobbymenu:AddButton', 'critMenu.ExampleMenu', {text = "Showing button 2"}, "View Statistics", "", false, 0, "lobby.AddDetailsToMenu")
    TriggerEvent('lobbymenu:AddButton', 'critMenu.ExampleMenu', {text = "Showing button 2"}, "Change Character", "", false, 0, "lobby.AddDetailsToMenu")
end

local function loginPlayer()
    TriggerServerEvent('lobby:server:login')
    TriggerEvent('lobbymenu:OpenMainMenu')
end

local function createMenu()
    TriggerEvent('lobbymenu:CreateMenu', 'critMenu.ExampleMenu', "Test Lobby Menu", "Subtitles are supported too.", "MENU", "WELCOME", "INFORMATION")
    TriggerEvent('lobbymenu:SetHeaderDetails', 'critMenu.ExampleMenu', true, true, 2, 6, 0)

    addDetails()
    addButtons()
end

-- Build the menu
createMenu()
loginPlayer()

-- View lobbies menu
RegisterNetEvent('lobby.viewLobbies', function(_buttonParams)
    TriggerEvent('lobbymenu:ResetButtonList', 'critMenu.ExampleMenu')

    local p = promise.new()
    Blash.Functions.TriggerCallback('lobby:server:getLobbies', function(cb) p:resolve(cb) end)
    local result = Citizen.Await(p)
    for _, v in pairs(result) do
        TriggerEvent('lobbymenu:AddButton', 'critMenu.ExampleMenu', {text = v.name}, "Join " .. v.name, v.players .. ' Players', false, 0, "lobby.joinLobby")
    end

    TriggerEvent('lobbymenu:AddButton', 'critMenu.ExampleMenu', {text = "Back to Main Menu"}, "Back to Main Menu", "", false, 0, "lobby.backToMainMenu")
    TriggerEvent('lobbymenu:UpdateMenu', 'critMenu.ExampleMenu')
end)

RegisterNetEvent('lobby.backToMainMenu', function(_bP)
    TriggerEvent('lobbymenu:ResetButtonList', 'critMenu.ExampleMenu')
    TriggerEvent('lobbymenu:UpdateMenu', 'critMenu.ExampleMenu')
    addButtons()
end)

RegisterNetEvent('lobby.joinLobby', function(buttonParams)
    local lobbyName = buttonParams.text
    TriggerServerEvent('blash-game:server:joinLobby', lobbyName, source)
end)