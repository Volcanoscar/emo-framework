/******************************************************
 *                                                    *
 *   PHYSICS CLASSES AND CONSTANTS FOR EMO-FRAMEWORK  *
 *                                                    *
 *            !!DO NOT EDIT THIS FILE!!               *
 ******************************************************/

BODY_TYPE_STATIC     <- 0;
BODY_TYPE_KINEMATIC  <- 1;
BODY_TYPE_DYNAMIC    <- 2;

SHAPE_TYPE_UNKNOWN   <- -1;
SHAPE_TYPE_CIRCLE    <-  0;
SHAPE_TYPE_POLYGON   <-  1;

JOINT_TYPE_UNKNOWN   <-  0;
JOINT_TYPE_REVOLUTE  <-  1;
JOINT_TYPE_PRISMATIC <-  2;
JOINT_TYPE_DISTANCE  <-  3;
JOINT_TYPE_PULLEY    <-  4;
JOINT_TYPE_GEAR      <-  6;
JOINT_TYPE_LINE      <-  7;
JOINT_TYPE_WELD      <-  8;
JOINT_TYPE_FRICTION  <-  9;

class emo.Vec2 {
	x = null;
	y = null;
	function constructor(_x, _y) {
		x = _x;
		y = _y;
	}
	
	function set(_x, _y) {
		x = _x;
		y = _y;
	}
	
	function getInstance(arg) {
		if (arg == null || arg.len() < 2) return null;
		return emo.Vec2(arg[0], arg[1]);
	}
}

emo.physics <- {};

class emo.physics.World {
	id      = null;
	physics = emo.Physics();
	function constructor(gravity, doSleep) {
		id = physics.newWorld(gravity, doSleep);
	}
	
	function createBody(bodydef) {
		return emo.physics.Body(physics.createBody(id, bodydef));
	}
	
	function destroyBody(body) {
		physics.destroyBody(id, body.id);
	}
	
	function createJoint(jointdef) {
		switch(jointdef.type) {
		case JOINT_TYPE_DISTANCE:
			return emo.physics.DistanceJoint(physics.createJoint(id, jointdef.id));
			break;
		case JOINT_TYPE_FRICTION:
			return emo.physics.FrictionJoint(physics.createJoint(id, jointdef.id));
			break;
		case JOINT_TYPE_GEAR:
			return emo.physics.GearJoint(physics.createJoint(id, jointdef.id));
			break;
		case JOINT_TYPE_LINE:
			return emo.physics.LineJoint(physics.createJoint(id, jointdef.id));
			break;
		case JOINT_TYPE_PRISMATIC:
			return emo.physics.PrismaticJoint(physics.createJoint(id, jointdef.id));
			break;
		case JOINT_TYPE_PULLEY:
			return emo.physics.PulleyJoint(physics.createJoint(id, jointdef.id));
			break;
		case JOINT_TYPE_REVOLUTE:
			return emo.physics.RevoluteJoint(physics.createJoint(id, jointdef.id));
			break;
		case JOINT_TYPE_WELD:
			return emo.physics.WeldJoint(physics.createJoint(id, jointdef.id));
			break;
		}
	}
	
	function destroyJoint(joint) {
		physics.destroyJoint(id, joint.id);
	}
	
	function step(timeStep, velocityIterations, positionIterations) {
		physics.world_step(id, timeStep, velocityIterations, positionIterations);
	}
	
	function clearForces() {
		physics.world_clearForces(id);
	}
	
	function setAutoClearForces(flag) {
		physics.world_setAutoClearForces(id, flag);
	}
	
	function getAutoClearForces() {
		return physics.world_getAutoClearForces(id);
	}
}

class emo.physics.AABB {
	lowerBound = null;
	upperBound = null;
}

class emo.physics.Body {
	id      = null;
	physics = emo.Physics();
	function constructor(_id) {
		id = _id;
	}
	
	function createFixture(...) {
		if (vargv.len() == 1) {
			return emo.physics.Fixture(id, physics.createFixture(id, vargv[0]));
		} else if (vargv.len() >= 2) {
			local def   = emo.physics.FixtureDef();
			def.shape   = vargv[0];
			def.density = vargv[1];
			return emo.physics.Fixture(id, physics.createFixture(id, def));
		}
		return null;
	}
	
