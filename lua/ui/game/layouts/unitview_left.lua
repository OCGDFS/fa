local UIUtil = import('/lua/ui/uiutil.lua')
local Bitmap = import('/lua/maui/bitmap.lua').Bitmap
local LayoutHelpers = import('/lua/maui/layouthelpers.lua')
local Prefs = import('/lua/user/prefs.lua')
local options = Prefs.GetFromCurrentProfile('options')
local NinePatch = import('/lua/ui/controls/ninepatch.lua').NinePatch

function SetLayout()
    local controls = import('/lua/ui/game/unitview.lua').controls
    controls.bg:SetTexture(UIUtil.UIFile('/game/unit-build-over-panel/build-over-back_bmp.dds'))
    LayoutHelpers.AtLeftIn(controls.bg, controls.parent)
    LayoutHelpers.AtBottomIn(controls.bg, controls.parent)
    
    controls.bracket:SetTexture(UIUtil.UIFile('/game/bracket-left-energy/bracket_bmp_t.dds'))
    LayoutHelpers.AtLeftTopIn(controls.bracket, controls.bg, -6, 3)
    
    if not controls.bracketMax then
        controls.bracketMax = Bitmap(controls.bg)
    end
    controls.bracketMax:SetTexture(UIUtil.UIFile('/game/bracket-left-energy/bracket_bmp_b.dds'))
    LayoutHelpers.AtLeftIn(controls.bracketMax, controls.bg, -6)
    LayoutHelpers.AtBottomIn(controls.bracketMax, controls.bg, 3)
    
    if not controls.bracketMid then
        controls.bracketMid = Bitmap(controls.bg)
    end
    controls.bracketMid:SetTexture(UIUtil.UIFile('/game/bracket-left-energy/bracket_bmp_m.dds'))
    LayoutHelpers.AtLeftIn(controls.bracketMid, controls.bg, -6)
    controls.bracketMid.Top:Set(controls.bracket.Bottom)
    controls.bracketMid.Bottom:Set(controls.bracketMax.Top)
    
    LayoutHelpers.AtLeftTopIn(controls.name, controls.bg, 16, 14)
    LayoutHelpers.AtRightIn(controls.name, controls.bg, 16)
    controls.name:SetClipToWidth(true)
    controls.name:SetDropShadow(true)
    
    LayoutHelpers.AtLeftTopIn(controls.icon, controls.bg, 12, 34)
    controls.icon.Height:Set(48)
    controls.icon.Width:Set(48)
    LayoutHelpers.AtLeftTopIn(controls.stratIcon, controls.icon)
    LayoutHelpers.Below(controls.vetIcons[1], controls.icon, 5)
    LayoutHelpers.AtLeftIn(controls.vetIcons[1], controls.icon, -5)
    for index = 2, 5 do
        local i = index
        LayoutHelpers.RightOf(controls.vetIcons[i], controls.vetIcons[i-1], -3)
    end
    LayoutHelpers.AtLeftTopIn(controls.healthBar, controls.bg, 66, 35)
    controls.healthBar.Width:Set(188)
    controls.healthBar.Height:Set(16)
    controls.healthBar:SetTexture(UIUtil.UIFile('/game/unit-build-over-panel/healthbar_bg.dds'))
    controls.healthBar._bar:SetTexture(UIUtil.UIFile('/game/unit-build-over-panel/healthbar_green.dds'))
    LayoutHelpers.AtBottomIn(controls.shieldBar, controls.healthBar)
    LayoutHelpers.AtLeftIn(controls.shieldBar, controls.healthBar)
    controls.shieldBar.Width:Set(188)
    controls.shieldBar.Height:Set(2)
    controls.shieldBar:SetTexture(UIUtil.UIFile('/game/unit-build-over-panel/healthbar_bg.dds'))
    controls.shieldBar._bar:SetTexture(UIUtil.UIFile('/game/unit-build-over-panel/shieldbar.dds'))
    LayoutHelpers.Below(controls.fuelBar, controls.shieldBar)
    controls.fuelBar.Width:Set(188)
    controls.fuelBar.Height:Set(2)
    controls.fuelBar:SetTexture(UIUtil.UIFile('/game/unit-build-over-panel/healthbar_bg.dds'))
    controls.fuelBar._bar:SetTexture(UIUtil.UIFile('/game/unit-build-over-panel/fuelbar.dds'))
    LayoutHelpers.AtCenterIn(controls.health, controls.healthBar)
    controls.health:SetDropShadow(true)

    local iconPositions = {
        [1] = {Left = 70, Top = 60},
        [2] = {Left = 70, Top = 80},
        [3] = {Left = 190, Top = 60},
        [4] = {Left = 130, Top = 60},
        [5] = {Left = 130, Top = 80},
        [6] = {Left = 130, Top = 80},
        [7] = {Left = 190, Top = 80}
    }
    local iconTextures = {
        UIUtil.UIFile('/game/unit_view_icons/mass.dds'),
        UIUtil.UIFile('/game/unit_view_icons/energy.dds'),
        UIUtil.UIFile('/game/unit_view_icons/kills.dds'),
		UIUtil.UIFile('/game/unit_view_icons/kills.dds'),
        UIUtil.UIFile('/game/unit_view_icons/missiles.dds'),
        UIUtil.UIFile('/game/unit_view_icons/shield.dds'),
        UIUtil.UIFile('/game/unit_view_icons/fuel.dds'),
    }
    for index = 1, 7 do
        local i = index
        if iconPositions[i] then
            LayoutHelpers.AtLeftTopIn(controls.statGroups[i].icon, controls.bg, iconPositions[i].Left, iconPositions[i].Top)
        else
            LayoutHelpers.Below(controls.statGroups[i].icon, controls.statGroups[i-1].icon, 5)
        end
        controls.statGroups[i].icon:SetTexture(iconTextures[i])
        LayoutHelpers.RightOf(controls.statGroups[i].value, controls.statGroups[i].icon, 5)
        LayoutHelpers.AtVerticalCenterIn(controls.statGroups[i].value, controls.statGroups[i].icon)
        controls.statGroups[i].value:SetDropShadow(true)
    end
    LayoutHelpers.AtLeftTopIn(controls.actionIcon, controls.bg, 261, 34)
    controls.actionIcon.Height:Set(48)
    controls.actionIcon.Width:Set(48)
    LayoutHelpers.Below(controls.actionText, controls.actionIcon)
    LayoutHelpers.AtHorizontalCenterIn(controls.actionText, controls.actionIcon)
    
    controls.abilities.Left:Set(function() return controls.bg.Right() + 20 end)
    controls.abilities.Bottom:Set(function() return controls.bg.Bottom() - 24 end)
    controls.abilities.Height:Set(50)
    controls.abilities.Width:Set(200)

    if controls.abilityBG then controls.abilityBG:Destroy() end
    controls.abilityBG = NinePatch(controls.abilities,
        UIUtil.UIFile('/game/filter-ping-list-panel/panel_brd_m.dds'),
        UIUtil.UIFile('/game/filter-ping-list-panel/panel_brd_ul.dds'),
        UIUtil.UIFile('/game/filter-ping-list-panel/panel_brd_ur.dds'),
        UIUtil.UIFile('/game/filter-ping-list-panel/panel_brd_ll.dds'),
        UIUtil.UIFile('/game/filter-ping-list-panel/panel_brd_lr.dds'),
        UIUtil.UIFile('/game/filter-ping-list-panel/panel_brd_vert_l.dds'),
        UIUtil.UIFile('/game/filter-ping-list-panel/panel_brd_vert_r.dds'),
        UIUtil.UIFile('/game/filter-ping-list-panel/panel_brd_horz_um.dds'),
        UIUtil.UIFile('/game/filter-ping-list-panel/panel_brd_lm.dds')
    )

    controls.abilityBG:Surround(controls.abilities, 3, 5)
    LayoutHelpers.DepthUnderParent(controls.abilityBG, controls.abilities)

    if options.gui_detailed_unitview != 0 then
        LayoutHelpers.AtLeftTopIn(controls.healthBar, controls.bg, 66, 25)
        LayoutHelpers.Below(controls.shieldBar, controls.healthBar)
        controls.shieldBar.Height:Set(14)
        LayoutHelpers.CenteredBelow(controls.shieldText, controls.shieldBar,0)
        controls.shieldBar.Height:Set(2)
        LayoutHelpers.AtLeftTopIn(controls.statGroups[1].icon, controls.bg, 70, 55)
        LayoutHelpers.RightOf(controls.statGroups[1].value, controls.statGroups[1].icon, 5)
        LayoutHelpers.Below(controls.statGroups[2].icon, controls.statGroups[1].icon,0)
        -- LayoutHelpers.AtRightTopIn(controls.StorageMass, controls.bg, 145, 55)
        LayoutHelpers.RightOf(controls.statGroups[2].value, controls.statGroups[2].icon, 5)
        -- LayoutHelpers.AtRightTopIn(controls.StorageEnergy, controls.bg, 145, 73)
        LayoutHelpers.Below(controls.Buildrate, controls.statGroups[2].value,1)
    end
end

function PositionWindow()
    local controls = import('/lua/ui/game/unitview.lua').controls
    local consControl = import('/lua/ui/game/construction.lua').controls.constructionGroup
    if consControl:IsHidden() then
        LayoutHelpers.AtBottomIn(controls.bg, controls.parent)
        LayoutHelpers.AtLeftIn(controls.bg, consControl, 18)
        controls.bracket:SetTexture(UIUtil.UIFile('/game/unit-build-over-panel/bracket-unit_bmp.dds'))
        LayoutHelpers.AtLeftTopIn(controls.bracket, controls.bg, -19, -2)
        controls.bracketMax:Hide()
        controls.bracketMid:Hide()
    else
        controls.bracket:SetTexture(UIUtil.UIFile('/game/bracket-left-energy/bracket_bmp_t.dds'))
        controls.bracketMax:Show()
        controls.bracketMid:Show()
        LayoutHelpers.AtLeftTopIn(controls.bracket, controls.bg, -6, 3)
        LayoutHelpers.AtBottomIn(controls.bg, controls.parent)
        LayoutHelpers.AtLeftIn(controls.bg, controls.parent, 207)
    end
end
