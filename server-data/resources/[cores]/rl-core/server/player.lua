RLCore.Players = {}
RLCore.Player = {}

RLCore.Player.Login = function(source, citizenid, newData)
	if source ~= nil then
		if citizenid then
			RLCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..citizenid.."'", function(result)
				local PlayerData = result[1]
				if PlayerData ~= nil then
					PlayerData.money = json.decode(PlayerData.money)
					PlayerData.job = json.decode(PlayerData.job)
					PlayerData.position = json.decode(PlayerData.position)
					PlayerData.metadata = json.decode(PlayerData.metadata)
					PlayerData.charinfo = json.decode(PlayerData.charinfo)
					if PlayerData.gang ~= nil then
						PlayerData.gang = json.decode(PlayerData.gang)
					else
						PlayerData.gang = {}
					end
				end
				RLCore.Player.CheckPlayerData(source, PlayerData)
			end)
		else
			RLCore.Player.CheckPlayerData(source, newData)
		end
		return true
	else
		RLCore.ShowError(GetCurrentResourceName(), "ERROR RLCORE.PLAYER.LOGIN - NO SOURCE GIVEN!")
		return false
	end
end

RLCore.Player.CheckPlayerData = function(source, PlayerData)
	PlayerData = PlayerData ~= nil and PlayerData or {}

	PlayerData.source = source
	PlayerData.citizenid = PlayerData.citizenid ~= nil and PlayerData.citizenid or RLCore.Player.CreateCitizenId()
	PlayerData.steam = PlayerData.steam ~= nil and PlayerData.steam or RLCore.Functions.GetIdentifier(source, "steam")
	PlayerData.license = PlayerData.license ~= nil and PlayerData.license or RLCore.Functions.GetIdentifier(source, "license")
	PlayerData.name = GetPlayerName(source)
	PlayerData.cid = PlayerData.cid ~= nil and PlayerData.cid or 1

	PlayerData.money = PlayerData.money ~= nil and PlayerData.money or {}
	for moneytype, startamount in pairs(RLCore.Config.Money.MoneyTypes) do
		PlayerData.money[moneytype] = PlayerData.money[moneytype] ~= nil and math.floor(PlayerData.money[moneytype]) or startamount
	end

	PlayerData.charinfo = PlayerData.charinfo ~= nil and PlayerData.charinfo or {}
	PlayerData.charinfo.firstname = PlayerData.charinfo.firstname ~= nil and PlayerData.charinfo.firstname or "Firstname"
	PlayerData.charinfo.lastname = PlayerData.charinfo.lastname ~= nil and PlayerData.charinfo.lastname or "Lastname"
	PlayerData.charinfo.birthdate = PlayerData.charinfo.birthdate ~= nil and PlayerData.charinfo.birthdate or "00-00-0000"
	PlayerData.charinfo.gender = PlayerData.charinfo.gender ~= nil and PlayerData.charinfo.gender or 0
	PlayerData.charinfo.backstory = PlayerData.charinfo.backstory ~= nil and PlayerData.charinfo.backstory or "placeholder backstory"
	PlayerData.charinfo.nationality = PlayerData.charinfo.nationality ~= nil and PlayerData.charinfo.nationality or "Israel"
	PlayerData.charinfo.phone = tonumber(PlayerData.charinfo.phone) ~= nil and PlayerData.charinfo.phone or '05' .. tostring(math.random(1, 9)) .. tostring(math.random(100, 999)) .. tostring(math.random(1000, 9999))
    PlayerData.charinfo.account = PlayerData.charinfo.account ~= nil and PlayerData.charinfo.account or "RL0"..math.random(1,9).."WL"..math.random(100, 999)
	PlayerData.charinfo.card = PlayerData.charinfo.card ~= nil and PlayerData.charinfo.card or 0

	PlayerData.metadata = PlayerData.metadata ~= nil and PlayerData.metadata or {}
	PlayerData.metadata["hunger"] = PlayerData.metadata["hunger"] ~= nil and PlayerData.metadata["hunger"] or 100
	PlayerData.metadata["thirst"] = PlayerData.metadata["thirst"] ~= nil and PlayerData.metadata["thirst"] or 100
	PlayerData.metadata["stress"] = PlayerData.metadata["stress"] ~= nil and PlayerData.metadata["stress"] or 0
	PlayerData.metadata["isdead"] = PlayerData.metadata["isdead"] ~= nil and PlayerData.metadata["isdead"] or false
	PlayerData.metadata["inlaststand"] = PlayerData.metadata["inlaststand"] ~= nil and PlayerData.metadata["inlaststand"] or false
	PlayerData.metadata["armor"]  = PlayerData.metadata["armor"]  ~= nil and PlayerData.metadata["armor"] or 0
	PlayerData.metadata["ishandcuffed"] = PlayerData.metadata["ishandcuffed"] ~= nil and PlayerData.metadata["ishandcuffed"] or false	
	PlayerData.metadata["tracker"] = PlayerData.metadata["tracker"] ~= nil and PlayerData.metadata["tracker"] or false
	PlayerData.metadata["injail"] = PlayerData.metadata["injail"] ~= nil and PlayerData.metadata["injail"] or 0
	PlayerData.metadata["jailitems"] = PlayerData.metadata["jailitems"] ~= nil and PlayerData.metadata["jailitems"] or {}
	PlayerData.metadata["status"] = PlayerData.metadata["status"] ~= nil and PlayerData.metadata["status"] or {}
	PlayerData.metadata["phone"] = PlayerData.metadata["phone"] ~= nil and PlayerData.metadata["phone"] or {}
	PlayerData.metadata["commandbinds"] = PlayerData.metadata["commandbinds"] ~= nil and PlayerData.metadata["commandbinds"] or {}
	PlayerData.metadata["bloodtype"] = PlayerData.metadata["bloodtype"] ~= nil and PlayerData.metadata["bloodtype"] or RLCore.Config.Player.Bloodtypes[math.random(1, #RLCore.Config.Player.Bloodtypes)]
	PlayerData.metadata["dealerrep"] = PlayerData.metadata["dealerrep"] ~= nil and PlayerData.metadata["dealerrep"] or 0
	PlayerData.metadata["craftingrep"] = PlayerData.metadata["craftingrep"] ~= nil and PlayerData.metadata["craftingrep"] or 0
	PlayerData.metadata["attachmentcraftingrep"] = PlayerData.metadata["attachmentcraftingrep"] ~= nil and PlayerData.metadata["attachmentcraftingrep"] or 0
	PlayerData.metadata["currentapartment"] = PlayerData.metadata["currentapartment"] ~= nil and PlayerData.metadata["currentapartment"] or nil
	PlayerData.metadata["jobrep"] = PlayerData.metadata["jobrep"] ~= nil and PlayerData.metadata["jobrep"] or {
		["tow"] = 0,
		["trucker"] = 0,
		["taxi"] = 0,
		["hotdog"] = 0,
	}

	PlayerData.metadata["incarry"] = PlayerData.metadata["incarry"] ~= nil and PlayerData.metadata["incarry"] or false
	PlayerData.metadata["walk"] = PlayerData.metadata["walk"] ~= nil and PlayerData.metadata["walk"] or "reset"
	PlayerData.metadata["callsign"] = PlayerData.metadata["callsign"] ~= nil and PlayerData.metadata["callsign"] or "NO CALLSIGN"
	PlayerData.metadata["fingerprint"] = PlayerData.metadata["fingerprint"] ~= nil and string.len(PlayerData.metadata["fingerprint"]) > 15 and PlayerData.metadata["fingerprint"] or RLCore.Player.CreateFingerId()
	PlayerData.metadata["walletid"] = PlayerData.metadata["walletid"] ~= nil and PlayerData.metadata["walletid"] or RLCore.Player.CreateWalletId()
	PlayerData.metadata["criminalrecord"] = PlayerData.metadata["criminalrecord"] ~= nil and PlayerData.metadata["criminalrecord"] or {
		["hasRecord"] = false,
		["date"] = nil
	}
	PlayerData.metadata["inside"] = PlayerData.metadata["inside"] ~= nil and PlayerData.metadata["inside"] or {
		house = nil,
		apartment = {
			apartmentType = nil,
			apartmentId = nil,
		}
	}

	PlayerData.job = PlayerData.job ~= nil and PlayerData.job or {}
	PlayerData.job.name = PlayerData.job.name ~= nil and PlayerData.job.name or "unemployed"
	PlayerData.job.label = PlayerData.job.label ~= nil and PlayerData.job.label or "Unemployed"
	PlayerData.job.payment = PlayerData.job.payment ~= nil and PlayerData.job.payment or 35
	PlayerData.job.onduty = PlayerData.job.onduty ~= nil and PlayerData.job.onduty or true
	PlayerData.job.isboss = PlayerData.job.isboss ~= nil and PlayerData.job.isboss or false
	PlayerData.job.grade = PlayerData.job.grade ~= nil and PlayerData.job.grade or {}
	PlayerData.job.grade.name = PlayerData.job.grade.name ~= nil and PlayerData.job.grade.name or nil
	PlayerData.job.grade.level = PlayerData.job.grade.level ~= nil and PlayerData.job.grade.level or 0
	
	PlayerData.gang = PlayerData.gang ~= nil and PlayerData.gang or {}
	PlayerData.gang.name = PlayerData.gang.name ~= nil and PlayerData.gang.name or "geen"
	PlayerData.gang.label = PlayerData.gang.label ~= nil and PlayerData.gang.label or "Geen Gang"

	PlayerData.position = PlayerData.position ~= nil and PlayerData.position or RLConfig.DefaultSpawn
	PlayerData.LoggedIn = true

	PlayerData = RLCore.Player.LoadInventory(PlayerData)
	RLCore.Player.CreatePlayer(PlayerData)
end

RLCore.Player.CreatePlayer = function(PlayerData)
	local self = {}
	self.Functions = {}
	self.PlayerData = PlayerData

	self.Functions.UpdatePlayerData = function()
		TriggerClientEvent("RLCore:Player:SetPlayerData", self.PlayerData.source, self.PlayerData)
		--RLCore.Commands.Refresh(self.PlayerData.source)
	end

	self.Functions.SetJob = function(job, grade)
		local job = job:lower()
		local grade = tostring(grade)

		if RLCore.Shared.Jobs[job] ~= nil and RLCore.Shared.Jobs[job].grades[grade] then
			self.PlayerData.job.name = job
			self.PlayerData.job.label = RLCore.Shared.Jobs[job].label
			self.PlayerData.job.onduty = RLCore.Shared.Jobs[job].defaultDuty
			
			local jobgrade = RLCore.Shared.Jobs[job].grades[grade]
			self.PlayerData.job.grade = {}
			self.PlayerData.job.grade.name = jobgrade.name
			self.PlayerData.job.grade.level = tonumber(grade)
			self.PlayerData.job.payment = jobgrade.payment ~= nil and jobgrade.payment or 30
			self.PlayerData.job.isboss = jobgrade.isboss ~= nil and jobgrade.isboss or false

			self.Functions.UpdatePlayerData()
			TriggerClientEvent("RLCore:Client:OnJobUpdate", self.PlayerData.source, self.PlayerData.job)
			return true
		end

		return false
	end

	self.Functions.SetBoss = function(boo)
		self.PlayerData.job.isboss = boo
        self.Functions.UpdatePlayerData()
        TriggerClientEvent("RLCore:Client:OnJobUpdate", self.PlayerData.source, self.PlayerData.job)
	end

	self.Functions.SetGang = function(gang)
		local gang = gang:lower()
		if RLCore.Shared.Gangs[gang] ~= nil then
			self.PlayerData.gang.name = gang
			self.PlayerData.gang.label = RLCore.Shared.Gangs[gang].label
			self.Functions.UpdatePlayerData()
			TriggerClientEvent("RLCore:Client:OnGangUpdate", self.PlayerData.source, self.PlayerData.gang)
		end
	end

	self.Functions.SetJobDuty = function(onDuty)
		self.PlayerData.job.onduty = onDuty
		self.Functions.UpdatePlayerData()
	end

	self.Functions.SetMetaData = function(meta, val)
		local meta = meta:lower()
		if val ~= nil then
			self.PlayerData.metadata[meta] = val
			self.Functions.UpdatePlayerData()
		end
	end

	self.Functions.AddJobReputation = function(amount)
		local amount = tonumber(amount)
		self.PlayerData.metadata["jobrep"][self.PlayerData.job.name] = self.PlayerData.metadata["jobrep"][self.PlayerData.job.name] + amount
		self.Functions.UpdatePlayerData()
	end

	self.Functions.SetCreditCard = function(cardNumber)
		self.PlayerData.charinfo.card = cardNumber
		self.Functions.UpdatePlayerData()
	end

	self.Functions.AddMoney = function(moneytype, amount, reason)
        reason = reason or 'unknown'
        local moneytype = moneytype:lower()
        local amount = tonumber(amount)
        if amount < 0 then
            return
        end
        if self.PlayerData.money[moneytype] then
            self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] + amount
            self.Functions.UpdatePlayerData()
            if amount > 100000 then
                TriggerEvent('rl-log:server:CreateLog', 'playermoney', 'AddMoney', 'lightgreen', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype], true)
            else
                TriggerEvent('rl-log:server:CreateLog', 'playermoney', 'AddMoney', 'lightgreen', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') added, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype])
            end
            TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, false, reason)
            return true
        end
        return false
    end

    self.Functions.RemoveMoney = function(moneytype, amount, reason)
        reason = reason or 'unknown'
        local moneytype = moneytype:lower()
        local amount = tonumber(amount)
        if amount < 0 then
            return
        end
        if self.PlayerData.money[moneytype] then
            for _, mtype in pairs(RLCore.Config.Money.DontAllowMinus) do
                if mtype == moneytype then
                    if self.PlayerData.money[moneytype] - amount < 0 then
                        return false
                    end
                end
            end
            self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] - amount
            self.Functions.UpdatePlayerData()
            if amount > 100000 then
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'RemoveMoney', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype], true)
            else
                TriggerEvent('qb-log:server:CreateLog', 'playermoney', 'RemoveMoney', 'red', '**' .. GetPlayerName(self.PlayerData.source) .. ' (citizenid: ' .. self.PlayerData.citizenid .. ' | id: ' .. self.PlayerData.source .. ')** $' .. amount .. ' (' .. moneytype .. ') removed, new ' .. moneytype .. ' balance: ' .. self.PlayerData.money[moneytype])
            end
            TriggerClientEvent('hud:client:OnMoneyChange', self.PlayerData.source, moneytype, amount, true, reason)
            if moneytype == 'bank' then
                TriggerClientEvent('qb-phone:client:RemoveBankMoney', self.PlayerData.source, amount)
            end
            return true
        end
        return false
    end

	self.Functions.SetMoney = function(moneytype, amount, reason)
		reason = reason ~= nil and reason or "unkown"
		local moneytype = moneytype:lower()
		local amount = tonumber(amount)
		if amount < 0 then return end
		if self.PlayerData.money[moneytype] ~= nil then
			self.PlayerData.money[moneytype] = amount
			self.Functions.UpdatePlayerData()
			TriggerEvent("RL-log:server:sendLog", self.PlayerData.citizenid, "moneyset", {amount=amount, moneytype=moneytype, newbalance=self.PlayerData.money[moneytype], reason=reason})
			TriggerEvent("bb-logs:server:createLog", "playermoney", "SetMoney", "green", "**"..GetPlayerName(self.PlayerData.source) .. " (citizenid: "..self.PlayerData.citizenid.." | id: "..self.PlayerData.source..")** $"..amount .. " ("..moneytype..") gezet, nieuw "..moneytype.." balans: "..self.PlayerData.money[moneytype])
			return true
		end
		return false
	end

	self.Functions.GetMoney = function(moneytype)
		if moneytype ~= nil then
			local moneytype = moneytype:lower()
			return self.PlayerData.money[moneytype]
		end
		return false
	end

	self.Functions.GetCitizenID = function()
		return self.PlayerData.citizenid
	end

	self.Functions.HasMoney = function(moneytype, count, remove)
		if moneytype ~= nil then
			local moneytype = moneytype:lower()
			local currentAmount = self.PlayerData.money[moneytype]
			local amount = tonumber(amount)
			if amount < 0 or amount == nil then return false end
			if currentAmount ~= nil then
				if currentAmount > amount then
					if remove then
						for _, mtype in pairs(RLCore.Config.Money.DontAllowMinus) do
							if mtype == moneytype then
								if currentAmount - amount < 0 then return false end
							end
						end

						self.PlayerData.money[moneytype] = self.PlayerData.money[moneytype] - amount
						self.Functions.UpdatePlayerData()
						TriggerClientEvent("hud:client:OnMoneyChange", self.PlayerData.source, moneytype, amount, true)
					end
					return true
				end
			end
		end
		return false
	end

	self.Functions.AddItem = function(item, amount, slot, info)
		TriggerClientEvent("player:receiveItem", source, item, amount)
	end

	self.Functions.RemoveItem = function(item, amount, slot)
		TriggerClientEvent("inventory:removeItem", source, item, amount)
	end

	self.Functions.SetInventory = function(items)
		self.PlayerData.items = items
		self.Functions.UpdatePlayerData()  
	end

	self.Functions.ClearInventory = function()
		self.PlayerData.items = {} 
		self.Functions.UpdatePlayerData()
	end 

	self.Functions.GetItemByName = function(item)
		RLCore.Functions.ExecuteSql(true, "SELECT * FROM player_inventory WHERE name = 'ply-"..PlayerData.citizenid.."'", function(result)
			for k,v in pairs(result) do
				if v.item_id == item then
					print(item)
					passed = true
				end 
			end
		end)
		if passed then 
			return item
		end 
	end
	
	self.Functions.GetCardSlot = function(cardNumber, cardType)
        local item = tostring(cardType):lower()
        local slots = RLCore.Player.GetSlotsByItem(self.PlayerData.items, item)
        for _, slot in pairs(slots) do
            if slot ~= nil then
                if self.PlayerData.items[slot].info.cardNumber == cardNumber then 
                    return slot
                end
            end
        end
        return nil
    end
	
	self.Functions.GetItemsByName = function(item)
		local item = tostring(item):lower()
		local items = {}
		local slots = RLCore.Player.GetSlotsByItem(self.PlayerData.items, item)
		for _, slot in pairs(slots) do
			if slot ~= nil then
				table.insert(items, self.PlayerData.items[slot])
			end
		end
		return items
	end

	self.Functions.GetItemBySlot = function(slot)
		local slot = tonumber(slot)
		if self.PlayerData.items[slot] ~= nil then
			return self.PlayerData.items[slot]
		end
		return nil
	end

	self.Functions.Save = function()
		RLCore.Player.Save(self.PlayerData.source)
	end
	
	RLCore.Players[self.PlayerData.source] = self
	RLCore.Player.Save(self.PlayerData.source)
	self.Functions.UpdatePlayerData()
