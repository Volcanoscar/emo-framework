#include "squirrel.h"

SQInteger emoPhysicsNewWorld(HSQUIRRELVM v);
SQInteger emoPhysicsNewShape(HSQUIRRELVM v);
SQInteger emoPhysicsCreateBody(HSQUIRRELVM v);
SQInteger emoPhysicsDestroyBody(HSQUIRRELVM v);
SQInteger emoPhysicsCreateJoint(HSQUIRRELVM v);
SQInteger emoPhysicsDestroyJoint(HSQUIRRELVM v);
SQInteger emoPhysicsWorld_Step(HSQUIRRELVM v);
SQInteger emoPhysicsWorld_ClearForces(HSQUIRRELVM v);
SQInteger emoPhysicsCreateFixture(HSQUIRRELVM v);
SQInteger emoPhysicsDestroyFixture(HSQUIRRELVM v);
SQInteger emoPhysicsNewJointDef(HSQUIRRELVM v);
SQInteger emoPhysicsWorld_SetAutoClearForces(HSQUIRRELVM v);
SQInteger emoPhysicsWorld_GetAutoClearForces(HSQUIRRELVM v);
SQInteger emoPhysicsPolygonShape_Set(HSQUIRRELVM v);
SQInteger emoPhysicsPolygonShape_SetAsBox(HSQUIRRELVM v);
SQInteger emoPhysicsPolygonShape_SetAsEdge(HSQUIRRELVM v);
SQInteger emoPhysicsPolygonShape_GetVertex(HSQUIRRELVM v);
SQInteger emoPhysicsPolygonShape_GetVertexCount(HSQUIRRELVM v);
SQInteger emoPhysicsBody_SetTransform(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetPosition(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetAngle(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetWorldCenter(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetLocalCenter(HSQUIRRELVM v);
SQInteger emoPhysicsBody_SetLinearVelocity(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetLinearVelocity(HSQUIRRELVM v);
SQInteger emoPhysicsBody_SetAngularVelocity(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetAngularVelocity(HSQUIRRELVM v);
SQInteger emoPhysicsBody_ApplyForce(HSQUIRRELVM v);
SQInteger emoPhysicsBody_ApplyTorque(HSQUIRRELVM v);
SQInteger emoPhysicsBody_ApplyLinearImpulse(HSQUIRRELVM v);
SQInteger emoPhysicsBody_ApplyAngularImpulse(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetMass(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetInertia(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetWorldPoint(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetWorldVector(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetLocalPoint(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetLocalVector(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetLinearVelocityFromWorldPoint(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetLinearVelocityFromLocalPoint(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetLinearDamping(HSQUIRRELVM v);
SQInteger emoPhysicsBody_SetLinearDamping(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetAngularDamping(HSQUIRRELVM v);
SQInteger emoPhysicsBody_SetAngularDamping(HSQUIRRELVM v);
SQInteger emoPhysicsBody_SetType(HSQUIRRELVM v);
SQInteger emoPhysicsBody_GetType(HSQUIRRELVM v);
SQInteger emoPhysicsBody_SetBullet(HSQUIRRELVM v);
SQInteger emoPhysicsBody_IsBullet(HSQUIRRELVM v);
SQInteger emoPhysicsBody_SetSleepingAllowed(HSQUIRRELVM v);
SQInteger emoPhysicsBody_IsSleepingAllowed(HSQUIRRELVM v);
SQInteger emoPhysicsBody_SetAwake(HSQUIRRELVM v);
SQInteger emoPhysicsBody_IsAwake(HSQUIRRELVM v);
SQInteger emoPhysicsBody_SetActive(HSQUIRRELVM v);
SQInteger emoPhysicsBody_IsActive(HSQUIRRELVM v);
SQInteger emoPhysicsBody_SetFixedRotation(HSQUIRRELVM v);
SQInteger emoPhysicsBody_IsFixedRotation(HSQUIRRELVM v);