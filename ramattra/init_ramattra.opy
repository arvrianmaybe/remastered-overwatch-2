#!mainFile "../main.opy"

#!include "heroes/ramattra/nemesis.opy"
#!include "heroes/ramattra/vortex.opy"
#!include "heroes/ramattra/annihilation.opy"

rule "[ramattra/init_ramattra.opy]: Detect switch to ramattra":
    @Event eachPlayer
    @Hero ramattra

    eventPlayer.call_init = true


rule "[ramattra/init_ramattra.opy]: Initialize ramattra":
    @Event eachPlayer
    @Hero ramattra
    @Condition eventPlayer.call_init
    
    newHero(RAMATTRA_HEALTH, RAMATTRA_ARMOR, 0)
    setUltCost(RAMATTRA_ULT_COST)
    # Below variables are also declared and initialized in reset_hero.opy

    eventPlayer.setProjectileSpeed(percent(RAMATTRA_GUN_PROJECTILE_SPEED/OW2_RAMATTRA_GUN_PROJECTILE_SPEED))

    removeTankPassive()

    removePassiveHealing()

    eventPlayer.call_init = false