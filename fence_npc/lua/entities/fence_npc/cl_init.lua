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

surface.CreateFont("fence_npc_item", {font = "Roboto", size = 16})
surface.CreateFont("fence_npc_text", {font = "Roboto", size = 18})
surface.CreateFont("fence_npc_title", {font = "Roboto", size = 23})

function ENT:Draw()
	self:DrawModel()
end

function fence_npc_draw_menu()
	local ent = net.ReadEntity()
	local message = net.ReadTable()
	local items = net.ReadTable()

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
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
		draw.RoundedBox(0, 0, 0, w, 32, Color(33, 150, 243))

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
		surface.SetTextColor(255, 255, 255)
		surface.SetTextPos(7, 5)
		surface.DrawText(message[4])

		surface.SetFont("fence_npc_text")
		surface.SetTextColor(0, 0, 0)
		surface.SetTextPos(110, 45)
		surface.DrawText(message[1])
		surface.SetTextPos(110, 63)
		surface.DrawText(message[2])
		surface.SetTextPos(110, 81)
		surface.DrawText(message[3])
	end

	local close_color = Color(33, 150, 243)
	local close_button = vgui.Create('DButton', frame)
	close_button:SetSize(48, 32)
	close_button:SetPos(frame:GetWide() - close_button:GetWide() - 3, 0)
	close_button:SetFont("fence_npc_text")
	close_button:SetText('X')
	close_button:SetColor(Color(255, 255, 255))
	close_button.DoClick = function() frame:Close() end
	close_button.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, close_color)
	end
	close_button.OnCursorEntered = function()
		close_color = Color(211, 47, 47)
	end
	close_button.OnCursorExited = function()
		close_color = Color(33, 150, 243)
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
		draw.RoundedBox(4, 3, 0, w - 8, h, Color(33, 150, 243, 225))
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

	for item_ent, values in SortedPairs(items) do
		if frame_height < 555 then
			frame_height = frame_height + 100
			frame:SetSize(390, frame_height)
			frame:Center()
		end

		local item_info_panel = vgui.Create("DPanel")
		item_info_panel:SetSize(400, 100)
		item_info_panel:SetPos(0, 0)
		item_info_panel.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(66, 66, 66, 255))

			-- surface.DrawOutlinedRect needs a thickness arg :(
			surface.SetDrawColor(255, 255, 255)
			for i = 0, 4 do
				surface.DrawOutlinedRect(i, i, w - i * 2, h - i * 2)
			end

			surface.SetFont("fence_npc_title")
			surface.SetTextColor(255, 255, 255, 255)
			surface.SetTextPos(10, 8)
			surface.DrawText(values.name)

			surface.SetTextColor(76, 175, 80, 255)
			surface.SetTextPos(10, 8 + select(2, surface.GetTextSize(values.name)))
			surface.DrawText("$" .. string.Comma(values.offer))

			surface.SetTextColor(255, 255, 255, 20)
			surface.SetTextPos(10, 69)
			surface.DrawText(item_ent)
			surface.SetDrawColor(0, 0, 0)
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

	local yes_button = vgui.Create("DButton", frame)
	yes_button:SetFont("fence_npc_item")
	yes_button:SetText(message[5])
	yes_button:SetTextColor(Color(255, 255, 255))
	yes_button:SetSize(100, 25)
	yes_button:SetPos(frame:GetWide() / 2 - yes_button:GetWide() / 2, frame:GetTall() - 35)
	yes_button.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(33, 150, 243))
	end
	yes_button.DoClick = function()
		net.Start("fence_npc_activated")
		net.WriteEntity(ent)
		net.SendToServer()
		frame:Close()
	end

end

net.Receive("fence_npc_draw_menu", fence_npc_draw_menu)