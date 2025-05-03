nova.require "data/lua/core/common"
nova.require "data/lua/core/aitk"
nova.require "data/lua/jh/data/common"

register_blueprint "medusaling_base"
{
    blueprint = "being",
    flags     = { EF_NOMOVE, EF_NOFLY, EF_FLYING, EF_TARGETABLE, EF_ALIVE, },
    health = {},
    sound = {
        idle = "medusaling_idle",
        die  = "medusaling_die",
        pain = "medusaling_pain",
    },
    ascii     = {
        glyph     = "o",
        color     = LIGHTRED,
    },
    attributes = {
        speed = 1.3,
        experience_value = 10,
        health           = 10,
        resist = {
            ignite = 100,
            slash = 0,
            impact = 25,
        },
    },
    callbacks = {
        on_attacked = "aitk.on_attacked",
        on_action   = "aitk.standard_ai",
        on_noise    = "aitk.on_noise",
    },
    listen = {
        active   = true,
        strength = 0,
    },
}

register_blueprint "buff_blinded"
{
    flags = { EF_NOPICKUP },
    text = {
        name    = "Blinded",
        desc    = "Reduces vision range",
    },
    callbacks = {
        on_attach = [[
            function ( self, target )
                local level = world:get_level()
                self.attributes.vision = -( target:attribute( "vision" ) - ( level.level_info.light_range -3 ) )
                self.attributes.min_vision = - ( target:attribute("min_vision" ) - 2 )
            end
        ]],
        on_die = [[
            function ( self )
                world:mark_destroy( self )
            end
        ]],
        on_enter_level = [[
            function ( self )
                world:mark_destroy( self )
            end
        ]],
    },
    ui_buff = {
        color = WHITE,
        style = 1,
    },
    attributes = {
    },
}

register_blueprint "medusaling_curse"
{
    flags = { EF_NOPICKUP, EF_PERMANENT },
    text = {
        name  = "Medusaling's venom",
        desc  = "You have been bitten by a medusaling. Some of the wounds it inflicted will never heal.",
        bdesc = "irrecoverable health damage",
    },
    attributes = {
        health_lost = 0,
    },
}

register_blueprint "medusaling_jaws"
{
    weapon = {
        group       = "melee",
        type        = "melee",
        natural     = true,
        damage_type = "slash",
        fire_sound  = "medusa_melee",
        hit_sound   = "blunt",
    },
    attributes = {
        damage      = 5,
        crit_damage = 100,
        accuracy    = 25,
    },
    callbacks = {
        on_damage = [[
            function ( weapon, who, amount, source )
                if who and who.data and who.data.is_player then
                    world:add_buff( who, "buff_blinded", 500, true )
                end
            end
        ]],
    }
}

register_blueprint "archmedusaling_jaws"
{
    weapon = {
        group       = "melee",
        type        = "melee",
        natural     = true,
        damage_type = "slash",
        fire_sound  = "medusa_melee",
        hit_sound   = "blunt",
    },
    attributes = {
        damage      = 10,
        crit_damage = 100,
        accuracy    = 25,
    },
    callbacks = {
        on_damage = [[
            function ( weapon, who, amount, source )
                if who and who.data and who.data.is_player then
                    world:add_buff( who, "buff_blinded", 500, true )
                end
                if who and who.data and who.data.is_player then
                    local curse   = who:child( "medusaling_curse" ) or who:attach( "medusaling_curse" )
                    local current = curse.attributes.health_lost
                    local hattr   = who.attributes.health
                    if current < 30 and hattr > 50 then
                        curse.attributes.health_lost = current + 1
                        who.attributes.health        = hattr - 1
                    end
                end
            end
        ]],
    }
}

