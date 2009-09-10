ReagentFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

local L = AceLibrary("AceLocale-2.2"):new("ReagentFu")
local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")
local Crayon = LibStub("LibCrayon-3.0")

local playerClass = nil
local reagentCount = {}
local fullCount = {
		["Rune of Portals"] = 10,
		["Rune of Teleportation"] = 10,
		["Thistle Tea"] = 10,
		["Ankh"] = 10,
		["Soul Shard"] = 10,
		["Soulstone"] = 1,
		["Healthstone"] = 1,
		["Firestone"] = 1,
		["Spellstone"] = 1,
		["Infernal Stone"] = 5,
		["Demonic Figurine"] = 5,
		["Symbol of Kings"] = 100,
		["Symbol of Divinity"] = 5,
		["Arcane Powder"] = 100,
	}
local sortOrder = {
		--mage
		["Arcane Powder"] = 1,
		["Rune of Teleportation"] = 2,
		["Rune of Portals"] = 3,
		["Light Feather"] = 20,
		--priest
		["Holy Candle"] = 1,
		["Sacred Candle"] = 2,
		["Devout Candle"] = 3,
		["Light Feather"] = 20,
		-- rogue
		["Thistle Tea"] = 3,
		["Instant Poison"] = 4,
		["Deadly Poison"] = 5,
		["Crippling Poison"] = 6,
		["Mind-numbing Poison"] = 7,
		["Wound Poison"] = 8,
		["Anesthetic Poison"] = 9,
		--druid
		["Wild Berries"] = 1,
		["Wild Thornroot"] = 2,
		["Wild Quillvine"] = 3,
		["Maple Seed"] = 4,
		["Stranglethorn Seed"] = 5,
		["Ashwood Seed"] = 6,
		["Hornbeam Seed"] = 7,
		["Ironwood Seed"] = 8,
		["Flintweed Seed"] = 9,
		["Starleaf Seed"] = 10,
		["Wild Spineleaf"] = 11,
		-- Paladin
		["Symbol of Divinity"] = 1,
		["Symbol of Kings"] = 2,
		-- Shaman
		["Ankh"] = 1,
		["Shiny Fish Scales"] = 2,
		["Fish Oil"] = 3,
		-- warlock
		["Soul Shard"] = 1,
		["Healthstone"] = 2,
		["Soulstone"] = 3,
		["Spellstone"] = 4,
		["Firestone"] = 5,
		["Infernal Stone"] = 6,
		["Demonic Figurine"] = 7,
		-- death knight
		["Corpse Dust"] = 1,
		-- hunter, rogue, warrior
		["Arrow"] = 1,
		["Bullet"] = 2,
	}

-- indicates field on local itemInfo table
-- referenced from GetReagentCount()
-- currently one of name,type,subtype
local useFind = {
		["Instant Poison"] = "name",
		["Deadly Poison"] = "name",
		["Crippling Poison"] = "name",
		["Mind-numbing Poison"] = "name",
		["Wound Poison"] = "name",
		["Healthstone"] = "name",
		["Soulstone"] = "name",
		["Spellstone"] = "name",
		["Firestone"] = "name",
		["Arrow"] = "subtype",
		["Bullet"] = "subtype",
	}
	
	
ReagentFu.hasIcon = "Interface\\Icons\\INV_Misc_Book_09"
ReagentFu.defaultPosition = "LEFT"

ReagentFu:RegisterDB("ReagentFuDB", "ReagentFuCharDB")
ReagentFu:RegisterDefaults("profile", {
	showShortNames = false,
})
ReagentFu:RegisterDefaults("char", {
	showReagent = {},
})

-- Methods
function ReagentFu:IsShowingShortNames()
	return self.db.profile.showShortNames
end

function ReagentFu:ToggleShowingShortNames()
	self.db.profile.showShortNames = not self.db.profile.showShortNames
	self:Update()
	return self.db.profile.showShortNames
end

function ReagentFu:IsShowing(reagent)
	return self.db.char.showReagent[reagent]
end

function ReagentFu:ToggleShowing(reagent)
	self.db.char.showReagent[reagent] = not self.db.char.showReagent[reagent]
	self:Update()
	return self.db.char.showReagent[reagent]
end

