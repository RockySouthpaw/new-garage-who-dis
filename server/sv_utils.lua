Utils = {}
local debugTypes    = "success, error, inform, dev"

Utils.Debug = function(class, message)
    if Debug.setActive then
        if class == "error" then
            return print(Debug.errorDebugColor.."[ERROR]:"..message.."^7")
        elseif class == "success" then
            return print(Debug.successDebugColor.."[SUCCESS]:"..message.."^7")
        elseif class == "inform" then
            return print(Debug.informDebugColor.."[INFO]:"..message.."^7")
        elseif class == "dev" then
            return print(Debug.devDebugColor.."[DEBUG]:".. message .. "^7")
        end
        print("^1[ERROR]: Invalid Debug Class: ^0".. class .. "^1 Please use "..debugTypes..".^7")
    end
end

Utils.getPlayerIdentifier = function(playerId)
    local identifier
    for k, v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, Config.Identifier) then
			identifier = v
			break
		end
    end
    return identifier
end

Utils.getVehicleModelName = function(modelHash)
    if not modelHash or modelHash == 0 then
        return "On Foot?"
    end
    for _, v in pairs(Model.hashList) do
        if modelHash == v.modelHash then
            return v.modelName
        end
    end
end

Utils.getState = function(playerId, stateBag)
    local player = Player(playerId)
    return player.state[stateBag]
end

Utils.failedCheck = function(playerId, checkType)
    Utils.Debug('error', "Player: ["..playerId.."] failed check: "..checkType)
    -- Do whatever here such as discord logging or kicking.
end

Utils.setState = function(playerId, stateBag, bool, replicated)
    local player = Player(playerId)
    if replicated == nil then replicated = false end
    player.state:set(stateBag, bool, replicated)
end

CreateThread(function()
	local updatePath = '/project-error/new-garage-who-dis'
	local resourceName = "^5["..GetCurrentResourceName().."]^2"

	function checkVersion(err,responseText, headers)
		local curVersion = LoadResourceFile(GetCurrentResourceName(), "version")
		if responseText == nil or curVersion == nil then
            Utils.Debug('error', " "..resourceName.."^1- Update check failed. Response was nil")
		elseif curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
            print("\n^1###############################")
			print("\n"..resourceName.." is outdated.")
            print("\nThe latest stable version is "..responseText..", your version is ("..curVersion..")\n\nPlease download the latest stable build from https://github.com/project-error/new-garage-who-dis")
			print("\n^1###############################")
		elseif(tonumber(curVersion) > tonumber(responseText)) then
			Utils.Debug("inform","You may be using a pre-release of ^8["..GetCurrentResourceName().."]^5 or the GitHub went offline.")
		else
			if GetConvar('onesync') == "on" then
				Utils.Debug("success",""..resourceName..' (v'..responseText..") is up to date and has started.")
			else
				Utils.Debug("error",""..resourceName..' (v'..responseText..")^1 is up to date but ^2[OneSync]^1 isn't enabled.\n ^1This resource requires ^2[OneSync]^1 to function correctly.")
			end
		end
	end

	PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/dev/version", checkVersion, "GET")
end)

for i = 1, #Config.usedStates do
    local state = Config.usedStates[i]
    AddStateBagChangeHandler(state --[[key filter]], false --[[bag filter]], function(bagName, key, value, source, replicated)
        local playerNet = tonumber(bagName:gsub('player:', ''), 10)
        Utils.Debug('dev', "bagName: ["..bagName.."] key: ["..key.."] value: ["..tostring(value).."] source: ["..source.."] replicated: ["..tostring(replicated).."] playerNet: ["..playerNet.."]")
        -- just used for debugging states atm. Can be used for other things later.
    end)
end