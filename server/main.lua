local Blash = exports['blash-core']:GetObject()

RegisterNetEvent('lobby:server:login', function()
    local src = source
    Blash.Player.Login(src, Blash.Functions.GetIdentifier(src, 'license'))
end)

Blash.Functions.CreateCallback('lobby:server:getLobbies', function(source, cb)
    cb(exports['blash-game']:getLobbies())
end)