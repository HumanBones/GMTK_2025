extends Resource

class_name Upgrade

@export var description : String
@export var icon : Texture
@export var effect_type : String
@export var effect_value : float
@export var side_effect_type: String
@export var side_effect_valu : float



func apply_upgrade() ->void:
	match effect_type:
		"dmg":
			UpgradeManager.dmg(effect_value,self)
			if side_effect_type == "hp":
				UpgradeManager.hp(int(side_effect_valu),self)