	function destroyFixture(fixture) {
		return physics.destroyFixture(id, fixture.id);
	}
	
	function setTransform(position, angle) {
		return physics.body_setTransform(id, position, angle);
	}
	
	function getPosition() {
		return emo.Vec2.getInstance(physics.body_getPosition(id));
	}
	
	function getAngle() {
		return physics.body_getAngle(id);
	}
	
	function getWorldCenter() {
		return emo.Vec2.getInstance(physics.body_getWorldCenter(id));
	}
	
	function getLocalCenter() {
		return emo.Vec2.getInstance(physics.body_getLocalCenter(id));
	}
	
	function setLinearVelocity(v) {
		physics.body_setLinearVelocity(id, v);
	}
	
	function getLinearVelocity() {
		return emo.Vec2.getInstance(physics.body_getLinearVelocity(id));
	}
	
	function setAngularVelocity(omega) {
		physics.body_setAngularVelocity(id, omega);
	}
	
	function getAngularVelocity() {
		return physics.body_getAngularVelocity(id);
	}
	
	function applyForce(force, point) {
		physics.body_applyForce(id, force, point);
	}
	
	function applyTorque(torque) {
		physics.body_applyTorque(id, torque);
	}
	
	function applyLinearImpulse(impulse, point) {
		physics.body_applyLinearImpulse(id, impulse, point);
	}
	
	function applyAngularImpulse(impulse) {
		physics.body_applyAngularImpulse(id, impulse);
	}
	
	function getMass() {
		return physics.body_getMass(id);
	}
	
	function getInertia() {
		return physics.body_getInertia(id);
	}
	
	function getWorldPoint(localPoint) {
		return emo.Vec2.getInstance(physics.body_getWorldPoint(id, localPoint));
	}
	
	function getWorldVector(localVector) {
		return emo.Vec2.getInstance(physics.body_getWorldVector(id, localVector));
	}
	
	function getLocalPoint(worldPoint) {
		return emo.Vec2.getInstance(physics.body_getLocalPoint(id, worldPoint));
	}
	
	function getLocalVector(worldVector) {
		return emo.Vec2.getInstance(physics.body_getLocalVector(id, worldVector));
	}
	
	function getLinearVelocityFromWorldPoint(worldPoint) {
		return emo.Vec2.getInstance(physics.body_getLinearVelocityFromWorldPoint(id, worldPoint));
	}
	
	function getLinearVelocityFromLocalPoint(localPoint) {
		return emo.Vec2.getInstance(physics.body_getLinearVelocityFromLocalPoint(id, localPoint));
	}
	
	function getLinearDamping() {
		return physics.body_getLinearDamping(id);
	}
	
	function setLinearDamping(linearDamping) {
		physics.body_setLinearDamping(id, linearDamping);
	}
	
	function getAngularDamping() {
		return physics.body_getAngularDamping(id);
	}
	
	function setAngularDamping(angularDamping) {
		physics.body_setAngularDamping(id, angularDamping);
	}
	
	function setType(bodyType) {
		physics.body_setType(id, bodyType);
	}
	
	function getType() {
		return physics.body_getType(id);
	}
	
	function setBullet(flag) {
		physics.body_setBullet(id, flag);
	}
	
	function isBullet() {
		return physics.body_isBullet(id) == EMO_YES;
	}
	
	function setSleepingAllowed(flag) {
		physics.body_setSleepingAllowed(id, flag);
	}
	
	function isSleepingAllowed() {
		return physics.body_isSleepingAllowed(id) == EMO_YES;
	}
	
	function setAwake(flag) {
		physics.body_setAwake(id, flag);
	}
	
	function isAwake() {
		return physics.body_isAwake(id) == EMO_YES;
	}
	
	function setActive(flag) {
		physics.body_setActive(id, flag);
	}
	
	function isActive() {
		return physics.isActive(id) == EMO_YES;
	}
	
	function setFixedRotation(flag) {
		physics.body_setFixedRotation(id, flag);
	}
	
	function isFixedRotation() {
		return physics.body_isFixedRotation(id) == EMO_YES;
	}
}

