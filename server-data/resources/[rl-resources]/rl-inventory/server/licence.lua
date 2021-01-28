RLCore = nil
TriggerEvent('RLCore:GetObject', function(obj) RLCore = obj end)

function NewLicence(src)
	local cid = RLCore.Functions.GetPlayer(src)
	RLCore.Functions.ExecuteSql(false, "INSERT INTO `user_licenses` (`citizenid`, `driver`, `weapon1`, `weapon2`) VALUES ('"..cid.PlayerData.citizenid.."', '0', '0', '0')")
end

function RevokeLicence(src, type)
	local cid = RLCore.Functions.GetPlayer(src)
	exports['ghmattimysql']:execute("UPDATE `user_licenses` SET "..type.." = '2' WHERE `citizenid` = @CID", {
		['@CID'] = cid.PlayerData.citizenid
	})
end

function ReInstateLicence(src, type)
	local cid = RLCore.Functions.GetPlayer(src)
	exports['ghmattimysql']:execute("UPDATE `user_licenses` SET "..type.." = '1' WHERE `citizenid` = @CID", {
		['@CID'] = cid.PlayerData.citizenid
	})
end

RLCore.Functions.CreateCallback('nigger-callback', function(source, cb, type)
	local cid = RLCore.Functions.GetPlayer(source)
	exports['ghmattimysql']:execute("SELECT "..type.." FROM `user_licenses` WHERE `citizenid` = @CID", {['@CID'] = cid.PlayerData.citizenid}, function(result)
		cb(result[1][type])
	end)
end)

RLCore.Functions.CreateCallback('nigger-callback-test', function(source, cb)
	local cid = RLCore.Functions.GetPlayer(source)
	exports['ghmattimysql']:execute("SELECT `driver`, `weapon1`, `weapon2` FROM `user_licenses` WHERE `citizenid` = @CID", {['@CID'] = cid.PlayerData.citizenid}, function(result)
		cb(result)
	end)
end)

function mdttest(src)
	local cid = RLCore.Functions.GetPlayer(src)
	exports['ghmattimysql']:execute("SELECT `driver`, `weapon1`, `weapon2` FROM `user_licenses` WHERE `citizenid` = @CID", {['@CID'] = cid.PlayerData.citizenid}, function(result)
		local names = {'driver', 'weapon1', 'weapon2'}
		print(result[1][names[2]])
	end)
end

--NewLicence(2, 'weapon1')
--RevokeLicence(2, 'weapon1')
--ReInstateLicence(2, 'weapon1')
--CheckForLicence(2, 'weapon1')
mdttest(1)