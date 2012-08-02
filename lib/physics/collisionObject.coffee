module.exports = class CollisionObject
  constructor: (args = {}) ->
    @anisotropicFriction = [1, 1, 1]
    @hasAnisotropicFriction = no
    
    @contactProcessingThreshold = BT_LARGE_FLOAT
    @broadphaseHandle = 0
    @collisionShape = 0
    @extensionPointer = 0
    @rootCollisionShape = 0
    @collisionFlags = btCollisionObject::CF_STATIC_OBJECT
    @islandTag1 = -1
    @companionId = -1
    @activationState1 = 1
    @deactivationTime = 0
    @friction = 0.5
    @restitution = 0
    @internalType = CO_COLLISION_OBJECT
    @userObjectPointer = 0
    @hitFraction = 1
    @ccdSweptSphereRadius = 0
    @ccdMotionThreshold = 0
    @checkCollideWith = no

    @worldTransform = new Transofmr
    
    mat4.identity @worldTransform
  
  setActivationState: (newState) ->
    if @mactivationState1 isnt DISABLE_DEACTIVATION and @activationState1 isnt DISABLE_SIMULATION
      @activationState1 = newState

  forceActivationState: (newState) ->
    @activationState1 = newState
  
  activate: (forceActivation) ->
    if forceActivation or !(@collisionFlags & (CF_STATIC_OBJECT | CF_KINEMATIC_OBJECT)))
      @setActivationState ACTIVE_TAG
      @deactivationTime = 0
  
#   serialize: (dataBuffer, serializer) ->
#     btCollisionObjectData* dataOut = (btCollisionObjectData*)dataBuffer;

#     m_worldTransform.serialize(dataOut->m_worldTransform);
#     m_interpolationWorldTransform.serialize(dataOut->m_interpolationWorldTransform);
#     m_interpolationLinearVelocity.serialize(dataOut->m_interpolationLinearVelocity);
#     m_interpolationAngularVelocity.serialize(dataOut->m_interpolationAngularVelocity);
#     m_anisotropicFriction.serialize(dataOut->m_anisotropicFriction);
#     dataOut->m_hasAnisotropicFriction = m_hasAnisotropicFriction;
#     dataOut->m_contactProcessingThreshold = m_contactProcessingThreshold;
#     dataOut->m_broadphaseHandle = 0;
#     dataOut->m_collisionShape = serializer->getUniquePointer(m_collisionShape);
#     dataOut->m_rootCollisionShape = 0;//@todo
#     dataOut->m_collisionFlags = m_collisionFlags;
#     dataOut->m_islandTag1 = m_islandTag1;
#     dataOut->m_companionId = m_companionId;
#     dataOut->m_activationState1 = m_activationState1;
#     dataOut->m_deactivationTime = m_deactivationTime;
#     dataOut->m_friction = m_friction;
#     dataOut->m_restitution = m_restitution;
#     dataOut->m_internalType = m_internalType;
    
#     char* name = (char*) serializer->findNameForPointer(this);
#     dataOut->m_name = (char*)serializer->getUniquePointer(name);
#     if (dataOut->m_name)
#     {
#       serializer->serializeName(name);
#     }
#     dataOut->m_hitFraction = m_hitFraction;
#     dataOut->m_ccdSweptSphereRadius = m_ccdSweptSphereRadius;
#     dataOut->m_ccdMotionThreshold = m_ccdMotionThreshold;
#     dataOut->m_checkCollideWith = m_checkCollideWith;

#     return btCollisionObjectDataName;
# }


# void btCollisionObject::serializeSingleObject(class btSerializer* serializer) const
# {
#   int len = calculateSerializeBufferSize();
#   btChunk* chunk = serializer->allocate(len,1);
#   const char* structType = serialize(chunk->m_oldPtr, serializer);
#   serializer->finalizeChunk(chunk,structType,BT_COLLISIONOBJECT_CODE,(void*)this);
# }