end

RLCore.Player.Save = function(source)
	local PlayerData = RLCore.Players[source].PlayerData
	if PlayerData ~= nil then
		RLCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..PlayerData.citizenid.."'", function(result)
			if result[1] == nil then
				RLCore.Functions.ExecuteSql(true, "INSERT INTO `players` (`citizenid`, `cid`, `steam`, `license`, `name`, `money`, `charinfo`, `job`, `gang`, `position`, `metadata`) VALUES ('"..PlayerData.citizenid.."', '"..tonumber(PlayerData.cid).."', '"..PlayerData.steam.."', '"..PlayerData.license.."', '"..PlayerData.name.."', '"..json.encode(PlayerData.money).."', '"..RLCore.EscapeSqli(json.encode(PlayerData.charinfo)).."', '"..json.encode(PlayerData.job).."', '"..json.encode(PlayerData.gang).."', '"..json.encode(PlayerData.position).."', '"..json.encode(PlayerData.metadata).."')")
			else
				RLCore.Functions.ExecuteSql(true, "UPDATE `players` SET steam='"..PlayerData.steam.."',license='"..PlayerData.license.."',name='"..PlayerData.name.."',money='"..json.encode(PlayerData.money).."',charinfo='"..RLCore.EscapeSqli(json.encode(PlayerData.charinfo)).."',job='"..json.encode(PlayerData.job).."',gang='"..json.encode(PlayerData.gang).."', position='"..json.encode(PlayerData.position).."',metadata='"..json.encode(PlayerData.metadata).."' WHERE `citizenid` = '"..PlayerData.citizenid.."'")
			end
			RLCore.Player.SaveInventory(source)
		end)
		print('^2[rl-core:playerSaved]^7 ' .. PlayerData.name .." saved.")
	else
		print('^1[rl-core:playerSaved]^7 ' .. PlayerData.name .." playerdata is empty.")
	end
