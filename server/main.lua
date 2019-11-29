ESX = nil
 
TriggerEvent('esx:getSharedObject', function( obj ) ESX = obj end)

ESX.RegisterUsableItem('box_9mm', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('mrw_utils:AmmoBox', _source, '9 mm')
    xPlayer.removeInventoryItem('box_9mm', 1)
end)

ESX.RegisterUsableItem('box_12mm', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('mrw_utils:AmmoBox', _source, '12 mm')
    xPlayer.removeInventoryItem('box_12mm', 1)
end)

ESX.RegisterUsableItem('box_7.62mm', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('mrw_utils:AmmoBox', _source, '7.62 mm')
    xPlayer.removeInventoryItem('box_7.62mm', 1)
end)

ESX.RegisterUsableItem('box_.45ACP', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('mrw_utils:AmmoBox', _source, '.45 ACP')
    xPlayer.removeInventoryItem('box_.45ACP', 1)
end)

ESX.RegisterUsableItem('box_357Magnum', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('mrw_utils:AmmoBox', _source, '357 Magnum')
    xPlayer.removeInventoryItem('box_357Magnum', 1)
end)

ESX.RegisterUsableItem('bulletproof', function(source)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
  
    LoadJson(_source, xPlayer.identifier)
end)
-------

RegisterServerEvent('mrw_utils:DelBProof')
AddEventHandler('mrw_utils:DelBProof', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('bulletproof', 1)
end)

RegisterServerEvent('mrw_utils:ReturnIsNotValid')
AddEventHandler('mrw_utils:ReturnIsNotValid', function(type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if type == '9 mm' then
	    xPlayer.addInventoryItem('box_9mm', 1)	
	elseif type == '12 mm' then
	    xPlayer.addInventoryItem('box_12mm', 1)	
    elseif type == '.45 ACP' then
	    xPlayer.addInventoryItem('box_.45ACP', 1)	
	elseif type == '7.62 mm' then
	    xPlayer.addInventoryItem('box_7.62mm', 1)
    elseif type == '357 Magnum' then
	    xPlayer.addInventoryItem('box_357Magnum', 1)
	end	
end)

local insert = false

RegisterServerEvent('mrw_utils:SaveBproof')
AddEventHandler('mrw_utils:SaveBproof', function(val)

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local id = xPlayer.identifier

	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveBproof.json") 
	LoadBproof = json.decode(loadFile)
	
	if #LoadBproof == 0 then -- if table is empty
            insert = true
	end 

	for i,v in ipairs(LoadBproof) do

		if id == v.users then
		   if tonumber(val) == 0 then 
	              table.remove(LoadBproof, i) 
                   else 
	              table.remove(LoadBproof, i) 
		      insert = true
		   end    
		else 
		    insert = true     
		end 
	end
    
	if insert then 
	   table.insert(LoadBproof, {
	      users = id,
	      value = val
	    }) 
        end		
   SaveResourceFile(GetCurrentResourceName(), "./server/SaveBproof.json", json.encode(LoadBproof, {indent=true}), -1)  
end)	

function LoadJson(_source, identifier)
	local id = identifier
	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./server/SaveBproof.json") 
	LoadBproof = json.decode(loadFile)

	for i,v in ipairs(LoadBproof) do

		if id == v.users then 
			Armour =  v.value
			if Armour ~= nil then 
               Armour = Armour
               Bproof = true
	        end 
	    else 
            Armour = 100   
            Bproof = true     
	    end
    end 

    if #LoadBproof == 0 then -- if table is empty
    	Armour = 100
    	Bproof = true
    end
    	
	if Bproof then 
	    TriggerClientEvent('mrw_utils:bproof', _source, Armour)
	    print(Armour) 
	end    
end