class emo.physics.BodyDef {
	type            = null;
	position        = null;
	angle           = null;
	linearVelocity  = null;
	angularVelocity = null;
	linearDamping   = null;
	angularDamping  = null;
	allowSleep      = null;
	awake           = null;
	fixedRotation   = null;
	bullet          = null;
	active          = null;
	inertiaScale    = null;
}

class emo.physics.Fixture {
	id     = null;
	bodyId = null;
	function constructor(_bodyId, _id) {
		bodyId = _bodyId;
		id     = _id;
	}
}

class emo.physics.FixtureDef {
	shape       = null;
	friction    = null;
	restitution = null;
	density     = null;
	isSensor    = null;
	filter      = null;
}

class emo.physics.Joint {
	id    = null;
	type = null;
	physics  = emo.Physics();
	function constructor(_id) {
		id = _id;
	}
	function getType() {
		return type;
	}
	function getAnchorA() {
		return emo.Vec2.getInstance(physics.joint_getAnchorA(id));
	}
	function getAnchorB() {
		return emo.Vec2.getInstance(physics.joint_getAnchorB(id));
	}
	function getReactionForce(inv_dt) {
		return emo.Vec2.getInstance(physics.joint_getReactionForce(id, inv_dt));
	}
	function getReactionTorque(inv_dt) {
		return emo.Vec2.getInstance(physics.joint_getReactionTorque(id, inv_dt));
	}
}
class emo.physics.DistanceJoint extends emo.physics.Joint {
	function constructor(_id) {
		id = _id;
		type = JOINT_TYPE_DISTANCE;
	}
	function setLength(length) {
		return physics.joint_setLength(id, length);
	}
	function getLength() {
		return physics.joint_getLength(id);
	}
	function setFrequency(hz) {
		return physics.joint_setFrequency(id, hz);
	}
	function getFrequency() {
		return physics.joint_getFrequency(id);
	}
	function setDampingRatio(ratio) {
		return physics.joint_setDampingRatio(id, ratio);
	}
	function getDampingRatio() {
		return physics.joint_getDampingRatio(id);
	}
}
class emo.physics.FrictionJoint extends emo.physics.Joint {
	function constructor(_id) {
		id = _id;
		type = JOINT_TYPE_FRICTION;
	}
	function setMaxForce(force) {
		return physics.joint_setMaxForce(id, force);
	}
	function getMaxForce() {
		return physics.joint_getMaxForce(id);
	}
	function setMaxTorque(torque) {
		return physics.joint_setMaxTorque(id, torque);
	}
	function getMaxTorque() {
		return physics.joint_getMaxTorque(id);
	}
}
class emo.physics.GearJoint extends emo.physics.Joint {
	function constructor(_id) {
		id = _id;
		type = JOINT_TYPE_GEAR;
	}
	function setRatio(ratio) {
		return physics.joint_setRatio(id, ratio);
	}
	function getRatio() {
		return physics.joint_getRatio(id);
	}
}
class emo.physics.LineJoint extends emo.physics.Joint {
	function constructor(_id) {
		id = _id;
		type = JOINT_TYPE_LINE;
	}
	function getJointTranslation() {
		return physics.joint_getJointTranslation(id);
	}
	function getJointSpeed() {
		return physics.joint_getJointSpeed(id);
	}
	function isLimitedEnabled() {
		return physics.joint_isLimitedEnabled(id);
	}
	function enableLimit(flag) {
		return physics.joint_enableLimit(id, flag);
	}
	function getLowerLimit() {
		return physics.joint_getLowerLimit(id);
	}
	function getUpperLimit() {
		return physics.joint_getUpperLimit(id);
	}
	function setLimits(lower, upper) {
		return physics.joint_setLimits(id, lower, upper);
	}
	function isMotorEnabled() {
		return physics.joint_isMotorEnabled(id);
	}
	function enableMotor(flag) {
		return physics.joint_enableMotor(id, flag);
	}
	function setMotorSpeed(speed) {
		return physics.joint_setMotorSpeed(id, speed);
	}
	function setMaxMotorForce(force) {
		return physics.joint_setMaxMotorForce(id, force);
	}
	function getMotorForce() {
		return physics.joint_getMotorForce(id);
	}
}
class emo.physics.PrismaticJoint extends emo.physics.Joint {
	function constructor(_id) {
		id = _id;
		type = JOINT_TYPE_PRISMATIC;
	}
	function getJointTranslation() {
		return physics.joint_getJointTranslation(id);
	}
	function getJointSpeed() {
		return physics.joint_getJointSpeed(id);
	}
	function isLimitedEnabled() {
		return physics.joint_isLimitedEnabled(id);
	}
	function enableLimit(flag) {
		return physics.joint_enableLimit(id, flag);
	}
	function getLowerLimit() {
		return physics.joint_getLowerLimit(id);
	}
	function getUpperLimit() {
		return physics.joint_getUpperLimit(id);
	}
	function setLimits(lower, upper) {
		return physics.joint_setLimits(id, lower, upper);
	}
	function isMotorEnabled() {
		return physics.joint_isMoterEnabled(id);
	}
	function enableMoter(flag) {
		return physics.joint_enableMoter(id, flag);
	}
	function setMotorSpeed(speed) {
		return physics.joint_setMotorSpeed(id, speed);
	}
	function setMaxMotorForce(force) {
		return physics.joint_setMaxMotorForce(id, force);
	}
	function getMotorForce() {
		return physics.joint_getMotorForce(id);
	}
}
class emo.physics.PulleyJoint extends emo.physics.Joint {
	function constructor(_id) {
		id = _id;
		type = JOINT_TYPE_PULLEY;
	}
	function getGroundAnchorA() {
		return emo.Vec2.getInstance(physics.joint_getGroundAnchorA(id));
	}
	function getGroundAnchorB() {
		return emo.Vec2.getInstance(physics.joint_getGroundAnchorB(id));
	}
	function getLength1() {
		return physics.joint_getLength1(id);
	}
	function getLength2() {
		return physics.joint_getLength2(id);
	}
	function getRatio() {
		return physics.joint_getRatio(id);
	}
}
class emo.physics.RevoluteJoint extends emo.physics.Joint {
	function constructor(_id) {
		id = _id;
		type = JOINT_TYPE_REVOLUTE;
	}
	function getJointAngle() {
		return physics.joint_getJointAngle(id);
	}
	function getJointSpeed() {
		return physics.joint_getJointSpeed(id);
	}
	function isLimitedEnabled() {
		return physics.joint_isLimitedEnabled(id);
	}
	function enableLimit(flag) {
		return physics.joint_enableLimit(id, flag);
	}
	function getLowerLimit() {
		return physics.joint_getLowerLimit(id);
	}
	function getUpperLimit() {
		return physics.joint_getUpperLimit(id);
	}
	function setLimits(lower, upper) {
		return physics.joint_setLimits(id, lower, upper);
	}
	function isMotorEnabled() {
		return physics.joint_isMoterEnabled(id);
	}
	function enableMoter(flag) {
		return physics.joint_enableMoter(id, flag);
	}
	function setMotorSpeed(speed) {
		return physics.joint_setMotorSpeed(id, speed);
	}
	function setMaxMotorTorque(torque) {
		return physics.joint_setMaxMotorTorque(id, torque);
	}
	function getMotorTorque() {
		return physics.joint_getMotorTorque(id);
	}
}
class emo.physics.WeldJoint extends emo.physics.Joint {
	function constructor(_id) {
		id = _id;
		type = JOINT_TYPE_WELD;
	}
}
class emo.physics.JointDef {
	id       = null;
	type     = null;
	bodyA    = null;
	bodyB    = null;
	physics  = emo.Physics();
	collideConnected = null;
	function update() {
		physics.updateJointDef(id, this);
	}
}