function ReagentFu:OnEnable()
	_,playerClass = UnitClass("player")
	if (playerClass == "DRUID") then
		if self.db.char.showReagent[L["Wild Berries"]] == nil then
			self.db.char.showReagent[L["Wild Berries"]] = true
		end
		if self.db.char.showReagent[L["Wild Thornroot"]] == nil then
			self.db.char.showReagent[L["Wild Thornroot"]] = true
		end
		if self.db.char.showReagent[L["Wild Quillvine"]] == nil then
			self.db.char.showReagent[L["Wild Quillvine"]] = true
		end
		if self.db.char.showReagent[L["Maple Seed"]] == nil then
			self.db.char.showReagent[L["Maple Seed"]] = true
		end
		if self.db.char.showReagent[L["Stranglethorn Seed"]] == nil then
			self.db.char.showReagent[L["Stranglethorn Seed"]] = true
		end
		if self.db.char.showReagent[L["Ashwood Seed"]] == nil then
			self.db.char.showReagent[L["Ashwood Seed"]] = true
		end
		if self.db.char.showReagent[L["Hornbeam Seed"]] == nil then
			self.db.char.showReagent[L["Hornbeam Seed"]] = true
		end
		if self.db.char.showReagent[L["Ironwood Seed"]] == nil then
			self.db.char.showReagent[L["Ironwood Seed"]] = true
		end
		if self.db.char.showReagent[L["Flintweed Seed"]] == nil then
			self.db.char.showReagent[L["Flintweed Seed"]] = true
		end
		if self.db.char.showReagent[L["Starleaf Seed"]] == nil then
			self.db.char.showReagent[L["Starleaf Seed"]] = true
		end
		if self.db.char.showReagent[L["Wild Spineleaf"]] == nil then
			self.db.char.showReagent[L["Wild Spineleaf"]] = true
		end	
		self:SetIcon("Interface\\Icons\\INV_Misc_Branch_01")
	elseif (playerClass == "MAGE") then
		if self.db.char.showReagent[L["Arcane Powder"]] == nil then
			self.db.char.showReagent[L["Arcane Powder"]] = true
		end
		if self.db.char.showReagent[L["Rune of Teleportation"]] == nil then
			self.db.char.showReagent[L["Rune of Teleportation"]] = true
		end
		if self.db.char.showReagent[L["Rune of Portals"]] == nil then
			self.db.char.showReagent[L["Rune of Portals"]] = true
		end
		if self.db.char.showReagent[L["Light Feather"]] == nil then
			self.db.char.showReagent[L["Light Feather"]] = true
		end
		self:SetIcon("Interface\\Icons\\INV_Misc_Dust_01")
	elseif (playerClass == "PALADIN") then
		if self.db.char.showReagent[L["Symbol of Divinity"]] == nil then
			self.db.char.showReagent[L["Symbol of Divinity"]] = true
		end
		if self.db.char.showReagent[L["Symbol of Kings"]] == nil then
			self.db.char.showReagent[L["Symbol of Kings"]] = true
		end
		self:SetIcon("Interface\\Icons\\INV_Stone_WeightStone_05")
	elseif (playerClass == "PRIEST") then
		if self.db.char.showReagent[L["Holy Candle"]] == nil then
			self.db.char.showReagent[L["Holy Candle"]] = true
		end
		if self.db.char.showReagent[L["Sacred Candle"]] == nil then
			self.db.char.showReagent[L["Sacred Candle"]] = true
		end
		if self.db.char.showReagent[L["Devout Candle"]] == nil then
			self.db.char.showReagent[L["Devout Candle"]] = true
		end
		if self.db.char.showReagent[L["Light Feather"]] == nil then
			self.db.char.showReagent[L["Light Feather"]] = true
		end
		self:SetIcon("Interface\\Icons\\INV_Misc_Candle_03")
	elseif (playerClass == "ROGUE") then
		if self.db.char.showReagent[L["Thistle Tea"]] == nil then
			self.db.char.showReagent[L["Thistle Tea"]] = true
		end
		if self.db.char.showReagent[L["Instant Poison"]] == nil then
			self.db.char.showReagent[L["Instant Poison"]] = true
		end
		if self.db.char.showReagent[L["Deadly Poison"]] == nil then
			self.db.char.showReagent[L["Deadly Poison"]] = true
		end
		if self.db.char.showReagent[L["Crippling Poison"]] == nil then
			self.db.char.showReagent[L["Crippling Poison"]] = true
		end
		if self.db.char.showReagent[L["Mind-numbing Poison"]] == nil then
			self.db.char.showReagent[L["Mind-numbing Poison"]] = true
		end
		if self.db.char.showReagent[L["Wound Poison"]] == nil then
			self.db.char.showReagent[L["Wound Poison"]] = true
		end
		if self.db.char.showReagent[L["Anesthetic Poison"]] == nil then
			self.db.char.showReagent[L["Anesthetic Poison"]] = true
		end
		if self.db.char.showReagent[L["Arrow"]] == nil then
			self.db.char.showReagent[L["Arrow"]] = true
		end
		if self.db.char.showReagent[L["Bullet"]] == nil then
			self.db.char.showReagent[L["Bullet"]] = true
		end
		self:SetIcon("Interface\\Icons\\Trade_BrewPoison")
	elseif (playerClass == "SHAMAN") then
		if self.db.char.showReagent[L["Ankh"]] == nil then
			self.db.char.showReagent[L["Ankh"]] = true
		end
		if self.db.char.showReagent[L["Shiny Fish Scales"]] == nil then
			self.db.char.showReagent[L["Shiny Fish Scales"]] = true
		end
		if self.db.char.showReagent[L["Fish Oil"]] == nil then
			self.db.char.showReagent[L["Fish Oil"]] = true
		end
		self:SetIcon("Interface\\Icons\\INV_Jewelry_Talisman_06")
	elseif (playerClass == "WARLOCK") then
		if self.db.char.showReagent[L["Soul Shard"]] == nil then
			self.db.char.showReagent[L["Soul Shard"]] = true
		end
		if self.db.char.showReagent[L["Healthstone"]] == nil then
			self.db.char.showReagent[L["Healthstone"]] = true
		end
		if self.db.char.showReagent[L["Soulstone"]] == nil then
			self.db.char.showReagent[L["Soulstone"]] = true
		end
		if self.db.char.showReagent[L["Spellstone"]] == nil then
			self.db.char.showReagent[L["Spellstone"]] = true
		end
		if self.db.char.showReagent[L["Firestone"]] == nil then
			self.db.char.showReagent[L["Firestone"]] = true
		end
		if self.db.char.showReagent[L["Infernal Stone"]] == nil then
			self.db.char.showReagent[L["Infernal Stone"]] = true
		end
		if self.db.char.showReagent[L["Demonic Figurine"]] == nil then
			self.db.char.showReagent[L["Demonic Figurine"]] = true
		end
		self:SetIcon("Interface\\Icons\\INV_Misc_Gem_Amethyst_02")
	elseif (playerClass == "DEATHKNIGHT") then
		if self.db.char.showReagent[L["Corpse Dust"]] == nil then
			self.db.char.showReagent[L["Corpse Dust"]] = true
		end
		self:SetIcon("Interface\\Icons\\INV_Misc_Dust_02")
	elseif (playerClass == "HUNTER") then
		if self.db.char.showReagent[L["Arrow"]] == nil then
			self.db.char.showReagent[L["Arrow"]] = true
		end
		if self.db.char.showReagent[L["Bullet"]] == nil then
			self.db.char.showReagent[L["Bullet"]] = true
		end
		self:SetIcon("Interface\\Icons\\INV_Ammo_Arrow_02")
	elseif (playerClass == "WARRIOR") then
		if self.db.char.showReagent[L["Arrow"]] == nil then
			self.db.char.showReagent[L["Arrow"]] = true
		end
		if self.db.char.showReagent[L["Bullet"]] == nil then
			self.db.char.showReagent[L["Bullet"]] = true
		end
		self:SetIcon("Interface\\Icons\\INV_Ammo_Arrow_02")
	else
		self:Hide()
		self:SetIcon("Interface\\Icons\\INV_Misc_Book_09")
	end
	self:RegisterBucketEvent("BAG_UPDATE", 1, "Update")
	self.countValues = {}
