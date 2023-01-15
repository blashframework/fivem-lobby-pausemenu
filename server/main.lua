local Blash = exports['blash-core']:GetObject()

RegisterNetEvent('lobby:server:login', function()
    local src = source
    Blash.Player.Login(src, Blash.Functions.GetIdentifier(src, 'license'))
end)

Blash.Functions.CreateCallback('lobby:server:getLobbies', function(source, cb)
    local lobbies = exports['blash-game']:getLobbies()
    local newLobbies = {}

    for k, v in pairs(lobbies) do
        local isInLobby = false
        for k1, v1 in pairs(v.players) do print(k, k1, v1, source) if v1 == source then isInLobby = true end end

        newLobbies[k] = v
        newLobbies[k].isInLobby = isInLobby
    end

    cb(newLobbies)
end)