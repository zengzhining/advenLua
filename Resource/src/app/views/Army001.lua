local Army001 = class("Army001", function ()
	return cc.CSLoader:createNode("Npc/Npc1001.csb")
end)

function Army001:ctor( )
	self:initData()
	self:getChildByName("npc1001"):setFlippedX(true)
	self.act = cc.CSLoader:createTimeline("Npc/Npc1001.csb")
	self:runAction(self.act)
end

function Army001:initData(  )
	--设置随机数
	math.randomseed(os.time())
	self.typeId = 1

	self.body = self:getChildByName("npc1001")
end

function Army001:Walk(  )
	self.act:play("walk", true)
end

function Army001:Idle(  )
	self.act:play("idle", true)
end

function Army001:Hited(  )
	self.act:play("hit", true)
end

function Army001:playDefeatEffect(  )
	self:Hited()
	self:playHitSound()
	local function dieEffect(  )
		local effect = require ("app.Effect.ArmyDieEffect").new()
		self:addChild(effect)
		effect:playEffect()
	end

	local act = cc.Sequence:create(cc.DelayTime:create(1.5), cc.CallFunc:create(dieEffect) )
	self:runAction(act)
end

function Army001:playHitSound(  )
	AudioEngine.playEffect("music/effect/monster_damage.mp3", false)
end

function Army001:setPhysics(  )
	self:setPhysicsBody(cc.PhysicsBody:createCircle(25))
	self:getPhysicsBody():setContactTestBitmask(1)
	self:getPhysicsBody():setRotationEnable(false)
	self:getPhysicsBody():getShape(0):setFriction(0)
end

function Army001:setSpeed( speed )
	self:getPhysicsBody():setVelocity(cc.p(speed.x, speed.y))
end

return Army001