end

RLCore.Player.Logout = function(source)
	TriggerClientEvent('RLCore:Client:OnPlayerUnload', source)
	TriggerClientEvent("RLCore:Player:UpdatePlayerData", source)
	Citizen.Wait(200)
	-- TriggerEvent('RLCore:Server:OnPlayerUnload')
	-- RLCore.Players[source].Functions.Save()
	RLCore.Players[source] = nil
end

RLCore.Player.DeleteCharacter = function(source, citizenid)
	RLCore.Functions.ExecuteSql(true, "DELETE FROM `players` WHERE `citizenid` = '"..citizenid.."'")
	RLCore.Functions.ExecuteSql(true, "DELETE FROM `user_licenses` WHERE `citizenid` = '"..citizenid.."'")
	TriggerEvent("RL-log:server:sendLog", citizenid, "characterdeleted", {})
	TriggerEvent("bb-logs:server:createLog", "joinleave", "Character Deleted", "red", "**".. GetPlayerName(source) .. "** ("..GetPlayerIdentifiers(source)[1]..") deleted **"..citizenid.."**..")
end

RLCore.Player.LoadInventory = function(PlayerData)
	PlayerData.items = {}
	RLCore.Functions.ExecuteSql(true, "SELECT * FROM `playeritems` WHERE `citizenid` = '"..PlayerData.citizenid.."'", function(oldInventory)
		if oldInventory[1] ~= nil then
			for _, item in pairs(oldInventory) do
				if item ~= nil then
					local itemInfo = RLCore.Shared.Items[item.name:lower()]
					PlayerData.items[item.slot] = {name = itemInfo["name"], amount = item.amount, info = json.decode(item.info) ~= nil and json.decode(item.info) or "", label = itemInfo["label"], description = itemInfo["description"] ~= nil and itemInfo["description"] or "", weight = itemInfo["weight"], type = itemInfo["type"], unique = itemInfo["unique"], useable = itemInfo["useable"], image = itemInfo["image"], shouldClose = itemInfo["shouldClose"], slot = item.slot, combinable = itemInfo["combinable"]}
				end
				Citizen.Wait(1)
			end
			RLCore.Functions.ExecuteSql(true, "DELETE FROM `playeritems` WHERE `citizenid` = '"..PlayerData.citizenid.."'")
		else
			RLCore.Functions.ExecuteSql(true, "SELECT * FROM `players` WHERE `citizenid` = '"..PlayerData.citizenid.."'", function(result)
				if result[1] ~= nil then 
					if result[1].inventory ~= nil then
						plyInventory = json.decode(result[1].inventory)
						if next(plyInventory) ~= nil then 
							for _, item in pairs(plyInventory) do
								if item ~= nil then
									local itemInfo = RLCore.Shared.Items[item.name:lower()]
									PlayerData.items[item.slot] = {
										name = itemInfo["name"], 
										amount = item.amount, 
										info = item.info ~= nil and item.info or "", 
										label = itemInfo["label"], 
										description = itemInfo["description"] ~= nil and itemInfo["description"] or "", 
										weight = itemInfo["weight"], 
										type = itemInfo["type"], 
										unique = itemInfo["unique"], 
										useable = itemInfo["useable"], 
										image = itemInfo["image"], 
										shouldClose = itemInfo["shouldClose"], 
										slot = item.slot, 
										combinable = itemInfo["combinable"]
									}
								end
							end
						end
					end
				end
			end)
		end
	end)
	return PlayerData
