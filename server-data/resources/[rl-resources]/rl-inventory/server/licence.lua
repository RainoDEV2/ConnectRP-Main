RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

RegisterNetEvent('tp_gunschool:addLicense')
AddEventHandler('tp_gunschool:addLicense', function(type)

	TriggerEvent('esx_license:addLicense', source, type, function()
		--TriggerEvent('esx_license:getLicenses', source, function(licenses)
			--[[ TriggerClientEvent('tp_gunschool:loadLicenses', _source, licenses) ]]
		--end)
	end) 
end)

function AddLicense(target, type, cb) -- source, weapon, callback (MAYBE IM MISSING SOMETHING HERE AND ITS GETTING CONFUSSED?)
	print("YEET")
	local xPlayer = RLCore.Functions.GetPlayer(target) 
	local identifier = GetPlayerIdentifier(target, 0) 

	exports['ghmattimysql']:execute('INSERT INTO user_licenses (type, citizenid, owner) VALUES (@type, @citizenid, @owner)', {
		['@type']  = type,
		['@citizenid'] = xPlayer.PlayerData.citizenid,
		['@owner'] = identifier
	}, function(rowsChanged)
		if cb ~= nil then
			cb() 
		end 
	end)
end

function RemoveLicense(target, type, cb)
	local identifier = GetPlayerIdentifier(target, 0)

    RLCore.Functions.ExecuteSql(false, 'DELETE FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
    }, function(rowsChanged)

		if cb ~= nil then
			cb()
		end 
	end)
end

function RevokeLicense(target, type, cb)
	local identifier = GetPlayerIdentifier(target, 0)

	RLCore.Functions.ExecuteSql(false, 'UPDATE user_licenses SET revoked = not revoked WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
    }, function(rowsChanged)
        
		if cb ~= nil then
			cb()
		end
	end)
end

function GetLicense(type, cb)

	exports['ghmattimysql']:execute('SELECT * FROM licenses WHERE type = @type', {
        ['@type'] = type
    }, function(result)

    --[[ RLCore.Functions.ExecuteSql(false, 'SELECT * FROM licenses WHERE type = @type', {
        ['@type'] = type
    }, function(result) ]]

		local data = {
			type  = type,
			label = result[1].label
		}

		cb(data)
	end)
end



function GetLicenses(target, cb)
	local xPlayer = RLCore.Functions.GetPlayer(target) 
	local identifier = GetPlayerIdentifier(target, 0) 

    RLCore.Functions.ExecuteSql(false, 'SELECT * FROM user_licenses WHERE owner = @owner', {
        ['@owner'] = identifier
	}, function(result)
		
		

		local licenses   = {}
        local asyncTasks = {}

        for i=1, #result, 1 do
			local scope = function(type, revoked)
				table.insert(asyncTasks, function(cb)

                    RLCore.Functions.ExecuteSql(false, 'SELECT * FROM licenses WHERE type = @type', {
                        ['@type'] = type
                    }, function(result2)
                        
                        if revoked == 1 then
                            status = "<span style='color:red'>Revoked</span>"
                        else
                            status = "<span style='color:green'>Active</span>"
                        end

						table.insert(licenses, {
							type  = type,
                            label = result2[1].label .. " Status: " ..status,
                            status = revoked
						})

						cb()
					end)
				end)
			end

			scope(result[i].type, result[i].revoked)

		end

		Async.parallel(asyncTasks, function(results)
			cb(licenses)
		end)

	end)
end

function CheckLicense(target, type, cb)
	local identifier = GetPlayerIdentifier(target, 0)

	RLCore.Functions.ExecuteSql(false, 'SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
        ['@type']  = type,
        ['@owner'] = identifier
    }, function(result)
        
        
		if tonumber(result[1].count) > 0 then
			cb(true)
		else
			cb(false)
		end

	end)
end

function GetLicensesList(cb)
	RLCore.Functions.ExecuteSql(false, 'SELECT * FROM licenses', {
        ['@type'] = type
    }, function(result)
        
		local licenses = {}

		for i=1, #result, 1 do
			table.insert(licenses, {
				type  = result[i].type,
				label = result[i].label
			})
		end

		cb(licenses) 
	end)
end

RegisterServerEvent('rlcore:checkLicence')
AddEventHandler("rlcore:checkLicence", function(shop, shopitems)
  local source = source
  local xPlayer = RLCore.Functions.GetPlayer(source)
  exports['ghmattimysql']:execute('SELECT type FROM user_licenses WHERE citizenid = "' .. xPlayer.PlayerData.citizenid .. '" AND type = @licence AND revoked = 0', {
	['@licence'] = "weapon"},  
	function(result)
		--print(json.encode(result[1]))
		if(result[1] == nil) then
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have a license!' })
		else
			TriggerClientEvent('rlshopsclient:inv', source, shop, shopitems)
			print("Sent to client")
		end
	end)
end)

RegisterNetEvent('esx_license:addLicense')
AddEventHandler('esx_license:addLicense', function(target, type, cb)
	AddLicense(target, type, cb)
end)

RegisterNetEvent('esx_license:removeLicense')
AddEventHandler('esx_license:removeLicense', function(target, type, cb)
	RemoveLicense(target, type, cb)
end)

RegisterNetEvent('esx_license:revokeLicense')
AddEventHandler('esx_license:revokeLicense', function(target, type, cb)
	RevokeLicense(target, type, cb)
end)

AddEventHandler('esx_license:getLicense', function(type, cb)
	GetLicense(type, cb)
end)

AddEventHandler('esx_license:getLicenses', function(target, cb)
	GetLicenses(target, cb)
end)

AddEventHandler('esx_license:checkLicense', function(target, type, cb)
	CheckLicense(target, type, cb)
end)

AddEventHandler('esx_license:getLicensesList', function(cb)
	GetLicensesList(cb)
end) 

RLCore.Functions.CreateCallback('esx_licence:getLicense', function(source, cb, type)
	GetLicense(type, cb)
end)

RLCore.Functions.CreateCallback('esx_licence:getLicenses', function(source, cb, target)
	GetLicenses(target, cb)
end)

RLCore.Functions.CreateCallback('esx_licence:checkLicense', function(source, cb, target, type)
	CheckLicense(target, type, cb)
end)

RLCore.Functions.CreateCallback('esx_licence:getLicensesList', function(source, cb)
	GetLicensesList(cb)
end)