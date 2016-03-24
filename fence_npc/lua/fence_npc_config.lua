-- Base config table, ignore.
fence_npc = fence_npc or {}

-- Models for the NPC.
fence_npc.models = {"models/humans/Group03/male_02.mdl"}

-- Range at which the NPC will detect items. Keep this low to prevent abuse. (e.g. selling other players' objects through walls without stealing them)
fence_npc.range = 80

-- Sounds the NPC will randomly play when you +use it.
fence_npc.use_sounds = {"scenes/npc/male01/hi01.vcd", "scenes/npc/male01/hi02.vcd"}

-- Sounds the NPC will randomly play when you sell an item to him.
fence_npc.purchase_sounds = {"scenes/npc/male01/fantastic01.vcd", "scenes/npc/male01/fantastic02.vcd", "scenes/npc/male01/nice.vcd", "scenes/npc/male01/thislldonicely.vcd"}

-- List of teams that are allowed to talk to the NPC.
fence_npc.teams = {} -- Base table, ignore.
fence_npc.teams[TEAM_GANG] = true
fence_npc.teams[TEAM_MOB] = true
fence_npc.teams[TEAM_THIEF] = true

-- The text in the menu. Only the first three do anything.
fence_npc.message = {
	"Hey there, kid. Need to get some items",
	"off your hands, quick? I'll take em for ya.",
	"Don't expect exceptional offers, though."
}

-- List of items the NPC is willing to buy.
fence_npc.items = {} -- Base table, ignore.

--[[
Format:
fence_npc.items["entity_class"] = {
	name = "Display Name",
	offer = int money,
	mdl = "path/to/item/model.mdl",
	mdlfov = int fov,
	mdlpos = Vector(x, y, z)
}
--]]

-- You'll have to play around with the mdl[fov/pos] values a bit.
fence_npc.items["money_printer"] = {
	name = "Money Printer",
	offer = 5000,
	mdl = "models/props_c17/consolebox01a.mdl",
	mdlfov = 40,
	mdlpos = Vector(0, 0, 30)
}

fence_npc.items["gunlab"] = {
	name = "Gun Lab",
	offer = 1000,
	mdl = "models/props_c17/TrapPropeller_Engine.mdl",
	mdlfov = 40,
	mdlpos = Vector(0, 0, 38)
}

fence_npc.items["drug_lab"] = {
	name = "Drug Lab",
	offer = 1500,
	mdl = "models/props_lab/crematorcase.mdl",
	mdlfov = 40,
	mdlpos = Vector(0, 0, 30)
}

fence_npc.items["sent_ball"] = {
	name = "Bouncy Ball",
	offer = 300
}

fence_npc.items["drug"] = {
	name = "Drug",
	offer = 500,
	mdl = "models/props_lab/jar01a.mdl",
	mdlfov = 20,
	mdlpos = Vector(0, 0, 40)
}