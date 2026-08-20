local item, super = Class(Item, "bromidef")

function item:init()
    super.init(self)

    -- Display name
    self.name = "BromideF"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "key"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "\"Secret Steamy Bathtime\"\nUSE this item to observe it."

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "world"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {}
end

function item:onWorldUse()
    Game.world:startCutscene(function(cutscene)
        local bromide = Game.world:addChild(Bromide(self:getBromideSprite(), "flowery_bromide_f", 4))
        cutscene:wait(function() return bromide:isRemoved() end)
    end)
end

function item:getBromideSprite()
    if Kristal.getLibConfig("NewChapterKeyItems", "bromideFAltSprite") then
        return "misc/bromide_f_alt"
    end
    return "misc/bromide_f"
end

return item