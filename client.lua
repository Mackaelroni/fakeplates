local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("plate:removePlate")
AddEventHandler("plate:removePlate", function()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local plate =  GetVehicleNumberPlateText(vehicle)
    local vehCoords = GetEntityCoords(vehicle)
    local pos = GetEntityCoords(PlayerPedId())
    local close = #(pos - vehCoords) <= 3.5

    NetworkHasControlOfEntity(vehicle)
    NetworkRequestControlOfEntity(vehicle)

    if close then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
            if result then
                local seconds = math.random(6,10)
                local circles = math.random(4,6)
                local success = exports['qb-lock']:StartLockPickCircle(circles, seconds, success)
                if success then
                    QBCore.Functions.Progressbar("plateremoval", "Removing Plate..", math.random(7500, 12000), false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                        anim = "machinic_loop_mechandplayer",
                        flags = 0,
                    }, {}, {}, function() -- Done
                        ClearPedTasks(PlayerPedId())
                        TriggerServerEvent('plate:addPlate', plate)
                        Wait(500)
                        SetVehicleNumberPlateText(vehicle, "")
                    end, function() -- Cancel
                        ClearPedTasks(PlayerPedId())
                        QBCore.Functions.Notify("Process Canceled", "error")
                    end)
                else
                    QBCore.Functions.Notify("Failed to remove plate", "error")
                end
            else
                QBCore.Functions.Notify("You don\'t have the right tools.", "error")
            end
        end, 'screwdriverset')
    else
        QBCore.Functions.Notify('No vehicle nearby', "error", 2500)
    end
end)

RegisterNetEvent('plate:installPlate')
AddEventHandler('plate:installPlate', function(data)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local plate =  GetVehicleNumberPlateText(vehicle)
    local vehCoords = GetEntityCoords(vehicle)
    local pos = GetEntityCoords(PlayerPedId())
    local close = #(pos - vehCoords) <= 3.5

    NetworkHasControlOfEntity(vehicle)
    NetworkRequestControlOfEntity(vehicle)

    if close then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
            if result then
                QBCore.Functions.Progressbar("installing", "Removing Current Plate..", math.random(7500, 12000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                    anim = "machinic_loop_mechandplayer",
                    flags = 0,
                }, {}, {}, function() -- Done
                    QBCore.Functions.Progressbar("installing", "Installing Plate..", math.random(7500, 12000), false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                        anim = "machinic_loop_mechandplayer",
                        flags = 0,
                    }, {}, {}, function() -- Done
                        ClearPedTasks(PlayerPedId())
                        SetVehicleNumberPlateText(vehicle, data)
                        TriggerServerEvent('plate:takePlate')
                        TriggerServerEvent('plate:addPlate', plate)
                    end, function() -- Cancel
                        ClearPedTasks(PlayerPedId())
                        QBCore.Functions.Notify("Process Canceled", "error")
                    end)
                end, function() -- Cancel
                    ClearPedTasks(PlayerPedId())
                    QBCore.Functions.Notify("Process Canceled", "error")
                end)

            else
                QBCore.Functions.Notify("You don\'t have the right tools.", "error")
            end
        end, 'screwdriverset')
    else
        QBCore.Functions.Notify('No vehicle nearby', "error", 2500)
    end
end)

RegisterNetEvent('plate:installFakePlate')
AddEventHandler('plate:installFakePlate', function(data)
    local vehicle = QBCore.Functions.GetClosestVehicle()
    local plate =  GetVehicleNumberPlateText(vehicle)
    local vehCoords = GetEntityCoords(vehicle)
    local pos = GetEntityCoords(PlayerPedId())
    local close = #(pos - vehCoords) <= 3.5

    NetworkHasControlOfEntity(vehicle)
    NetworkRequestControlOfEntity(vehicle)

    if close then
        QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
            if result then
                QBCore.Functions.Progressbar("fake_plate", "Removing Plate..", math.random(7500, 12000), false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                    anim = "machinic_loop_mechandplayer",
                    flags = 0,
                }, {}, {}, function() -- Done
                    QBCore.Functions.Progressbar("install_fake_plate", "Installing Fake Plate..", math.random(7500, 12000), false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, {
                        animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
                        anim = "machinic_loop_mechandplayer",
                        flags = 0,
                    }, {}, {}, function() -- Done
                        TriggerServerEvent('plate:addPlate', plate)
                        SetVehicleNumberPlateText(vehicle, data)
                        TriggerServerEvent('plate:takeFakePlate')
                        ClearPedTasks(PlayerPedId())
                    end, function() -- Cancel
                        ClearPedTasks(PlayerPedId())
                        QBCore.Functions.Notify("Process Canceled", "error")
                    end)
                end, function() -- Cancel
                    ClearPedTasks(PlayerPedId())
                    QBCore.Functions.Notify("Process Canceled", "error")
                end)
            else
                QBCore.Functions.Notify("You don\'t have the right tools.", "error")
            end  
        end, 'screwdriverset')
    else
        QBCore.Functions.Notify('No vehicle nearby', "error", 2500)
    end
end)