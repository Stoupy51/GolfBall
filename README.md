
# Golf Ball
[![GitHub](https://img.shields.io/github/v/release/Stoupy51/GolfBall?logo=github&label=GitHub)](https://github.com/Stoupy51/GolfBall/releases/latest)
[![Smithed](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fapi.smithed.dev%2Fv2%2Fpacks%2Fgolf_ball%2Fmeta&query=%24.stats.downloads.total&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiIgdmlld0JveD0iMCAwIDQgNCIgeG1sbnM6dj0iaHR0cHM6Ly92ZWN0YS5pby9uYW5vIj48cGF0aCBkPSJNLjczNy44NTlsLjg4Ny0uMjg1Yy4wOTktLjAzMi4yMDUtLjAzMi4zMDQgMGwxLjMzNS40MjktMS4wNC4zMzR6bS0uMTk1LjE4OXYuNDg3YzAgLjEwNS4wNjguMTk5LjE2OC4yMzFsMS41MTQuNDg3TDMuMjkgMS45MWMuMS0uMDMyLjE2OC0uMTI2LjE2OC0uMjMxdi0uNDg3bC0xLjIzNC4zOTF6bS44NTkgMS4xOWwuODIzLjI2LjQxMi0uMTI3di4zNzlsLS40MTIuMTMyLS44MjMtLjI2NHptLS40NDguNTA1di4yOTlsMS4yNzIuNDA4LjgyMy0uMjY0di0uM2wtLjgyMy4yNTl6IiBwYWludC1vcmRlcj0ic3Ryb2tlIGZpbGwgbWFya2VycyIgZmlsbD0iIzFiNDhjNCIvPjwvc3ZnPg%3D%3D&logoColor=224bbb&label=Smithed&labelColor=black&color=224bbb)](https://smithed.net/packs/golf_ball)
[![Modrinth](https://img.shields.io/modrinth/dt/golf_ball?logo=modrinth&label=Modrinth)](https://modrinth.com/datapack/golf_ball)
[![Discord](https://img.shields.io/discord/1216400498488377467?label=Discord&logo=discord)](https://discord.gg/anxzu6rA9F)
[![Python Datapack](https://img.shields.io/github/v/release/Stoupy51/python_datapack?logo=github&label=Python%20Datapack)](https://github.com/Stoupy51/PythonDatapackTemplate)

📺 Old datapack showcase: https://www.youtube.com/watch?v=TqVvRwF2psQ

🏌️ Golf Ball is a datapack that transforms you into a golf ball in Minecraft, offering an immersive golfing experience!<br>
⛳ The following two commands are your best friends:
- 🎮 `/function golf_ball:summon`: Turns the player executing the command into a golf ball (e.g: `/execute as <player> positioned 123 100 54 run function golf_ball:summon`)
- 🔄 `/function golf_ball:respawn`: Rolls back the ball to the last shot position (e.g: `/execute as <player> run function golf_ball:respawn`)


## Configuration Commands ⚙️
Fine-tune your golfing experience with these powerful configuration commands!<br>
Customize ball physics, movement dynamics, power settings and more - either globally for all new balls or locally for individual balls. 🎮

⚠️ Using `/scoreboard players set` for all commands below (abbreviated as `/SPS`)

### Core Settings 🎯

| Setting | Global Command | Local Command | Default | Range | Description |
|---------|---------------|---------------|----------|--------|-------------|
| Strength Percentage 💪 | `/SPS #default_strength_percentage golf_ball.data <value>` | `/SPS @s golf_ball.strength_percentage <value>` | 50 | 0-100 | Controls the overall power of your shots |
| Energy Loss 📉 | `/SPS #default_energy_loss_percentage golf_ball.data <value>` | `/SPS @s golf_ball.energy_loss_percentage <value>` | -90 | -100-0 | Determines how much energy is lost on impacts |
| Collision Multiplier 💥 | `/SPS #default_collision_multiplier golf_ball.data <value>` | `/SPS @s golf_ball.collision_multiplier <value>` | 50 | 0-100 | Adjusts the intensity of collisions |
| Y-Shots 🔼 | `/SPS #default_do_y_shots golf_ball.data <value>` | `/SPS @s golf_ball.do_y_shots <value>` | 0 | 0 or 1 | Enables/disables vertical shots |
| Collision Detection 🎯 | `/SPS #default_do_collision golf_ball.data <value>` | `/SPS @s golf_ball.do_collision <value>` | 1 | 0 or 1 | Toggles collision physics |
| Minimum Power ⬇️ | `/SPS #min_power golf_ball.data <value>` | N/A | 40 | N/A | Sets the lower power limit |
| Maximum Power ⬆️ | `/SPS #max_power golf_ball.data <value>` | N/A | 500 | N/A | Sets the upper power limit |

### Surface Friction Settings ⚡
Control how the ball behaves on different surfaces by adjusting friction values. Each value represents the percentage of speed retained per tick.

| Surface Type | Global Command | Local Command | Default | Range | Best For |
|----------|--------------------------------|--------------------------------|---------------|--------|-----------|
| Normal Friction 🔄 | `/SPS #k_normal golf_ball.data <value>` | `/SPS @s golf_ball.friction_normal <value>` | 90 | 0-100 | Standard terrain |
| Fast Friction 🏃 | `/SPS #k_fast golf_ball.data <value>` | `/SPS @s golf_ball.friction_fast <value>` | 95 | 0-100 | Smooth surfaces |
| Slippery Friction 🧊 | `/SPS #k_slippery golf_ball.data <value>` | `/SPS @s golf_ball.friction_slippery <value>` | 98 | 0-100 | Ice and similar |
| Slow Friction 🐌 | `/SPS #k_slow golf_ball.data <value>` | `/SPS @s golf_ball.friction_slow <value>` | 85 | 0-100 | Rough terrain |
| Very Slow Friction 🦥 | `/SPS #k_very_slow golf_ball.data <value>` | `/SPS @s golf_ball.friction_very_slow <value>` | 80 | 0-100 | Heavy resistance |

### Usage Tips 💡
- 🎯 For local commands targeting a specific ball, use this format: `/execute as <player> on vehicle run scoreboard players set @s golf_ball.strength_percentage <value>`
- 🎮 The "@s" selector refers to the golf ball currently being controlled by the player
- ⚡ Surface friction values dramatically affect ball behavior - experiment to find the perfect settings!
- 📁 View all available surface definitions in the [surfaces.json](https://github.com/Stoupy51/GolfBall/blob/main/build/datapack/data/golf_ball/tags/block/surfaces.json) file
- ⚠️ You may have fun with unrealistic configurations, but the physics will be wonky!