end

function ReagentFu:OnMenuRequest(level, value, inTooltip)
	if level == 1 then
		dewdrop:AddLine(
			'text', L["Show short names"],
			'func', "ToggleShowingShortNames",
			'arg1', self,
			'checked', self:IsShowingShortNames(),
			'closeWhenClicked', false
		)
		
		dewdrop:AddLine()

		dewdrop:AddLine(
			'text', L["Reagents"],
			'hasArrow', true,
			'value', "filter"
		)

		dewdrop:AddLine()

	elseif level == 2 then
		if value == "filter" then
			for reagent, t in self:pairsByKeys(self.db.char.showReagent) do
				dewdrop:AddLine(
					'text', reagent,
					'func', "ToggleShowing",
					'arg1', self,
					'arg2', reagent,
					'checked', t
				)
			end
		end
	end
end

function ReagentFu:OnDataUpdate()
	self:GetReagentCount()
--	table.sort(reagentCount, self:sortByKeys)
end

function ReagentFu:OnTextUpdate()
	local reverse
	local count_string = ""
	local itemcount = 0
	local maxcount
	if (playerClass ~= "ROGUE") then
		for k, v in self:pairsByKeys(reagentCount) do
			if (v ~= nil) then
				reverse = L:GetReverseTranslation(k)
				if (count_string ~= "") then
					count_string = count_string.."/"
				end
				if self:IsShowingShortNames() then
					count_string = count_string..L[reverse .. ".SHORT"]
				end
				maxcount = fullCount[reverse]
				if maxcount == nil then maxcount = 20 end
				count_string = count_string..format("|cff%s%d|r", Crayon:GetThresholdHexColor(v / maxcount), v)
			end
		end
	else
		local poisonCount = 0
		for k, v in self:pairsByKeys(reagentCount) do
			if v ~= nil then
				if	k == L["Instant Poison"] or
					k == L["Deadly Poison"] or
					k == L["Crippling Poison"] or
					k == L["Mind-numbing Poison"] or
					k == L["Anesthetic Poison"] or
					k == L["Wound Poison"] then
					poisonCount = poisonCount + v
				else
					reverse = L:GetReverseTranslation(k)
					maxcount = fullCount[reverse]
					if maxcount == nil then maxcount = 20 end
					if count_string ~= "" then
						count_string = count_string.."/"
					end
					if self:IsShowingShortNames() then
						count_string = count_string .. L[reverse .. ".SHORT"]
					end
					count_string = count_string..format("|cff%s%d|r", Crayon:GetThresholdHexColor(v / maxcount), v)
				end
			end
		end

		if count_string ~= "" then
			count_string = count_string.."/"
		end
		if self:IsShowingShortNames() then
			count_string = count_string .. L["Poison: "]
		end
		count_string = count_string..format("|cff%s%d|r", Crayon:GetThresholdHexColor(poisonCount / 10), poisonCount)
	end
	
	self:SetText(count_string)