end

RLCore.Player.SaveInventory = function(source)
	if RLCore.Players[source] ~= nil then 
		local PlayerData = RLCore.Players[source].PlayerData
		local items = PlayerData.items
		local ItemsJson = {}
		if items ~= nil and next(items) ~= nil then
			for slot, item in pairs(items) do
				if items[slot] ~= nil then
					table.insert(ItemsJson, {
						name = item.name,
						amount = item.amount,
						info = item.info,
						type = item.type,
						slot = slot,
					})
				end
			end
	
			RLCore.Functions.ExecuteSql(true, "UPDATE `players` SET `inventory` = '"..RLCore.EscapeSqli(json.encode(ItemsJson)).."' WHERE `citizenid` = '"..PlayerData.citizenid.."'")
		end
	end
end

RLCore.Player.GetTotalWeight = function(items)
	local weight = 0
	if items ~= nil then
		for slot, item in pairs(items) do
			weight = weight + (item.weight * item.amount)
		end
	end
	return tonumber(weight)
end

RLCore.Player.GetSlotsByItem = function(items, itemName)
	local slotsFound = {}
	if items ~= nil then
		for slot, item in pairs(items) do
			if item.name:lower() == itemName:lower() then
				table.insert(slotsFound, slot)
			end
		end
	end
	return slotsFound
