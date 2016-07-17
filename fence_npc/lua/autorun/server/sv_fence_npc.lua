--[[
Copyright 2016 10se1ucgo
https://github.com/10se1ucgo/

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--]]
local saved_path = function() return "fence_npc/" .. string.lower(game.GetMap()) .. ".txt" end
local fence_npcs = {}
local help_msg = "Invalid arguments!\nUse 'fence_npc save' to save all locations.\nUse 'fence_npc delete' to delete all locations.\nUse 'fence_npc respawn' to respawn all locatons.\nUse 'fence_npc reload' to force reload the config file."

hook.Add("loadCustomDarkRPItems", "fence_npc_config_load", function() include('fence_npc_config.lua') end) -- Load config after DarkRP inits so TEAM enums are valid.
hook.Add("InitPostEntity", "fence_npc_load", function() timer.Simple(3, fence_npc_load) end) -- Load all saved NPCs
concommand.Add("fence_npc", function(ply, cmd, args)
	if not ply:IsSuperAdmin() then
		ply:PrintMessage(HUD_PRINTCONSOLE, "Superadmin only!")
		return
	end

	if args[1] == "save" then
		fence_npc_save(ply)
	elseif args[1] == "delete" then
		fence_npc_delete(ply)
	elseif args[1] == "respawn"then
		fence_npc_load(ply)
	elseif args[1] == "reload" then
		include('fence_npc_config.lua')
		ply:PrintMessage(HUD_PRINTCONSOLE, "Config reloaded.")
	else
		ply:PrintMessage(HUD_PRINTCONSOLE, help_msg)
		return
	end
end)

function fence_npc_load(ply)
	if not file.Exists("fence_npc", "DATA") then
		file.CreateDir("fence_npc")
	end

	if not file.Exists(saved_path(), "DATA") then
		if ply != nil then
			ply:PrintMessage(HUD_PRINTCONSOLE, "No Fence NPC locations to respawn!")
		end
		return
	end

	for index, fence_ent in pairs(ents.FindByClass("fence_npc")) do fence_ent:Remove() end

	fence_npcs = util.JSONToTable(file.Read(saved_path(), "DATA"))
	for index, ent in pairs(fence_npcs) do
		local fence_npc = ents.Create("fence_npc")
		if IsValid(fence_npc) then
			fence_npc:SetPos(ent.pos)
			fence_npc:SetAngles(ent.ang)
			fence_npc:Spawn()
		end
	end
	print("Spawned " .. #fence_npcs .. " Fence NPCs.")
	if ply != nil then
		ply:PrintMessage(HUD_PRINTCONSOLE, "Spawned " .. #fence_npcs .. " Fence NPCs.")
	end
end

function fence_npc_save(ply)
	fence_npcs = {}
	local all_fence_npcs = ents.FindByClass("fence_npc")

	if #all_fence_npcs == 0 then
		print("No NPCs to save!")
		return
	end

	for index, ent in pairs(all_fence_npcs) do
		local npc_data = {}
		npc_data.pos = ent:GetPos()
		npc_data.ang = ent:GetAngles()
		table.insert(fence_npcs, npc_data)
	end

	file.Write(saved_path(), util.TableToJSON(fence_npcs))
	print("Saved " .. #fence_npcs .. " NPC locations")
	ply:PrintMessage(HUD_PRINTCONSOLE, "Saved " .. #fence_npcs .. " NPC locations")
end

function fence_npc_delete(ply)
	fence_npcs = {}
	if not file.Exists(saved_path(), "DATA") then
		ply:PrintMessage(HUD_PRINTCONSOLE, "No locations to delete!")
		return
	end

	file.Delete(saved_path())
	for num, ent in pairs(ents.FindByClass("fence_npc")) do ent:Remove() end
	print("Deleted all NPC locations")
	ply:PrintMessage(HUD_PRINTCONSOLE, "Deleted all NPC locations")
end
