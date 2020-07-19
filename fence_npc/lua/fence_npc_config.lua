-- Base config table, ignore.
fence_npc = fence_npc or {}

-- Models for the NPC.
fence_npc.models = {"models/humans/Group03/male_02.mdl"}

-- Range at which the NPC will detect items. Keep this low to prevent abuse. (e.g. selling other players' objects through walls without stealing them)
fence_npc.range = 80

-- Sounds the NPC will randomly play when you +use it, but you do not belong to the whitelisted teams below.
fence_npc.reject_sounds = {"scenes/npc/male01/gethellout.vcd", "scenes/npc/male01/answer17.vcd"}

-- Sounds the NPC will randomly play when you +use it, but you no valid items are near the npc.
fence_npc.noitem_sounds = {"scenes/npc/male01/gordead_ans10.vcd", "scenes/npc/male01/answer25.vcd", "scenes/npc/male01/answer05.vcd"}

-- Sounds the NPC will randomly play when you +use it.
fence_npc.use_sounds = {"scenes/npc/male01/hi01.vcd", "scenes/npc/male01/hi02.vcd"}

-- Sounds the NPC will randomly play when you sell an item to him.
fence_npc.purchase_sounds = {"scenes/npc/male01/fantastic01.vcd", "scenes/npc/male01/fantastic02.vcd", "scenes/npc/male01/nice.vcd", "scenes/npc/male01/thislldonicely.vcd"}

-- List of teams that are allowed to talk to the NPC.
fence_npc.teams = {} -- Base table, ignore.
--fence_npc.teams[TEAM_LADRON] = true
fence_npc.teams[TEAM_GANG] = true
fence_npc.teams[TEAM_MOB] = true
fence_npc.teams[TEAM_THIEF] = true

-- The text in the menu. Only the first three do anything.
fence_npc.message = {
	"Hey there, kid. Need to get some items",		--Menu text
	"off your hands, quick? I'll take em for ya.",	--Menu text
	"Don't expect exceptional offers, though.",		--Menu text
	"Stolen Item Fence",							--Menu Window Title
	"Yeah, I do.",									--Menu Accept Button
	"Get out of here...",							--Reject - Invalid Job
	"Bring me stuff to sell..."						--Reject - Nothing to sell
}

-- Display customization

-- Should draw entity name for entries on the list?
fence_npc.displaySettings_drawEntityName = false

fence_npc.displaySettings_colorTable = { --Only modifications allowed.
	Color(33, 150, 243),		-- Title bar and accept button color
	Color(255, 255, 255),		-- Title bar and accept button text color
	Color(33, 150, 243, 225),	-- Scrollbar color
	Color(211, 47, 47),			-- Close button color when mouse hovers over it
	Color(255, 255, 255),		-- Background color
	Color(0, 0, 0),				-- Background text color
	Color(66, 66, 66, 255),		-- Item Entry Background color
	Color(255, 255, 255, 255),	-- Item Entry Title text color
	Color(76, 175, 80, 255),	-- Item Entry Price text color
	Color(255, 255, 255, 20)	-- Item Entry EntityName text color
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