class emo.physics.DistanceJointDef extends emo.physics.JointDef {
	type = JOINT_TYPE_DISTANCE;
	frequencyHz  = null;
	dampingRatio = null;
	
	function constructor() {
		id = physics.newJointDef(type);
	}
	
	function initialize(bodyA, bodyB, anchorA, anchorB) {
		physics.initDistanceJointDef(id, bodyA, bodyB, anchorA, anchorB);
	}
}
class emo.physics.FrictionJointDef extends emo.physics.JointDef {
	type = JOINT_TYPE_FRICTION;
	maxForce     = null;
	maxTorque    = null;
	function constructor() {
		id = physics.newJointDef(type);
	}
	function initialize(bodyA, bodyB, anchor) {
		physics.initFrictionJointDef(id, bodyA, bodyB, anchor);
	}
}
class emo.physics.GearJointDef extends emo.physics.JointDef {
	type = JOINT_TYPE_GEAR;
	joint1 = null;
	joint2 = null;
	ratio  = null;
	function constructor() {
		id = physics.newJointDef(type);
	}
}
class emo.physics.LineJointDef extends emo.physics.JointDef {
	type = JOINT_TYPE_LINE;
	enableLimit  = null;
	lowerTranslation = null;
	upperTranslation = null;
	enableMotor   = null;
	maxMotorForce = null;
	motorSpeed    = null;
	function constructor() {
		id = physics.newJointDef(type);
	}
	function initialize(bodyA, bodyB, anchor, axis) {
		physics.initLineJointDef(id, bodyA, bodyB, anchor, axis);
	}
}
class emo.physics.PrismaticJointDef extends emo.physics.JointDef {
	type = JOINT_TYPE_PRISMATIC;
	enableLimit    = null;
	lowerTranslation = null;
	upperTranslation = null;
	enableMotor   = null;
	maxMotorForce = null;
	motorSpeed    = null;
	function constructor() {
		id = physics.newJointDef(type);
	}
	function initialize(bodyA, bodyB, anchor, axis) {
		physics.initPrismaticJointDef(id, bodyA, bodyB, anchor, axis);
	}
}
class emo.physics.PulleyJointDef extends emo.physics.JointDef {
	type = JOINT_TYPE_PULLEY;
	function constructor() {
		id = physics.newJointDef(type);
	}
	function initialize(bodyA, bodyB, groundAnchorA, groundAnchorB, anchorA, anchorB, ratio) {
		physics.initPulleyJointDef(id, bodyA, bodyB,
			groundAnchorA, groundAnchorB, anchorA, anchorB, ratio);
	}
}
class emo.physics.RevoluteJointDef extends emo.physics.JointDef {
	type = JOINT_TYPE_REVOLUTE;
	enableLimit = null;
	lowerAngle  = null;
	upperAngle  = null;
	enableMotor = null;
	motorSpeed  = null;
	maxMotorTorque = null;
	function constructor() {
		id = physics.newJointDef(type);
	}
	function initialize(bodyA, bodyB, anchor) {
		physics.initRevoluteJointDef(id, bodyA, bodyB, anchor);
	}
}
class emo.physics.WeldJointDef extends emo.physics.JointDef {
	type = JOINT_TYPE_WELD;
	function constructor() {
		id = physics.newJointDef(type);
	}
	function initialize(bodyA, bodyB, anchor) {
		physics.initWeldJointDef(id, bodyA, bodyB, anchor);
	}
}

