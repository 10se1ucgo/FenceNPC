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
include('shared.lua')
include('fence_npc_config.lua')

surface.CreateFont("fence_npc_item", {font = "Roboto", size = 16})
surface.CreateFont("fence_npc_text", {font = "Roboto", size = 18})
surface.CreateFont("fence_npc_title", {font = "Roboto", size = 23})


function ENT:Draw()
	-- Draw the model
	self:DrawModel()
	if fence_npc.display.drawFloatingText then
		--local pos = self:GetBonePosition(self:LookupBone("ValveBiped.Bip01_Head1")) + Vector( 0, 0, 15 ) -- SLOWER
		local pos = self:GetBonePosition(6) + Vector( 0, 0, 15 ) --FASTER, if text draws incorrectly, use the one above.
		local ang = Angle( 0, SysTime() * 50 % 360, 90 )
		Draw3DText( pos, ang, 0.2, fence_npc.locale[fence_npc.locale.localLang].headTitle, false )
		Draw3DText( pos, ang, 0.2, fence_npc.locale[fence_npc.locale.localLang].headTitle, true )
	end
end

function fence_npc_draw_menu()
	local ent = net.ReadEntity()
	local closeEntities = net.ReadTable()

	local frame = vgui.Create("DFrame")
	local frame_height = 190
	frame:SetSize(390, frame_height)
	frame:Center()
	frame:SetTitle('')
	frame:SetVisible(true)
	frame:SetSizable(true)
	frame:SetDraggable(true)
	frame:ShowCloseButton(false)
	frame:MakePopup()
	frame.Paint = function(self, w, h)
		drawBlurRectangle(0, 0, 0, w, h, fence_npc.display.color.background)
		drawBlurRectangle(0, 0, 0, w, 32, fence_npc.display.color.button)

		--[[ Draw Material hamburger menu icon (So stupid, why did I even do this?)
		surface.SetDrawColor(255, 255, 255)
		surface.DrawLine(7, 10, 25, 10)
		surface.DrawLine(7, 11, 25, 11)
		surface.DrawLine(7, 15, 25, 15)
		surface.DrawLine(7, 16, 25, 16)
		surface.DrawLine(7, 20, 25, 20)
		surface.DrawLine(7, 21, 25, 21)
		--]]

		surface.SetFont("fence_npc_title")
		surface.SetTextColor(fence_npc.display.color.button_text)
		surface.SetTextPos(7, 5)
		surface.DrawText(fence_npc.locale[fence_npc.locale.localLang].title)

		surface.SetFont("fence_npc_text")
		surface.SetTextColor(fence_npc.display.color.background_text)
		surface.SetTextPos(110, 45)
		surface.DrawText(fence_npc.locale[fence_npc.locale.localLang].msg1)
		surface.SetTextPos(110, 63)
		surface.DrawText(fence_npc.locale[fence_npc.locale.localLang].msg2)
		surface.SetTextPos(110, 81)
		surface.DrawText(fence_npc.locale[fence_npc.locale.localLang].msg3)
		
		--Draw total offer
		surface.SetFont("fence_npc_title")
		surface.SetTextColor(fence_npc.display.color.item_price)
		surface.SetTextPos(0 + 10, h - 35)
		surface.DrawText( fence_npc.locale[fence_npc.locale.localLang].offer .. ": $" .. getTotalOffer(fence_npc.items, closeEntities) )
	end

	local close_color = fence_npc.display.color.button
	local close_button = vgui.Create('DButton', frame)
	close_button:SetSize(46, 30)
	close_button:SetPos(frame:GetWide() - close_button:GetWide() - 1, 1)
	close_button:SetFont("fence_npc_text")
	close_button:SetText('X')
	close_button:SetColor(fence_npc.display.color.button_text)
	close_button.DoClick = function() frame:Close() end
	close_button.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, close_color)
	end
	close_button.OnCursorEntered = function()
		close_color = fence_npc.display.color.close_hover
	end
	close_button.OnCursorExited = function()
		close_color = fence_npc.display.color.button
	end

	local model_icon = vgui.Create("DModelPanel", frame)
	model_icon:SetSize(100, 100)
	model_icon:SetPos(10, 45)
	model_icon:SetModel(ent:GetModel())
	model_icon:SetFOV(9)
	model_icon:GetEntity():SetAngles(Angle(-6, 60, 0))
	model_icon:GetEntity():SetPos(Vector(0, 0, -26))
	function model_icon:LayoutEntity(ent)
		return
	end

	local item_scroll_panel = vgui.Create("DScrollPanel", frame)
	item_scroll_panel:SetPos(5, 150)
	item_scroll_panel:SetSize(380, 400)

	local scroll_bar = item_scroll_panel:GetVBar()
	function scroll_bar.btnGrip:Paint(w, h)
		draw.RoundedBox(4, 3, 0, w - 8, h, fence_npc.display.color.scrollbar)
	end
	function scroll_bar:Paint(w, h)
		return
	end
	function scroll_bar.btnUp:Paint(w, h)
		return
	end
	function scroll_bar.btnDown:Paint(w, h)
		return
	end
	
	local item_list = vgui.Create("DListLayout", item_scroll_panel)
	item_list:SetSize(380, 0)
	item_list:SetPos(0, 0)
	for item_ent, values in SortedPairs(fence_npc.items) do
		if table.HasValue(closeEntities, item_ent) then
			local item_quantity = getItemQuantity(item_ent, closeEntities)

			if frame_height < 555 then
				frame_height = frame_height + 100
				frame:SetSize(390, frame_height)
				frame:Center()
			end
	
			local item_info_panel = vgui.Create("DPanel")
			item_info_panel:SetSize(400, 100)
			item_info_panel:SetPos(0, 0)
			item_info_panel.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, fence_npc.display.color.item_background)
	
				-- surface.DrawOutlinedRect needs a thickness arg :(
				surface.SetDrawColor(fence_npc.display.color.background)
				for i = 0, 4 do
					surface.DrawOutlinedRect(i, i, w - i * 2, h - i * 2)
				end
				
	
				surface.SetFont("fence_npc_title")
				surface.SetTextColor(fence_npc.display.color.item_title)
				surface.SetTextPos(10, 8)
				surface.DrawText(item_quantity .. "x " .. values.name)
	
				surface.SetTextColor(fence_npc.display.color.item_price)
				surface.SetTextPos(10, 8 + select(2, surface.GetTextSize(values.name)))
				surface.DrawText("$" .. string.Comma(values.offer * item_quantity))
	
				if fence_npc.display.drawEntityName then
					surface.SetTextColor(fence_npc.display.color.item_entname)
					surface.SetTextPos(10, 69)
					surface.DrawText(item_ent)
					surface.SetDrawColor(0, 0, 0)
				end
			end
	
			if values.mdl != nil then
				local item_model_panel = vgui.Create("DModelPanel", item_info_panel)
				item_model_panel:SetSize(100, 95)
				item_model_panel:SetPos(250, 0)
				item_model_panel:SetModel(values.mdl)
				item_model_panel:SetFOV(values.mdlfov)
				item_model_panel:GetEntity():SetPos(values.mdlpos)
			end
	
			item_list:Add(item_info_panel)
		end
	end

	local yes_button = vgui.Create("DButton", frame)
	yes_button:SetFont("fence_npc_item")
	yes_button:SetText(fence_npc.locale[fence_npc.locale.localLang].button)
	yes_button:SetTextColor(fence_npc.display.color.button_text)
	yes_button:SetSize(100, 25)
	--yes_button:SetPos(frame:GetWide() / 2 - yes_button:GetWide() / 2, frame:GetTall() - 35)
	yes_button:SetPos(frame:GetWide() - yes_button:GetWide() - 10, frame:GetTall() - 35)
	yes_button.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, fence_npc.display.color.button)
	end
	yes_button.DoClick = function()
		net.Start("fence_npc_activated")
		net.WriteEntity(ent)
		net.SendToServer()
		frame:Close()
	end

end

function getTotalOffer(itemList, closeEntList)
	local totalOffer = 0
	for i, entName in ipairs(closeEntList) do
		totalOffer = totalOffer + itemList[entName].offer
	end
	return totalOffer
end

function getItemQuantity(item, closeEntList)
	local totalItems = 0
	for i, entName in ipairs(closeEntList) do
		if entName == item then totalItems = totalItems + 1 end
	end
	return totalItems
end

function Draw3DText( pos, ang, scale, text, flipView )
	if ( flipView ) then
		-- Flip the angle 180 degrees around the UP axis
		ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
	end
	cam.Start3D2D( pos, ang, scale )
		-- Actually draw the text. Customize this to your liking.
		draw.DrawText( text, "fence_npc_title", 0, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	cam.End3D2D()
end

function drawBlurRectangle(r,x,y,l,h,color)
	draw.RoundedBox(r,x,y,l,h,Color(0,0,0))
	draw.RoundedBox(r,x + 1,y + 1,l - 2,h - 2,color)
end

net.Receive("fence_npc_draw_menu", fence_npc_draw_menu)