register_blueprint "medusaling_dodge"
{
    flags = { EF_NOPICKUP },
    text = {
        name = "Slithering",
        desc = "increases evasion and splash damage resistance",
    },
    ui_buff = {
        color     = LIGHTBLUE,
        attribute = "evasion",
        priority  = 100,
    },
    attributes = {
        evasion = 0,
        splash_mod = 1.0,
    },
    callbacks = {
        on_action = [[
            function ( self, entity, time_passed, last )
                if time_passed > 0 then
                    local evasion = self.attributes.evasion
                    if evasion > 0 then
                        if last >= COMMAND_MOVE and last <= COMMAND_MOVE_F then
                            self.attributes.evasion = math.floor( evasion / 2 )
                            self.attributes.splash_mod = 0.2
                        else
                            self.attributes.evasion = 0
                            self.attributes.splash_mod = 1.0
                        end
                    end
                end
            end
        ]],
        on_move = [[
            function ( self, entity )
                self.attributes.evasion = math.min( self.attributes.evasion + 40 + (DIFFICULTY * 10), 100 + (DIFFICULTY * 10) )
                self.attributes.splash_mod = 0.2
            end
        ]],
    },
}

register_blueprint "medusaling_armor"
{
    armor = {},
    attributes = {
        armor = {
            8,
            slash  = 8,
            pierce = -4,
            plasma = -4,
        },
        health = 200,
    },
    health = {},
}

register_blueprint "medusaling"
{
    blueprint = "medusaling_base",
    lists = {
        group = "being",
        { 3, keywords = { "test" }, weight = 150 },
        { 3, keywords = { "callisto", "europa", "demon", "demon1" }, weight = 150, dmin = 6, dmax = 29, },
        { 7, keywords = { "europa", "demon", "demon1" }, weight = 50, dmin = 9, dmax = 57, },
    },
    text = {
        name      = "medusaling",
        namep     = "medusalings",
    },
    data = {
        nightmare = {
            id   = "exalted_medusaling",
        },
        ai = {
            aware  = false,
            alert  = 1,
            group  = "demon",
            state  = "idle",
            melee  = 2,
            charge = true,
            smell  = 2000,
        },
    },
    callbacks = {
        on_create = [=[
        function( self )
            self:attach( "medusaling_jaws" )
            self:attach( "medusaling_dodge" )
        end
        ]=],
    },
}

register_blueprint "archmedusaling"
{
    blueprint = "medusaling_base",
    lists = {
        group = "being",
        { keywords = { "test" }, weight = 150 },
        { 3,  keywords = { "io", "beyond", "dante", "general", "demon", "demon2", "hard" }, weight = 100, dmin = 16, },
        { 5,  keywords = { "io", "beyond", "dante", "general", "demon", "demon2", "hard" }, weight = 200, dmin = 22, },
        { 7,  keywords = { "io", "beyond", "dante", "general", "demon", "demon2", "hard", "swarm" }, weight = 200, dmin = 26, },
    },
    text = {
        name      = "archmedusaling",
        namep     = "archmedusalings",
    },
    data = {
        is_semimechanical = true,
    },
    ascii     = {
        glyph     = "o",
        color     = YELLOW,
    },
    attributes = {
        experience_value = 25,
        speed = 1.4,
        health           = 30,
        resist = {
            emp   = 50,
            impact = 25,
        },
        damage_mod = {
            emp = 1.0,
        },
    },
    data = {
        nightmare = {
            id   = "exalted_archmedusaling",
        },
        ai = {
            aware  = false,
            alert  = 1,
            group  = "demon",
            state  = "idle",
            melee  = 2,
            charge = true,
            smell  = 2000,
        },
    },
    callbacks = {
        on_create = [=[
        function( self )
            self:attach( "medusaling_armor" )
            self:attach( "archmedusaling_jaws" )
            self:attach( "medusaling_dodge" )
        end
        ]=],
    },
}

