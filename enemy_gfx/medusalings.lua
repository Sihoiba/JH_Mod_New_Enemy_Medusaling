register_gfx_blueprint "medusaling_jaws"
{
	weapon_fx = {
		advance   = 0.5,
	},
	equip = {},
}

register_gfx_blueprint "archmedusaling_jaws"
{
	weapon_fx = {
		advance   = 0.5,
	},
	equip = {},
}

register_gfx_blueprint "medusaling_base_flesh"
{
	entity_fx = {
		on_hit      = "ps_bleed",
		on_critical = "ps_bleed_critical",
	},
	ragdoll = "ragdoll_medusa",
	animator = "animator_medusa",
	skeleton = "data/model/medusa_01.nmd",
	movement = {
		floating = 0.6,
	},	
	scale = {
		scale = 0.3,
	},
	render = {
		mesh        = "data/model/medusa_01.nmd:medusa_body_01",
		material    = "medusa_body",
	},
	{	
		scale = {
			scale = 0.3,
		},
		render = {
			mesh        = "data/model/medusa_01.nmd:medusa_tentacles_02",
			material    = "medusa_tentacles_02",
		},
	},
	{		
		scale = {
			scale = 0.3,
		},
		render = {
			mesh        = "data/model/medusa_01.nmd:medusa_addon_01",
			material    = "medusa_addon",
		},
	},
	{	
		scale = {
			scale = 0.3,
		},
		render = {
			mesh        = "data/model/medusa_01.nmd:medusa_weapon_01",
			material    = "medusa_weapon",
		},
	},
}

register_gfx_blueprint "medusaling_base_metal"
{
	entity_fx = {
		on_hit      = "ps_bleed",
		on_critical = "ps_bleed_critical",
	},
	ragdoll = "ragdoll_medusa",
	animator = "animator_medusa",
	skeleton = "data/model/medusa_01.nmd",
	movement = {
		floating = 0.6,
	},	
	scale = {
		scale = 0.4,
	},
	render = {
		mesh        = "data/model/medusa_01.nmd:medusa_body_01",
		material    = "medusa_body",
	},
	{	
		scale = {
			scale = 0.4,
		},
		render = {
			mesh        = "data/model/medusa_01.nmd:medusa_tentacles_02",
			material    = "medusa_tentacles_02",
		},
	},
	{		
		scale = {
			scale = 0.4,
		},
		render = {
			mesh        = "data/model/medusa_01.nmd:medusa_addon_01",
			material    = "medusa_addon",
		},
	},
	{	
		scale = {
			scale = 0.4,
		},
		render = {
			mesh        = "data/model/medusa_01.nmd:medusa_weapon_01",
			material    = "medusa_weapon",
		},
	},
}

register_gfx_blueprint "medusaling"
{
	blueprint = "medusaling_base_flesh",
	style = {
		materials = {
			medusa_body         = "enemy_gfx/textures/medusaling/medusa_body_01",
			medusa_addon        = "enemy_gfx/textures/medusaling/medusa_addon_01",
			medusa_tentacles_01 = "enemy_gfx/textures/medusaling/medusa_tentacles_01",
			medusa_tentacles_02 = "enemy_gfx/textures/medusaling/medusa_tentacles_02",
			medusa_weapon       = "enemy_gfx/textures/medusaling/medusa_weapon_01",
		},
	},
	light = {
		position    = vec3(0,0.1,0),
		color       = vec4(0.75,0.35,0.5,1.0),
		range       = 0.2,
	},
}

register_gfx_blueprint "archmedusaling"
{
	blueprint = "medusaling_base_metal",
	style = {
		materials = {
			medusa_body         = "enemy_gfx/textures/archmedusaling/medusa_body_01",
			medusa_addon        = "enemy_gfx/textures/archmedusaling/medusa_addon_01",
			medusa_tentacles_01 = "enemy_gfx/textures/archmedusaling/medusa_tentacles_01",
			medusa_tentacles_02 = "enemy_gfx/textures/archmedusaling/medusa_tentacles_02",
			medusa_weapon       = "enemy_gfx/textures/archmedusaling/medusa_weapon_01",
		},
	},
	light = {
		position    = vec3(0,0.1,0),
		color       = vec4(0.75,0.35,0.5,1.0),
		range       = 0.2,
	},
}

register_gfx_blueprint "exalted_medusaling"
{
	blueprint = "medusaling_base_flesh",
	style = {
		materials = {
			medusa_body         = "data/texture/medusa_01/C/medusa_body_01",
			medusa_addon        = "data/texture/medusa_01/C/medusa_addon_01",
			medusa_tentacles_01 = "data/texture/medusa_01/C/medusa_tentacles_01",
			medusa_tentacles_02 = "data/texture/medusa_01/C/medusa_tentacles_02",
			medusa_weapon       = "data/texture/medusa_01/C/medusa_weapon_01",
		},
	},
	light = {
		position    = vec3(0,0.1,0),
		color       = vec4(0.75,0.35,2.0,1.0),
		range       = 2.5,
	},
}

register_gfx_blueprint "exalted_archmedusaling"
{
	blueprint = "medusaling_base_metal",
	style = {
		materials = {
			medusa_body         = "data/texture/medusa_01/C/medusa_body_01",
			medusa_addon        = "data/texture/medusa_01/C/medusa_addon_01",
			medusa_tentacles_01 = "data/texture/medusa_01/C/medusa_tentacles_01",
			medusa_tentacles_02 = "data/texture/medusa_01/C/medusa_tentacles_02",
			medusa_weapon       = "data/texture/medusa_01/C/medusa_weapon_01",
		},
	},
	light = {
		position    = vec3(0,0.1,0),
		color       = vec4(0.75,0.35,2.0,1.0),
		range       = 2.5,
	},
}