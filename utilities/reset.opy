#!mainFile "../main.opy"
#!include "utilities/stat_helper.opy"
#!include "ultimate/ultimate_cost.opy"
#!include "utilities/macro.opy"

globalvar reset_gvar
#!defineMember ready_color reset_gvar[0]

playervar reset_pvar
#!defineMember call_init reset_pvar[0]
#!defineMember friendly_doomfist_player reset_pvar[1]
#!defineMember friendly_orisa_player reset_pvar[2]
#!defineMember friendly_sombra_player reset_pvar[3]
#!defineMember enemy_doomfist_player reset_pvar[4]
#!defineMember enemy_orisa_player reset_pvar[5]
#!defineMember enemy_sombra_player reset_pvar[6]
#!defineMember friendly_lifeweaver_player reset_pvar[7]
#!defineMember enemy_lifeweaver_player reset_pvar[8]

subroutine enableAllAbilities
subroutine disableAllAbilities
subroutine resetStats
subroutine resetStatuses
subroutine resetFrenemies

#!define defaultHero() \
    newHero(0, 0, 0)

# newHero(0, 0, 0) creates default OW2 hero
#!define newHero(health, armor, shields) \
    clearCustomHp() \
    resetStats() \
    resetStatuses() \
    resetFrenemies() \
    resetUltCharge() \
    resetSelfHealing() \
    setCustomHp(health, armor, shields) \
    enableAllAbilities() \


def enableAllAbilities():
    @Name "[reset.opy]: enableAllAbilities()"

    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.allowButton(Button.ABILITY_1)
    eventPlayer.allowButton(Button.ABILITY_2)
    eventPlayer.allowButton(Button.ULTIMATE)

    eventPlayer.allowButton(Button.MELEE)
    eventPlayer.allowButton(Button.JUMP)
    eventPlayer.allowButton(Button.CROUCH)
    eventPlayer.allowButton(Button.RELOAD)
    eventPlayer.allowButton(Button.INTERACT)

    eventPlayer.setPrimaryFireEnabled(true)
    eventPlayer.setSecondaryFireEnabled(true)
    eventPlayer.setAbility1Enabled(true)
    eventPlayer.setAbility2Enabled(true)
    eventPlayer.setUltEnabled(true)

    eventPlayer.setMeleeEnabled(true)
    eventPlayer.setJumpEnabled(true)
    eventPlayer.setCrouchEnabled(true)
    eventPlayer.setReloadEnabled(true)

    eventPlayer.setKnockbackDealt(100)
    eventPlayer.setKnockbackReceived(100)

    eventPlayer.setMoveSpeed(100)

def disableAllAbilities():
    @Name "[reset.opy]: disableAllAbilities()"

    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.ULTIMATE)

    eventPlayer.disallowButton(Button.MELEE)
    eventPlayer.disallowButton(Button.JUMP)
    eventPlayer.disallowButton(Button.CROUCH)
    eventPlayer.disallowButton(Button.RELOAD)
    eventPlayer.disallowButton(Button.INTERACT)

    eventPlayer.setPrimaryFireEnabled(false)
    eventPlayer.setSecondaryFireEnabled(false)
    eventPlayer.setAbility1Enabled(false)
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.setUltEnabled(false)

    eventPlayer.setMeleeEnabled(false)
    eventPlayer.setJumpEnabled(false)
    eventPlayer.setCrouchEnabled(false)
    eventPlayer.setReloadEnabled(false)

    eventPlayer.setKnockbackDealt(0)
    eventPlayer.setKnockbackReceived(0)

    eventPlayer.setMoveSpeed(0)

def resetStats():
    @Name "[reset.opy]: resetStats()"

    setBaseDamage(eventPlayer, 1)
    eventPlayer.setDamageReceived(100)
    eventPlayer.setProjectileSpeed(100)
    eventPlayer.setProjectileGravity(100)
    eventPlayer.setHealingDealt(100)
    eventPlayer.setHealingReceived(100)
    eventPlayer.setKnockbackReceived(100)
    eventPlayer.setKnockbackDealt(100)
    eventPlayer.setGravity(100)
    eventPlayer.setMoveSpeed(100)
    destroyAllHudTexts()
    destroyAllProgressBarHuds()
    destroyAllInWorldTexts()


def resetStatuses():
    @Name "[reset.opy]: resetStatuses()"

    eventPlayer.clearStatusEffect(Status.ASLEEP)
    eventPlayer.clearStatusEffect(Status.BURNING)
    eventPlayer.clearStatusEffect(Status.FROZEN)
    eventPlayer.clearStatusEffect(Status.HACKED)
    eventPlayer.clearStatusEffect(Status.INVINCIBLE)
    eventPlayer.clearStatusEffect(Status.KNOCKED_DOWN)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.clearStatusEffect(Status.ROOTED)
    eventPlayer.clearStatusEffect(Status.STUNNED)
    eventPlayer.clearStatusEffect(Status.UNKILLABLE)


def resetFrenemies():
    @Name "[reset.opy]: resetFrenemies()"

    eventPlayer.friendly_doomfist_player = getPlayersOnHero(Hero.DOOMFIST, eventPlayer.getTeam())[0]
    eventPlayer.enemy_doomfist_player = getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam()))[0]
    eventPlayer.friendly_orisa_player = getPlayersOnHero(Hero.ORISA, eventPlayer.getTeam())[0]
    eventPlayer.enemy_orisa_player = getPlayersOnHero(Hero.ORISA, getOppositeTeam(eventPlayer.getTeam()))[0]
    eventPlayer.friendly_sombra_player = getPlayersOnHero(Hero.SOMBRA, eventPlayer.getTeam())[0]
    eventPlayer.enemy_sombra_player = getPlayersOnHero(Hero.SOMBRA, getOppositeTeam(eventPlayer.getTeam()))[0]
    eventPlayer.friendly_lifeweaver_player = getPlayersOnHero(Hero.DOOMFIST, eventPlayer.getTeam())[0]
    eventPlayer.enemy_lifeweaver_player = getPlayersOnHero(Hero.DOOMFIST, getOppositeTeam(eventPlayer.getTeam()))[0]

    
rule "[reset.opy]: Reinitialize hero on new round":
    @Event eachPlayer
    @Condition getCurrentGamemode() == Gamemode.CONTROL
    @Condition isMatchBetweenRounds()

    waitUntil(not isMatchBetweenRounds(), Math.INFINITY)
    eventPlayer.call_init = true