register_blueprint "exalted_medusaling"
{
    blueprint = "medusaling_base",
    lists = {
        group = "exalted",
    },
    text = {
        name      = "exalted medusaling",
        namep     = "exalted medusalings",
    },
    ascii     = {
        glyph     = "o",
        color     = LIGHTMAGENTA,
    },
    data = {
        ai = {
            aware  = false,
            alert  = 1,
            group  = "demon",
            state  = "idle",
            melee  = 2,
            charge = true,
            smell  = 2000,
        },
        is_semimechanical = false,
        nightmare = false,
        exalted_traits = {
            danger = 15,
            { "exalted_kw_unstable", },
            { "exalted_kw_resilient",                     tag = "health", },
            { "exalted_kw_tough",                   tag = "health" },
            { "exalted_kw_armored", },
            { "exalted_kw_hunter",              min = 6, },
            { "exalted_kw_regenerate",          min = 6,  tag = "health", },
            { "exalted_kw_lethal",              min = 7,  tag = "damage", },
            { "exalted_kw_deadly",              min = 14, tag = "damage", },
            { "exalted_kw_fast",                min = 14, },
            { "exalted_kw_resist",              min = 10, tag = "resist", req = "inferno" },
            { "exalted_kw_immune",              min = 20, tag = "resist", },
            { "exalted_kw_corrosive",           min = 8,  tag = "resist", },
            { "exalted_kw_mephitic",            min = 12, tag = "resist", },
            { "exalted_kw_infernal",            min = 14, tag = "resist", },
            { "exalted_kw_gatekeeper",    min = 15, tag = "health", req = "norespawn" },
            { "exalted_kw_adaptive",            min = 18, tag = "block",  },
            { "exalted_kw_damage_gate",         min = 18, tag = "block",  },
            { "exalted_kw_beholder",      min = 21, tag = "health", },
        },
    },
    attributes = {
        experience_value = 15,
        speed = 1.35,
        health = 12,
    },
    callbacks = {
        on_create = [=[
        function( self )
            self:attach( "medusaling_jaws" )
            self:attach( "medusaling_dodge" )
        end
        ]=],
    },
}

register_blueprint "exalted_archmedusaling"
{
    blueprint = "medusaling_base",
    lists = {
        group = "exalted",
        keywords = { "beyond", "dante", "general", "demon", "demon2", "vhard" },
        weight = 200,
        dmin = 26,
    },
    text = {
        name      = "exalted archmedusaling",
        namep     = "exalted archmedusalings",
    },
    ascii     = {
        glyph     = "o",
        color     = MAGENTA,
    },
    data = {
        ai = {
            aware  = false,
            alert  = 1,
            group  = "demon",
            state  = "idle",
            melee  = 2,
            charge = true,
            smell  = 2000,
        },
        is_semimechanical = true,
        nightmare = false,
        exalted_traits = {
            danger = 25,
            { "exalted_kw_unstable", },
            { "exalted_kw_resilient",                     tag = "health", },
            { "exalted_kw_tough",                   tag = "health" },
            { "exalted_kw_armored", },
            { "exalted_kw_hunter",              min = 6, },
            { "exalted_kw_regenerate",          min = 6,  tag = "health", },
            { "exalted_kw_lethal",              min = 7,  tag = "damage", },
            { "exalted_kw_deadly",              min = 14, tag = "damage", },
            { "exalted_kw_fast",                min = 14, },
            { "exalted_kw_resist",              min = 10, tag = "resist", req = "inferno" },
            { "exalted_kw_immune",              min = 20, tag = "resist", },
            { "exalted_kw_corrosive",           min = 8,  tag = "resist", },
            { "exalted_kw_mephitic",            min = 12, tag = "resist", },
            { "exalted_kw_infernal",            min = 14, tag = "resist", },
            { "exalted_kw_gatekeeper",    min = 15, tag = "health", req = "norespawn" },
            { "exalted_kw_adaptive",            min = 18, tag = "block",  },
            { "exalted_kw_damage_gate",         min = 18, tag = "block",  },
            { "exalted_kw_beholder",      min = 21, tag = "health", },
        },
    },
    attributes = {
        experience_value = 35,
        speed = 1.45,
        health = 40,
        resist = {
            emp   = 50,
            impact = 50,
        },
        damage_mod = {
            emp = 1.0,
        },
    },
    callbacks = {
        on_create = [=[
        function( self,_,tier )
            self:attach( "medusaling_armor" )
            self:attach( "archmedusaling_jaws" )
            self:attach( "medusaling_dodge" )
            if tier > 1 then
                make_exalted( self, tier, self.data.exalted_traits )
            end
        end
        ]=],
    },
}