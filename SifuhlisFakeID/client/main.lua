local QBCore = exports['qb-core']:GetCoreObject()
local ox_lib = exports.ox_lib

-- PED Spawning (We should eat the PEDs)
CreateThread(function()
    local pedModel = GetHashKey(Config.FakeIDPed.model)

    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(1)
    end

    local ped = CreatePed(4, pedModel, Config.FakeIDPed.coords.x, Config.FakeIDPed.coords.y, Config.FakeIDPed.coords.z - 1.0, Config.FakeIDPed.heading, false, true)
    SetEntityAsMissionEntity(ped, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)

    -- Cheems would agree with this qb-target setup? idk, i'm tired....
    exports['qb-target']:AddTargetEntity(ped, {
        options = {
            {
                type = "client",
                event = "SifuhlisfakeID:beginInteraction",
                icon = "fas fa-id-card",
                label = "Talk to Sketchy Man",
            },
        },
        distance = 2.0,
    })
end)

-- Handle fake ID creation
RegisterNetEvent("SifuhlisfakeID:beginInteraction", function()
    local idType = lib.inputDialog("Choose License Type", {
        {type = "select", label = "License Type", options = {
            {value = "driver_license", label = "Driver License ($10,000)"},
            {value = "citizen_id", label = "Citizen ID ($15,000)"},
            {value = "weapon_license", label = "Weapon License ($50,000)"}
        }}
    })

    if not idType then
        QBCore.Functions.Notify("ID creation canceled.", "error")
        return
    end

    local input = lib.inputDialog("Enter Fake ID Details", {
        {type = "input", label = "First Name", placeholder = "John"},
        {type = "input", label = "Last Name", placeholder = "Doe"},
        {type = "input", label = "Date of Birth", placeholder = "MM/DD/YYYY"},
        {type = "select", label = "Gender", options = {"Male", "Female", "Other"}},
        {type = "input", label = "Nationality", placeholder = "American"}
    })

    if input then
        local firstName, lastName, dob, gender, nationality = input[1], input[2], input[3], input[4], input[5]
        TriggerServerEvent("sifuhlisfakeid:createFakeID", idType[1], firstName, lastName, dob, gender, nationality)
    else
        QBCore.Functions.Notify("ID creation canceled.", "error")
    end
end)