# STILL WIP DO NOT USE

## Current State
Resource is mostly done, however, the UI still has to be made. While numerous people have said they will make it, none have yet to do so. 

## Dependencies
- [PolyZone](https://github.com/mkafrin/PolyZone) This ensures the lowest resource use possible as the resource currently uses `0.01 ms` due to no threads being used outside of blips and barrier deletion (Config based). This dependency will exist for the forseable future.
- [Oxmysql](https://github.com/overextended/oxmysql)

## Current Dev Commands
- `buy` Will insert the vehicle you're currently sitting in into the NGWD vehicles table.
- `sell` Will delete the vehicle you're currently sitting in from the SQL.
- `spawn` Will spawn a vehicle in the configured spawn zone so long as you're close enough. **You must have at least one purchased vehicle for this.**

## Supported Notifications
*New-Garage-Who-Dis* supports the following notification resources by default:
- [**T-Notify**](https://github.com/TasoOneAsia/t-notify) **(Recomended)** T-Notify offers numerous advantages over any other notification system and has well written [Docs](https://docs.tasoagc.dev/#/). This is the suggested notification system to be used. Please ensure you're on the latest version.
- [**Mythic-Notify**](https://github.com/FlawwsX/mythic_notify) This resource uses `SendAlert` and not the old way of `DoHudText` so this version is **required** if you want to use `Mythic-Notify`.

##### The below Notification Systems use [Floating Notifications](https://i.imgur.com/ZcDa6KV.jpg) for prompts, since they lack simple persistant alerts, while retaining their respective notifications for success/error notifications.
- [**pNotify**](https://forum.cfx.re/t/release-pnotify-in-game-js-notifications-using-noty/20659) 
- **ESX Notifications**

## Documentation
- WIP
- [Git Kraken](https://app.gitkraken.com/glo/board/YEU_GRdxdwARhoP7)

## Contributing
Please make all pull request towards the [**Dev Branch**](https://github.com/project-error/new-garage-who-dis/tree/dev). If you have any suggestions for improvements please contact `ROCKY_southpaw#6771` on **Discord**.