end

RLCore.Player.GetFirstSlotByItem = function(items, itemName)
	if items ~= nil then
		for slot, item in pairs(items) do
			if item.name:lower() == itemName:lower() then
				return tonumber(slot)
			end
		end
	end
	return nil
end

RLCore.Player.CreateCitizenId = function()
	local UniqueFound = false
	local CitizenId = nil

	while not UniqueFound do
		CitizenId = tostring(RLCore.Shared.RandomStr(3) .. RLCore.Shared.RandomInt(5)):upper()
		RLCore.Functions.ExecuteSql(true, "SELECT COUNT(*) as count FROM `players` WHERE `citizenid` = '"..CitizenId.."'", function(result)
			if result[1].count == 0 then
				UniqueFound = true
			end
		end)
	end
	RLCore.Functions.ExecuteSql(false, "INSERT INTO `user_licenses` (`citizenid`, `driver`, `weapon1`, `weapon2`) VALUES ('"..CitizenId.."', '1', '0', '0')")
	return CitizenId
end

RLCore.Player.CreateFingerId = function()
	local UniqueFound = false
	local FingerId = nil
	while not UniqueFound do
		FingerId = tostring(RLCore.Shared.RandomStr(2) .. RLCore.Shared.RandomInt(3) .. RLCore.Shared.RandomStr(4) .. RLCore.Shared.RandomInt(2) .. RLCore.Shared.RandomInt(4))
		RLCore.Functions.ExecuteSql(true, "SELECT COUNT(*) as count FROM `players` WHERE `metadata` LIKE '%"..FingerId.."%'", function(result)
			if result[1].count == 0 then
				UniqueFound = true
			end
		end)
	end
	return FingerId
