ClimbingRopeInteractionExt = ClimbingRopeInteractionExt or class(UseInteractionExt)

function ClimbingRopeInteractionExt:init(unit, ...)
    ClimbingRopeInteractionExt.super.init(self, unit, ...)
    self._destination_object = self._unit:get_object(Idstring("a_climb_end"))
end
function ClimbingRopeInteractionExt:can_select(player)
    if player:movement():m_head_pos().z > self._destination_object:position().z or not player:movement():current_state()._is_jumping then
        return false
    end
	return ClimbingRopeInteractionExt.super.can_select(self, player)
end

function ClimbingRopeInteractionExt:check_interupt()
	return ClimbingRopeInteractionExt.super.check_interupt(self)
end

function ClimbingRopeInteractionExt:_interact_blocked(player)
	return true
end

function ClimbingRopeInteractionExt:selected(player)
	if not self:can_select(player) then
		return
    end
	self._hand_id = hand_id
	self._is_selected = true
	local string_macros = {}

    self:_add_string_macros(string_macros)
    
    local text_id = self._tweak_data.text_id or alive(self._unit) and self._unit:base().interaction_text_id and self._unit:base():interaction_text_id()
	local text = managers.localization:text(text_id, string_macros)
    local icon = self._tweak_data.icon
    
    managers.hud:show_interact({
		text = text,
		icon = icon
	})
    return true
end

function ClimbingRopeInteractionExt:_btn_interact()
	return managers.localization:btn_macro("jump", false)
end