local Config = {}

-- NPC Configuration
Config.NPC = {
    model = `a_m_m_business_01`, -- NPC model
    coords = vector3(2700.18, 3458.41, 55.56), -- Set NPC's spawn coordinates
    heading = 180.0, -- NPC's facing direction
}

-- Items the shop will sell
Config.ShopItems = {
    label = "Sandy Shores Blackmarket",
    slots = 5,
    items = {
        [1] = { name = "WEAPON_HEAVYSNIPER_MK2", price = 135000, amount = 100, info = {}, type = "item", slot = 1 },
        [2] = { name = "WEAPON_GRENADE", price = 2000, amount = 100, info = {}, type = "item", slot = 2 },
        [3] = { name = "WEAPON_HEAVYPISTOL", price = 35000, amount = 100, info = {}, type = "item", slot = 3 },
        [4] = { name = "lockpick", price = 200, amount = 100, info = {}, type = "item", slot = 4 },
        [5] = { name = "bandage", price = 15, amount = 100, info = {}, type = "item", slot = 5 },
    },
}

-- Spawning NPC and setting up qb-target
CreateThread(function()
    -- Spawn the NPC
    RequestModel(Config.NPC.model)
    while not HasModelLoaded(Config.NPC.model) do
        Wait(100)
    end

    local npc = CreatePed(4, Config.NPC.model, Config.NPC.coords.x, Config.NPC.coords.y, Config.NPC.coords.z - 1.0, Config.NPC.heading, false, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    TaskStartScenarioInPlace(npc, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    -- Setup qb-target interaction
    exports['qb-target']:AddTargetEntity(npc, {
        options = {
            {
                type = "client",
                event = "npc_store:openShop",
                label = "Open Store",
                icon = "fas fa-shopping-basket",
            },
        },
        distance = 2.5,
    })
end)

-- Open the shop when the player interacts
RegisterNetEvent('npc_store:openShop', function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "general", Config.ShopItems)
end)
