class WizardRpgSimulator
  def initialize(@gameMode : Int32)
    @spells = [
      WizardRpgSpell.new("Magic Missile", 53, 4, 0, 0, 0, 0),
      WizardRpgSpell.new("Drain", 73, 2, 0, 2, 0, 0),
      WizardRpgSpell.new("Shield", 113, 0, 7, 0, 0, 6),
      WizardRpgSpell.new("Poison", 173, 3, 0, 0, 0, 6),
      WizardRpgSpell.new("Recharge", 229, 0, 0, 0, 101, 5),
    ]
  end

  def winWithLowestCost(bossPoints, bossDamage)
    boss = WizardRpgBoss.new(bossPoints, bossDamage)
    player = WizardRpgPlayer.new(500, 50, 0)
    lowest = run(boss, player, [] of WizardRpgEffect, 0)

    lowest
  end

  def run(boss, player, effects, cost) : Int32
    costs = [] of Int32
    i = 0
    while i < @spells.size
      spell = @spells[i]
      newBoss = WizardRpgBoss.new(boss.points, boss.damage)
      newPlayer = WizardRpgPlayer.new(player.mana, player.points, player.damage)
      newCost = cost + spell.cost

      if @gameMode == 2
        newPlayer.points += 1
      end

      newEffects = effects.map { |o| WizardRpgEffect.new(o.name, o.damage, o.armor, o.healing, o.recharge, o.timer) }
      newEffect = spell.getEffect
      hasCastSpell = false

      if newEffect.timer == 0 && canCastSpell(newEffects, player, spell)
        newPlayer.mana += newEffect.recharge
        newPlayer.mana -= spell.cost
        newPlayer.points += newEffect.healing
        newBoss.points -= newEffect.damage
        hasCastSpell = true
      end

      reshargeSum = newEffects.sum { |o| o.recharge }
      newPlayer.mana += reshargeSum
      newPlayer.points += newEffects.sum { |o| o.healing }
      bossDamage = newEffects.sum { |o| o.damage }
      newBoss.points -= bossDamage
      ib = 0
      while ib < newEffects.size
        newEffects[ib].timer -= 1
      end

      if !newBoss.isAlive
        costs.push(newCost)
        next
      end

      newEffects = newEffects.select { |o| o.timer > 0 }
      if newEffect.timer > 0 && canCastSpell(newEffects, player, spell)
        newPlayer.mana -= spell.cost
        newEffects.push(newEffect)
        hasCastSpell = true
      end

      if hasCastSpell
        next
      end

      newPlayer.mana += newEffects.sum { |o| o.recharge }
      newPlayer.points += newEffects.sum { |o| o.healing }
      newBoss.points -= newEffects.sum { |o| o.damage }
      playerDamage = Math.max(newBoss.damage - newEffects.sum { |o| o.armor }, 1)
      newPlayer.points -= playerDamage
      ip = 0
      while ip < newEffects.size
        newEffects[ip].timer -= 1
      end
      newEffects = newEffects.select { |o| o.timer > 0 }

      if !newBoss.isAlive
        costs.push(newCost)
        next
      end

      if !newPlayer.isAlive
        next
      end

      nextCost = run(newBoss, newPlayer, newEffects, newCost)
      if nextCost > 0
        costs.push(nextCost)
      end
    end

    return costs.any? ? costs.min : 0
  end

  def canCastSpell(effects, player, spell)
    canAffordSpell = player.mana >= spell.cost
    spellAlreadyCast = effects.map { |o| o.name == spell.name }.size > 0
    canAffordSpell && !spellAlreadyCast
  end
end

class WizardRpgSpell
  property name
  property cost
  property damage
  property armor
  property healing
  property recharge
  property timer

  def initialize(@name : String, @cost : Int32, @damage : Int32, @armor : Int32, @healing : Int32, @recharge : Int32, @timer : Int32)
  end

  def getEffect
    WizardRpgEffect.new(@name, @damage, @armor, @healing, @recharge, @timer)
  end
end

class WizardRpgEffect
  property name
  property damage
  property armor
  property healing
  property recharge
  property timer

  def initialize(@name : String, @damage : Int32, @armor : Int32, @healing : Int32, @recharge : Int32, @timer : Int32)
  end
end

class WizardRpgCharacter
  property points
  property damage

  def initialize(@points : Int32, @damage : Int32)
  end

  def isAlive
    @points > 0
  end
end

class WizardRpgPlayer < WizardRpgCharacter
  property mana

  def initialize(@mana : Int32, @points : Int32, @damage : Int32)
  end
end

class WizardRpgBoss < WizardRpgCharacter
end

bossPoints = 71
bossDamage = 10

simulator = WizardRpgSimulator.new(1)
cost = simulator.winWithLowestCost(bossPoints, bossDamage)
