Utils = {}

Utils.Debug = function(class, message)
    if class == "error" and Debug.debugLevel >= 1 then
        print(Debug.errorDebugColor.."[ERROR]:".. message)
    elseif class == "success" and Debug.debugLevel >= 2 then
        print(Debug.successDebugColor.."[SUCCESS]:".. message)
    elseif class == "inform" and Debug.debugLevel <= 3 then
        print(Debug.informDebugColor.."[INFO]:".. message)
    elseif class ~= error  and class ~= success and class ~= inform then
        print("^1  [ERROR]: Invalid Debug Class: ^0".. class .. "^1 Please use 'error', 'success' or 'inform'.")
    end
end