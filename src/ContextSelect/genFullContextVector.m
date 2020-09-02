function fullContextVector = genFullContextVector(enc)
values = enc.params.BACParams;

fullContextVector = [values.contextVector4DTIndependent...
     values.contextVector2DTIndependent...
     values.contextVector4DTMasked...
     values.contextVector2DTMasked...
     values.contextVector2DMasked...
     values.contextVector3DORImages...
     values.contextVector2DORImages...
     values.contextVector4DTORImages...
     values.contextVector3DTORImages...
     values.contextVector2DTORImages...
     values.contextVector4DT...
     values.contextVector3DT...
     values.contextVector2DT...
     values.contextVector3D...
     values.contextVector2D...
];

fullContextVector = logical(fullContextVector);
