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
JOINT_TYPE_MOUSE     <-  5;
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
		return emo.physics.Joint(physics.createJoint(id, jointdef.id));
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
		physics.destroyFixture(id, fixture.id);
	}
	
	function setTransform(position, angle) {
		physics.body_setTransform(id, position, angle);
	}
	
	function getPosition() {
		return physics.body_getPosition(id);
	}
	
	function getAngle() {
		return physics.body_getAngle(id);
	}
	
	function getWorldCenter() {
		return physics.body_getWorldCenter(id);
	}
	
	function getLocalCenter() {
		return physics.body_getLocalCenter(id);
	}
	
	function setLinearVelocity(v) {
		physics.body_setLinearVelocity(id, v);
	}
	
	function getLinearVelocity() {
		return physics.body_getLinearVelocity(id);
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
	
	function resetMassData() {
		return physics.body_getMassData(id);
	}
	
	function getWorldPoint(localPoint) {
		return physics.body_getWorldPoint(id, localPoint);
	}
	
	function getWorldVector(localVector) {
		return physics.body_getWorldVector(id, localVector);
	}
	
	function getLocalPoint(worldPoint) {
		return physics.body_getLocalPoint(id, worldPoint);
	}
	
	function getLocalVector(worldVector) {
		return physics.body_getLocalVector(id, worldVector);
	}
	
	function getLinearVelocityFromWorldPoint(worldPoint) {
		return physics.body_getLinearVelocityFromWorldPoint(id, worldPoint);
	}
	
	function getLinearVelocityFromLocalPoint(localPoint) {
		return physics.body_getLinearVelocityFromLocalPoint(id, localPoint);
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
		return physics.body_isBullet(id);
	}
	
	function setSleepingAllowed(flag) {
		physics.body_setSleepingAllowed(id, flag);
	}
	
	function isSleepingAllowed() {
		return physics.body_isSleepingAllowed(id);
	}
	
	function setAwake(flag) {
		physics.body_setAwake(id, flag);
	}
	
	function isAwake() {
		return physics.body_isAwake(id);
	}
	
	function setActive(flag) {
		physics.body_setActive(id, flag);
	}
	
	function isActive() {
		return physics.isActive(id);
	}
	
	function setFixedRotation(flag) {
		physics.body_setFixedRotation(id, flag);
	}
	
	function isFixedRotation() {
		return physics.body_isFixedRotation(id);
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
	id = null;
	function constructor(_id) {
		id = _id;
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
class emo.physics.MouseJointDef extends emo.physics.JointDef {
	type = JOINT_TYPE_MOUSE;
	target       = null;
	maxForce     = null;
	frequencyHz  = null;
	dampingRatio = null;
	function constructor() {
		id = physics.newJointDef(type);
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

	function set(vertices, vertexCount) {
		physics.polygonShape_set(id, vertices, vertexCount);
	}
	
	function setAsBox(hx, hy, center = null, angle = null) {
		physics.polygonShape_setAsBox(id, hx, hy, center, angle);
	}
	
	function setAsEdge(v1, v2) {
		physics.polygonShape_setAsEdge(id, v1, v2);
	}
	
	function getVertex(idx) {
		return physics.polygonShape_getVertex(id, idx);
	}
	
	function getVertexCount() {
		return physics.polygonShape_getVertexCount(id);
	}
}

class emo.physics.CircleShape {
	id       = null;
	physics  = emo.Physics();
	m_radius = null;
	m_p      = null;
	function constructor() {
		id = physics.newShape(SHAPE_TYPE_CIRCLE);
		id.type = "emo.physics.CircleShape";
	}
	
	function update() {
		physics.updateCircleShape(id, this);
	}
}