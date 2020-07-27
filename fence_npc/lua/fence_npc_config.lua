AddCSLuaFile()

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
fence_npc.teams[TEAM_GANG] = true
fence_npc.teams[TEAM_MOB] = true
fence_npc.teams[TEAM_THIEF] = true

-- Localization Settings
fence_npc.locale = {} -- Base table, ignore.

fence_npc.locale.localLang = "en" --Set this to your language from the list below, or add your own (See below for instructions)
--[[
Available Languages:
	en		-	English
	es		-	Spanish
	ru      -   Russian
]]

--[[
Localization Tables
 -> To create a new language, copy the entire 'en' table below and paste it as its own table.
 -> Change 'en' to whatever code you wish to use for your language.
 -> Go through and edit the strings in your language table.
 -> Change fence_npc.localizations.localLang = "en" to whatever language string you choose.
]]
fence_npc.locale["en"] = {
	msg1 		= 	"Hey there, kid. Need to get some items",		--Menu line 1
	msg2 		= 	"off your hands, quick? I'll take em for ya.",	--Menu line 2
	msg3 		= 	"Don't expect exceptional offers, though.",		--Menu line 3
	title 		=	"Stolen Item Fence", 							--Menu Window Title
	headTitle 	=	"Stolen Item Fence", 							--Menu Window Title
	button 		=	"Take these.", 									--Menu Accept Button
	reject1 	=	"Get out of here...", 							--Reject - Invalid Job
	reject2 	=	"Bring me stuff to sell...", 					--Reject - Nothing to sell
	offer 		=	"Total Offer", 									--Total offer text
	a_offer 	=	"All Offers" 									--All offers button text
}

fence_npc.locale["es"] = {
	msg1 		= 	"¿Necesitas sacarte algunas cosas de",			--Menu line 1
	msg2 		= 	"tus manos ya? Yo te las compro.",				--Menu line 2
	msg3 		= 	"No vayas a esperar buenas ofertas...",			--Menu line 3
	title 		=	"Mercado Negro", 								--Menu Window Title
	headTitle 	=	"Mercado Negro", 								--Menu Window Title
	button 		=	"Vender", 										--Menu Accept Button
	reject1 	=	"Vete de aqui...", 								--Reject - Invalid Job
	reject2 	=	"Traeme cosas que quieras vender...", 			--Reject - Nothing to sell
	offer 		=	"Oferta Total", 								--Total offer text
	a_offer 	=	"Mis ofertas" 									--All offers button text
}

fence_npc.locale["ru"] = {
	msg1 		= 	"Привет, малыш. Нужно быстро убрать с рук",		--Menu line 1
	msg2 		= 	"какие-то вещи? Я заберу их у тебя.",	        --Menu line 2
	msg3 		= 	"Но не ожидай исключительных предложений.",  	--Menu line 3
	title 		=	"Скупщик краденых вещей", 						--Menu Window Title
	headTitle 	=	"Скупщик краденых вещей", 						--Menu Window Title
	button 		=	"Забирай.", 									--Menu Accept Button
	reject1 	=	"Убирайся отсюда...", 							--Reject - Invalid Job
	reject2 	=	"Принеси мне вещи, которые можно продать...",   --Reject - Nothing to sell
	offer 		=	"Общее предложение", 						    --Total offer text
	a_offer 	=	"Все предложения" 								--All offers button text
}

-- Display customization
fence_npc.display = {} -- Base table, ignore.
fence_npc.display.color = {}  -- Base table, ignore.

-- Should draw entity name for entries on the list?
fence_npc.display.drawEntityName = false

-- Should draw floating title text above the npc?
fence_npc.display.drawFloatingText = true

--Default Blue & White theme
fence_npc.display.color.button 			= Color(33, 150, 243)		-- Title bar and accept button color
fence_npc.display.color.button_text 	= Color(255, 255, 255)		-- Title bar and accept button text color
fence_npc.display.color.scrollbar 		= Color(33, 150, 243, 225)	-- Scrollbar color
fence_npc.display.color.close_hover 	= Color(211, 47, 47)		-- Close button color when mouse hovers over it
fence_npc.display.color.background 		= Color(255, 255, 255)		-- Background color
fence_npc.display.color.background_text = Color(0, 0, 0)			-- Background text color
fence_npc.display.color.item_background = Color(66, 66, 66, 255)	-- Item Entry Background color
fence_npc.display.color.item_title 		= Color(255, 255, 255, 255)	-- Item Entry Title text color
fence_npc.display.color.item_price 		= Color(76, 175, 80, 255)	-- Item Entry Price text color
fence_npc.display.color.item_entname  	= Color(255, 255, 255, 20)	-- Item Entry EntityName text color

--Alternative Orange & Black Theme
--fence_npc.display.color.button 			= Color(228, 100, 75)		-- Title bar and accept button color
--fence_npc.display.color.button_text 	= Color(255, 255, 255)		-- Title bar and accept button text color
--fence_npc.display.color.scrollbar 		= Color(228, 100, 75, 225)	-- Scrollbar color
--fence_npc.display.color.close_hover 	= Color(211, 47, 47)		-- Close button color when mouse hovers over it
--fence_npc.display.color.background 		= Color(32, 32, 32)			-- Background color
--fence_npc.display.color.background_text = Color(255, 255, 255)		-- Background text color
--fence_npc.display.color.item_background = Color(66, 66, 66, 255)	-- Item Entry Background color
--fence_npc.display.color.item_title 		= Color(255, 255, 255, 255)	-- Item Entry Title text color
--fence_npc.display.color.item_price 		= Color(76, 175, 80, 255)	-- Item Entry Price text color
--fence_npc.display.color.item_entname  	= Color(255, 255, 255, 20)	-- Item Entry EntityName text color


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