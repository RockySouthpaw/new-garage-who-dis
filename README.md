# STILL WIP DO NOT USE

## Project Error Discord
- Join the [Discord](https://discord.gg/HYwBjTbAY5) to follow current development of the project.

# Dependencies
- [PolyZone](https://github.com/mkafrin/PolyZone) This ensures the lowest resource use possible as the resource currently uses `0.01 ms` due to no threads being used outside of blips and barrier deletion (Config based). This dependency will exist for the forseable future.
- [Mysql-Async](https://github.com/brouznouf/fivem-mysql-async) **or** [Ghmattisql](https://github.com/GHMatti/ghmattimysql) You will need to set the config to `true`/`false` within the [sv_config.lua](https://github.com/project-error/new-garage-who-dis/blob/main/config/sv_config.lua). 
If using `Ghmattisql`, be sure to comment out `'@mysql-async/lib/MySQL.lua',` within the [fxmanifest](https://github.com/project-error/new-garage-who-dis/blob/7d47586ada8f2275ab0f6497c782d05d3e32144c/fxmanifest.lua#L9).

# Current Dev Commands
- `buy` Will insert the vehicle you're currently sitting in into the NGWD vehicles table.
- `sell` Will delete the vehicle you're currently sitting in from the SQL.
- `spawn` Will spawn a vehicle in the configured spawn zone so long as you're close enough. **You must have at least one purchased vehicle for this.**

# Supported Notifications
*New-Garage-Who-Dis* supports the following notification resources by default:
- [**T-Notify**](https://github.com/TasoOneAsia/t-notify) **(Recomended)** T-Notify offers numerous advantages over any other notification system and has well written [Docs](https://docs.tasoagc.dev/#/). This is the suggested notification system to be used. Please ensure you're on the latest version.
- [**Mythic-Notify**](https://github.com/FlawwsX/mythic_notify) This resource uses `SendAlert` and not the old way of `DoHudText` so this version is **required** if you want to use `Mythic-Notify`.

##### The below Notification Systems use [Floating Notifications](https://i.imgur.com/ZcDa6KV.jpg) for prompts, since they lack simple persistant alerts, while retaining their respective notifications for success/error notifications.
- [**pNotify**](https://forum.cfx.re/t/release-pnotify-in-game-js-notifications-using-noty/20659) 
- **ESX Notifications**

# Documentation
- WIP
- [Git Kraken](https://app.gitkraken.com/glo/board/YEU_GRdxdwARhoP7)

# Contributing
Please make all pull request towards the [**Dev Branch**](https://github.com/project-error/new-garage-who-dis/tree/dev). If you have any suggestions for improvements please contact `ROCKY_southpaw#6771` on **Discord** or in the [**Project Error Discord**](https://discord.gg/HYwBjTbAY5).

# Creating Additional Zones
This is mostly quick and easy thanks to `Polyzone` having an easy way to create zones.

## Generating The Zone
**Step 1**: Within your chat resource, run the command `/pzcreate poly`. Enter a name for your zone. Example: `Legion_1A` 1 corresponds to the blip number found in `cl_config.lua` and `A` denotes its the first zone.

**Step 2**: Move the cursor via the arrow keys on your keyboard and run `/pzadd` when the marker is where you want it.

**Step 3**: When you have the markers you want, run `/pzfinish`. This will save your zone to your `server-data` directory within `polyzone_created_zones.txt`. It will look like so:
```
--Name: MirrorPark_3F | 2021-04-24T19:23:07Z
PolyZone:Create({
  vector2(1025.8822021484, -763.8466796875),
  vector2(1030.9379882812, -767.32965087891),
  vector2(1033.1702880859, -764.11083984375),
  vector2(1028.2648925781, -760.72698974609)
}, {
  name="MirrorPark_3F",
  --minZ = 57.921741485596,
  --maxZ = 58.176242828369
})
```

## Adding Zone (Vehicle Store)
**Step 1**: Navigate to `new-garage-who-dis/client/zones/` and open `cl_storeZones.lua` This is the file pertaining to the zones for storing the player vehicle.

**Step 2**: Navigate to the bottomn of the file and paste the zone you created previously. (Found in `polyzone_created_zones.txt`) Begin formatting it the same as the example below:

```
local MirrorPark_3F = PolyZone:Create({ 
    -- This becomes a local. The 3 corresponds to the blip number found in cl_config.lua and F since it's the sixth zone for this ComboZone.
  vector2(1025.8822021484, -763.8466796875), -- No changes is needed for the coords.
  vector2(1030.9379882812, -767.32965087891),
  vector2(1033.1702880859, -764.11083984375),
  vector2(1028.2648925781, -760.72698974609)
}, {
    name = "MirrorPark_3F", 
    minZ = 56.89493560791, -- You can do - 1 from the z so the zone starts at the floor.
    maxZ = 64.010898590088 -- I usually add 8 or 9 to the minZ so it fits larger vehicles.
})
```

**Step 3**: Now that you've made the local, you need to create the `ComboZone`. This follows the same code format as the ones around it so the only thing you need to change is the names. Refer to the code below:

```
local combo = ComboZone:Create({MirrorPark_3A, MirrorPark_3B, MirrorPark_3C, MirrorPark_3D, MirrorPark_3E, MirrorPark_3F}, {name="Mirror Park", debugPoly=false})
-- These are the same names as you used in the local above. If you made multiple zones, you would need to include them as I did above.
combo:onPlayerInOut(function(isPointInside, point, zone)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if IsPedInVehicle(PlayerPedId(), vehicle, true) and not activeNotification then
            local garageName = "Mirror Park"
            -- This is the name of the garage. This denotes what garage the vehicle is stored at within the SQL and notifications.
            notifyStorePrompt(garageName, NotificationId)
            activeNotification = true
        end
    else
        if activeNotification then 
            notifyEnd(NotificationId)
            activeNotification = false
        end
    end
end)
```
## Adding Zone (Vehicle Retrieve)
**Step 1**: Navigate to `new-garage-who-dis/client/zones/` and open `cl_retrieveZones.lua` This is the file pertaining to the zones for retrieving the player vehicle.

**Step 2**: Navigate to the bottomn of the file and paste the zone you created previously. (Found in `polyzone_created_zones.txt`) Begin formatting it the same as the example below:

```
local retrieveLegion = PolyZone:Create({ -- The name of the zone you created.
    vector2(215.29823303223, -807.74694824219), -- No changes is needed for the coords.
    vector2(213.48683166504, -807.02398681641),
    vector2(212.36161804199, -809.87066650391),
    vector2(214.19085693359, -810.56799316406)
}, {
    name="retrieveLegion", -- The name of the zone you created.
    minZ = 30.044890670776, -- You can do - 1 from the z so the zone starts at the floor.
    maxZ = 32.8, -- Since only a person will be using these, you don't need to make them very tall.
    lazyGrid=true, -- Keep this true
    debugPoly=false -- Keep this false unless you want to view the Polyzone you created.
})
```

**Step 3**: Now that you've made the local, you need to create the zone. This follows the same code format as the ones around it so the only thing you need to change is the names. Refer to the code below:

```
retrieveLegion:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
-- This is the same name as you used in the local above. 
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not RetrieveNotification then
                local garageName = "Legion"
                -- This is the name of the garage. This denotes what garage the player is accessing.
                notifyRetrievePrompt(garageName, NotificationId)
                RetrieveNotification = true
            end
        end
    else
        if RetrieveNotification then 
            notifyEnd(NotificationId)
            RetrieveNotification = false
        end
    end
end)
```

## Adding Zone (Vehicle Retrieve Multiple Zones)
**WIP**