end

RLCore.Player.CreateWalletId = function()
	local UniqueFound = false
	local WalletId = nil
	while not UniqueFound do
		WalletId = "RL-"..math.random(11111111, 99999999)
		RLCore.Functions.ExecuteSql(true, "SELECT COUNT(*) as count FROM `players` WHERE `metadata` LIKE '%"..WalletId.."%'", function(result)
			if result[1].count == 0 then
				UniqueFound = true
			end
		end)
	end
	return WalletId
end

RLCore.EscapeSqli = function(str)
    local replacements = { ['"'] = '\\"', ["'"] = "\\'" }
    return str:gsub( "['\"]", replacements ) -- or string.gsub( source, "['\"]", replacements )
end

RLCore.AddLicence = function(src, type)
	local cid = RLCore.Functions.GetPlayer(src)
	exports['ghmattimysql']:execute("UPDATE `user_licenses` SET "..type.." = '1' WHERE `citizenid` = @CID", {
		['@CID'] = cid.PlayerData.citizenid
	})
end

RLCore.RevokeLicence = function(src, type)
	local cid = RLCore.Functions.GetPlayer(src)
	exports['ghmattimysql']:execute("UPDATE `user_licenses` SET "..type.." = '2' WHERE `citizenid` = @CID", {
		['@CID'] = cid.PlayerData.citizenid
	})
end

RLCore.Functions.CreateCallback('RLCore:server:checklicence', function(source, cb, type)
	local cid = RLCore.Functions.GetPlayer(source)
	exports['ghmattimysql']:execute("SELECT "..type.." FROM `user_licenses` WHERE `citizenid` = @CID", {['@CID'] = cid.PlayerData.citizenid}, function(result)
		if result[1][type] == 0 then
            k = 'no licence'
        elseif result[1][type] == 1 then
            k = 'has licence'
        elseif result[1][type] == 2 then
            k = 'revoked'
        end
		cb(k)
	end)
end)