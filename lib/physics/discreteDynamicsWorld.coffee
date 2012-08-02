module.exports = class DiscreteDynamicsWorld
  constructor: (args = {}) ->
    @sortedConstraints = []
    @solverIslandCallback = null
    
    @gravity = [0, -9.81, 0]
    
    @time = 0
    
    @synchronizeAllMotionStates = no
    
    @islandManager = new SimulationIslandManager
    
    @dispatcher = args.dispatcher
    @pairCache = args.pairCache
    @constraintSolver = args.constraintSolver
    @collisionConfiguration = args.collisionConfiguration
    
    # @actions = []
    
    @bodies = []
  
  applyGravity: ->
    for body in @bodies when body.dynamic and body.active
      body.applyGravity()
    return
  
  saveKinematicState: (timeStep) ->
    for body in bodies when body.activationState isnt ISLAND_SLEEPING and body.kinematic
      body.saveKinematicState timeStep
  
  stepSimulation: (timeStep, maxSubSteps = 4, fixedTimeStep = 1 / 60) ->
    numSimulationSubSteps = 0
    
    if maxSubSteps
      @time += timeStep
      if @time >= fixedTimeStep
        numSimulationSubSteps = @time / fixedTimeStep
        @time -= numSimulationSubSteps * fixedTimeStep
    else
      fixedTimeStep = timeStep
      @time = timeStep
      if timeStep is 0
        numSimulationSubSteps = 0
        maxSubSteps = 0
      else
        numSimulationSubSteps = 1
        maxSubSteps = 1
    
    if numSimulationSubSteps
      clampedSimulationSteps = if numSimulationSubSteps > maxSubSteps then maxSubSteps else numSimulationSubSteps
      
      @saveKinematicState fixedTimeStep * clampedSimulationSteps
      
      @applyGravity()
      
      for i in [0...clampedSimulationSteps]
        @internalSingleStepSimulation fixedTimeStep
        @synchronizeMotionStates()
    
    else
      @synchronizeMotionStates()
    
    @clearForces()
    
    return numSimulationSubSteps