# fakeplates

For the plate to save to the item, you need to edit your qb-inventory.

Preview - https://www.youtube.com/watch?v=0-zeAanZaUo

Dependencies - qb-lock - https://github.com/NathanERP/qb-lock

//// First Edit ////

Around line 571 in qb-inventory/html/js/app.js add this

        } else if (itemData.name == "license_plate") {
            $(".item-info-title").html("<p>" + itemData.label + "</p>");
            $(".item-info-description").html('<p>Plate: ' + itemData.info.plate + '</p>');
        } else if (itemData.name == "fake_plate") {
            $(".item-info-title").html("<p>" + itemData.label + "</p>");
            $(".item-info-description").html('<p>'+itemData.description+'</p><p>Plate: ' + itemData.info.plate + '</p>');


After you add that, go to line 1505 in qb-inventory/server/main.lua add this


	elseif itemData["name"] == "license_plate" then
		info.plate = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(2))
	elseif itemData["name"] == "fake_plate" then
		info.plate = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(2))


Last thing, add the items to you qb-core/shared/items.lua


["fake_plate"] 				     = {["name"] = "fake_plate", 				["label"] = "Fake Plate", 				["weight"] = 0, 		["type"] = "item", 		["image"] = "plate.png", 				    ["unique"] = true, 		["useable"] = true, 	['shouldClose'] = false,    	["combinable"] = nil,   ["description"] = "Marked for Police seizure."},


["license_plate"] 				 = {["name"] = "license_plate", 			["label"] = "Plate", 					["weight"] = 0, 		["type"] = "item", 		["image"] = "plate.png", 				    ["unique"] = true, 		["useable"] = true, 	['shouldClose'] = false,    	["combinable"] = nil,   ["description"] = "Plate for vehicle"},
