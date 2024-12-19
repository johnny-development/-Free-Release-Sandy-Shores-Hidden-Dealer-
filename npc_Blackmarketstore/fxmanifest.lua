fx_version 'cerulean'
game 'gta5'

author 'Dingos Development :: Developer: DINGO and Johnny'
description 'NPC Store Script'
version '1.0.0'

shared_script '@qb-core/shared/locale.lua'
client_script 'npc_store.lua'
server_script 'server.lua'

dependencies {
    'qb-target',
    'qb-core',
    'qb-inventory'
}
