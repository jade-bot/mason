CollisionObject = require './collisionObject'

module.exports = class RigidBody extends CollisionObject
  constructor: ->
    super
    
    @invInertiaTensorWorld = mat4.create()

    @linearVelocity = vec3.crate()
    @angularVelocity = vec3.create()
    
    @inverseMass = 0
    @linearFactor = vec3.create()
    
    @gravity = vec3.create()
    @gravity_acceleration = vec3.create()
    @invInertiaLocal = vec3.create()
    @totalForce = vec3.create()
    @totalTorque = vec3.create()
    
    @linearDamping = 0
    @angularDamping = 0
    @additionalDamping = false
    @additionalDampingFactor = 0
    @additionalLinearDampingThresholdSqr = 0
    @additionalAngularDampingThresholdSqr = 0
    @additionalAngularDampingFactor = 0
    
    @linearSleepingThreshold = 0
    @angularSleepingThreshold = 0
    
    @optionalMotionState = args.optionalMotionState or null
    
    @constraintRefs = []
    
    @rigidbodyFlags = 0
    @debugBodyId = 0
    
    @deltaLinearVelocity = vec3.create()
    @deltaAngularVelocity = vec3.create()
    @angularFactor = vec3.create()
    @invMass = vec3.create()
    @pushVelocity = vec3.create()
    @turnVelocity = vec3.create()
    
    @tempMat4 = mat4.create()
    @tempMat42 = mat4.create()
    
    @tempQuat4 = quat4.create()
    @tempQuat42 = quat4.create()
    
    @axis = vec3.create()
    @angle = 0
    
    @interpolationLinearVelocity = vec3.create()
    @interpolationAngularVelocity = vec3.create()
    @interpolationWorldTransform = vec3.create()
  
  calculateDiffAxisAngle: (transform0, transform1) ->
    mat4.inverse transform0.basis, @tempMat42
    mat4.multiply transform1.basis, @tempMat42, @tempMat4
    
    quat4.fromRotationMatrix @tempMat4, @tempQuat42
    quat4.toAngleAxis @tempMat42, @tempQuat4
    
    vec3.set @tempQuat4, @axis
    @angle = @tempQuat4[3]
  
  calculateVelocity: (transform0, transform1, timeStep) ->
    vec3.subtract transform1.origin, transform0.origin, @linearVelocity
    vec3.scale @linearVelocity, timeStep
    
    @calculateDiffAxisAngle transform0, transform1
    @angularVelocity = @axis * @angle / timeStep
  
  saveKinematicState: (timeStep) ->
    if timeStep isnt 0
      if @motionState?
        @worldTransform = @motionState.worldTransform
      
      @calculateVelocity @interpolationWorldTransform, @worldTransform, timeStep
      
      vec3.set @linearVelocity, @interpolationLinearVelocity
      vec3.set @angularVelocity, @interpolationAngularVelocity
      mat4.set @worldTransform, @interpolationWorldTransform