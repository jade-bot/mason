DefaultCollisionConfiguration = require './physics/defaultCollisionConfiguration'
CollisionDispatcher = require './physics/collisionDispatcher'
DBVTBroadphase = require './physics/DBVTBroadphase'
SequentialImpulseConstraintSolver = require './pysics/sequentialImpulseConstraintSolver'
DiscreteDynamicsWorld = require './physics/discreteDynamicsWorld'
Transform = require './physics/transform'
BoxShapre = require './physics/boxShape'

module.exports = class Physics
  constructor: ->
    collisionConfiguration = new DefaultCollisionConfiguration
    dispatcher = new CollisionDispatcher collisionConfiguration
    broadphase = new DBVTBroadphase
    solver = new SequentialImpulseConstraintSolver
    @world = new DiscreteDynamicsWorld
      dispatcher: dispatcher
      pairCache: broadphase
      solver: solver
      collisionConfig: collisionConfiguration
    
    @world.gravity = [0, -10, 0]
    
    @collisionShapes = []
    @collisionShapes.add = () ->
    
    @ground =
      shape: new BoxShape [50 50, 50]
      body = new RigidBody
        mass: 0
        transform: new Transform
        shape: @ground.shape
        inertia: @ground.inertia
    @ground.motionState = new DefaultMotionState @ground.transform
    @collisionShapes.push @ground.shape
    
    @world.addRigidBody ground.body
    
    for i in [0...1]
      @world.step 1 / 60, 10
      
      @ground.body.transform.position