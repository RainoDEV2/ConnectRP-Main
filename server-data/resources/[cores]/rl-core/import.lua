if GetCurrentResourceName() == 'rl-core' then 
    function GetSharedObject()
        return RLCore
    end

    exports('GetSharedObject', GetSharedObject)
end

RLCore = exports['rl-core']:GetSharedObject()