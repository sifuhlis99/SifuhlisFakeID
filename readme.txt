+-------------------------------------------------------+
|███████╗██╗███████╗██╗   ██╗██╗  ██╗██╗     ██╗███████╗|
|██╔════╝██║██╔════╝██║   ██║██║  ██║██║     ██║██╔════╝|
|███████╗██║█████╗  ██║   ██║███████║██║     ██║███████╗|
|╚════██║██║██╔══╝  ██║   ██║██╔══██║██║     ██║╚════██║|
|███████║██║██║     ╚██████╔╝██║  ██║███████╗██║███████║|
|╚══════╝╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝╚══════╝|
+-------------------------------------------------------+

Welcome to the readme part of the SifuhlisFakeID script for QBCore!

Dependencies:
- QBCore Framework
- Ox_lib
- qb-idcard (https://github.com/itsHyper/qb-idcard)

Installation!

drag and drop this script into your resources and make sure you
"ensure SifuhlisFakeID" in the server.cfg
(Or if you have a dedicated [scripts] folder that is already ensured in the server.cfg, you can drag it to that folder)


Go to the following in qb-idcard > server > server.lua

look for
-----------------------------------------------

local ShowId = function(source, item, nui)
    local src = source
    local found = false
    local character = QBCore.Functions.GetPlayer(src)
    local PlayerPed = GetPlayerPed(src)
    local PlayerCoords = GetEntityCoords(PlayerPed)
    local info = {
        ['name'] = item.info.firstname,
        ['lastname'] = item.info.lastname,
        ['gender'] = item.info.gender,
        ['dob'] = item.info.birthdate,
        ['nationality'] = item.info.nationality,
        ['type'] = item.info.type
    }
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local TargetPed = GetPlayerPed(v)
        local dist = #(PlayerCoords - GetEntityCoords(TargetPed))
        if dist < 3.0 and PlayerPed ~= TargetPed then
            TriggerClientEvent('QBCore:Notify', src, "You showed your idcard")
            TriggerClientEvent('qb-idcard:client:open', v, info, nui)
            found = true
            break
        end
    end
    if not found then TriggerClientEvent('qb-idcard:client:open', src, info, nui) end
    if nui == 'policecard' then TriggerClientEvent('qb-idcard:client:policebadgeanim', src) end
end



and change it with

local ShowId = function(source, item, nui)
    local src = source
    local found = false
    local character = QBCore.Functions.GetPlayer(src)
    local PlayerPed = GetPlayerPed(src)
    local PlayerCoords = GetEntityCoords(PlayerPed)

    -- Use the custom data if available; otherwise, fall back on player data
    local info = {
        ['name'] = item.info.firstname or character.PlayerData.charinfo.firstname,
        ['lastname'] = item.info.lastname or character.PlayerData.charinfo.lastname,
        ['gender'] = item.info.gender or character.PlayerData.charinfo.gender,
        ['dob'] = item.info.birthdate or character.PlayerData.charinfo.birthdate,
        ['nationality'] = item.info.nationality or character.PlayerData.charinfo.nationality,
        ['type'] = item.info.type or "ID Card"
    }

    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local TargetPed = GetPlayerPed(v)
        local dist = #(PlayerCoords - GetEntityCoords(TargetPed))
        if dist < 3.0 and PlayerPed ~= TargetPed then
            TriggerClientEvent('QBCore:Notify', src, "You showed your ID card")
            TriggerClientEvent('qb-idcard:client:open', v, info, nui)
            found = true
            break
        end
    end
    if not found then
        TriggerClientEvent('qb-idcard:client:open', src, info, nui)
    end
    if nui == 'policecard' then
        TriggerClientEvent('qb-idcard:client:policebadgeanim', src)
    end
end

-----------------------------------------------

Make sure you also check the config! Set it to what you want really! :3