class emo.physics.PolygonShape {
	id      = null;
	physics = emo.Physics();
	
	function constructor() {
		id = physics.newShape(SHAPE_TYPE_POLYGON);
		id.type = "emo.physics.PolygonShape";
	}

	function set(vertices) {
		return physics.polygonShape_set(id, vertices);
	}
	
	function setAsBox(hx, hy, center = null, angle = null) {
		return physics.polygonShape_setAsBox(id, hx, hy, center, angle);
	}
	
	function setAsEdge(v1, v2) {
		return physics.polygonShape_setAsEdge(id, v1, v2);
	}
	
	function getVertex(idx) {
		return emo.Vec2.getInstance(physics.polygonShape_getVertex(id, idx));
	}
	
	function getVertexCount() {
		return physics.polygonShape_getVertexCount(id);
	}
	
	function setRadius(radius) {
		return physics.polygonShape_radius(id, radius);
	}
}

class emo.physics.CircleShape {
	id       = null;
	physics  = emo.Physics();
	function constructor() {
		id = physics.newShape(SHAPE_TYPE_CIRCLE);
		id.type = "emo.physics.CircleShape";
	}

	function setPosition(position) {
		return physics.circleShape_position(id, position);
	}
	
	function setRadius(radius) {
		return physics.circleShape_radius(id, radius);
	}
}