end

function ReagentFu:OnTooltipUpdate()
	local cat = tablet:AddCategory(
		"columns", 2,
		"child_textR", 0, 
		"child_textG", 1,
		"child_textB", 0,
		"showWithoutChildren", false
	)
	local r, g, b
	local itemcount = 0
	local maxcount
	for k, v in self:pairsByKeys(reagentCount) do
		if v ~= nil then
			maxcount = fullCount[L:GetReverseTranslation(k)]
			if maxcount == nil then maxcount = 20 end
			r, g, b = Crayon:GetThresholdColor(v / maxcount)
			cat:AddLine("text", k, "text2", v, "text2R", r, "text2G", g, "text2B", b)
		end
	end
end

local itemInfo = {}
function ReagentFu:GetReagentCount()
	for reagent, active in pairs(self.db.char.showReagent) do
		reagentCount[reagent] = 0
	end
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag)
		if (size > 0) then
			for slot = 1, size, 1 do
				local _,itemCount = GetContainerItemInfo(bag, slot)
				if (itemCount) then
					itemInfo.name, _, _, _, _, itemInfo.type, itemInfo.subtype = self:NameFromLink(GetContainerItemLink(bag, slot))
					if ((itemInfo.name) and (itemInfo.name ~= "")) then
						for reagent, active in pairs(self.db.char.showReagent) do
							if active then
								local findField = useFind[L:GetReverseTranslation(reagent)]
								if reagent == itemInfo.name or 
										(findField and itemInfo[findField] and
										 string.find(itemInfo[findField], reagent, 1, true)) then
									reagentCount[reagent] = reagentCount[reagent] + itemCount
								end
							else
								reagentCount[reagent] = nil
							end
						end
					end
				end
			end
		end
	end
end

function ReagentFu:NameFromLink(link)
	if (link) then
		return GetItemInfo(link)
	end
end

function ReagentFu:pairsByKeys(t)
	local st = {}
	for n in pairs(t) do
		table.insert(st, n)
	end
	table.sort(st, function(a, b)
					return sortOrder[L:GetReverseTranslation(a)] < sortOrder[L:GetReverseTranslation(b)]
				end )
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if st[i] == nil then
			return nil
		else
			return st[i], t[st[i]]
		end
	end
	return iter
end
