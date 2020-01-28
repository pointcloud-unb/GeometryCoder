% Author: Eduardo Peixoto
% E-mail: eduardopeixoto@ieee.org
function cabac = initCABAC(cabac, BACParams, interCoding, test3DOnlyContextsForInter, use4DContextsOnSingle)

if (nargin == 2)
    interCoding                = 0;
    use4DContextsOnSingle      = 0;
    test3DOnlyContextsForInter = 0;
end
    
%Gets the parameters.
cabac.BACParams = BACParams;

%Initializes the engine
cabac.BACEngine = getBACEncoder(BACParams.m);

nC_Independent = BACParams.numberOfContextsIndependent;
nC_2D          = BACParams.numberOfContextsMasked;
nC_3D          = BACParams.numberOf3DContexts;
nC_4D          = BACParams.numberOf4DContexts;
nC2D_3DOnly    = BACParams.numberOfContexts3DOnly;

if (interCoding == 0)
    %Initializes the 2D contexts.
    cabac.BACContexts_2D_Independent = initCountContexts_2D(nC_Independent);
    cabac.BACContexts_2D_Masked      = initCountContexts_2D(nC_2D);
    
    %Initializes the 3D contexts.
    cabac.BACContexts_3D             = initCountContexts_3D(nC_3D , nC_2D);
    cabac.BACContexts_3D_ORImages    = initCountContexts_3D(nC_3D , nC_2D);
else
    %When interCoding is used, one dimension (time) is added to all
    %contexts.
    %2D Contexts are now 3D
    cabac.BACContexts_2DT_Independent = initCountContexts_3D(nC_4D, nC_Independent);
    cabac.BACContexts_2DT_Masked      = initCountContexts_3D(nC_4D, nC_2D);
    
    %And 3D Contexts are now 4D
    %The 4D contexts are always initialized
    cabac.BACContexts_3DT             = initCountContexts_4D(nC_4D, nC_3D, nC_2D);
    
    %The 3D contexts are initialized IF they are considered for inter OR if
    %they are used for the single mode.
    %if ((use4DContextsOnSingle == 0) || (test3DOnlyContextsForInter == 1))        
        cabac.BACContexts_3D             = initCountContexts_3D(nC_3D, nC2D_3DOnly);
    %end
    %if (test3DOnlyContextsForInter == 1)        
        cabac.BACContexts_2D_Masked      = initCountContexts_2D(nC2D_3DOnly);
    %end
    
end

%Initializes the Parameter Contexts
cabac.ParamBitstream = Bitstream(1024);
