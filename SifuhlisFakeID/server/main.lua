local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("sifuhlisfakeid:createFakeID", function(idType, firstName, lastName, dob, gender, nationality)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    -- Define prices and item names for each license type, set whatever here, check items.lua for your license IDs
    local licenses = {
        citizen_id = {price = 15000, item = "id_card", description = "Citizen ID"},
        driver_license = {price = 10000, item = "driver_license", description = "Driver License"},
        weapon_license = {price = 50000, item = "weaponlicense", description = "Weapon License"}
    }

    local license = licenses[idType]

    if not license then
        TriggerClientEvent("QBCore:Notify", src, "Invalid license type selected.", "error")
        return
    end

    if Player then
        -- Check if the player has enough money
        if Player.Functions.RemoveMoney("cash", license.price, "fake-id-purchase") or Player.Functions.RemoveMoney("bank", license.price, "fake-id-purchase") then
            -- The PED gracefully gives the player their so desired yum yum ID Card... again.. i'm tired..
            Player.Functions.AddItem(license.item, 1, nil, {
                firstname = firstName,
                lastname = lastName,
                birthdate = dob,
                gender = gender,
                nationality = nationality,
                type = license.description
            })

            TriggerClientEvent("QBCore:Notify", src, string.format("Fake %s created successfully!", license.description), "success")
        else
            TriggerClientEvent("QBCore:Notify", src, string.format("You don’t have enough money for a %s.", license.description), "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "Failed to create Fake ID.", "error")
    end
end)
