tempVec3 = vec3.create()

module.exports = integrateTransform = (curTrans, linvel, angvel, timeStep, predictedTransform) ->
  vec3.set linvel, tempVec3
  vec.scale tempVec3, timeStep
  vec3.add tempVec3, curTrans.origin
  vec3.set tempVec3, predictedTransform.origin
  
  # //  #define QUATERNION_DERIVATIVE
  #   #ifdef QUATERNION_DERIVATIVE
  #     btQuaternion predictedOrn = curTrans.getRotation();
  #     predictedOrn += (angvel * predictedOrn) * (timeStep * btScalar(0.5));
  #     predictedOrn.normalize();
  #   #else
  # //Exponential map
  # //google for "Practical Parameterization of Rotations Using the Exponential Map", F. Sebastian Grassia
  
  # btVector3 axis;
  fAngle = vec3.length angvel
  # //limit the angular motion
  if fAngle * timeStep > ANGULAR_MOTION_THRESHOLD
    fAngle = ANGULAR_MOTION_THRESHOLD / timeStep
  
  if fAngle < 0.001
    # // use Taylor's expansions of sync function
    axis = angvel * (0.5 * timeStep - (timeStep * timeStep * timeStep) * 0.020833333333 * fAngle * fAngle)
  else
    # // sync(fAngle) = sin(c*fAngle)/t
    axis = angvel * (Math.sin(0.5 * fAngle * timeStep) / fAngle)
  
  dorn = quat4.create()
  quat4.set axis, dorn
  quat4[3] = fAngle * timeStep * 0.5
  
  orn0 = curTrans.rotation
  
  quat4.multiply dorn, orn0, predictedOrn
  quat4.normalize predictedOrn
  
  mat3.setRotationFromQuaternion predictedOrn, predictedTransform