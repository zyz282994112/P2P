classdef Evaluation < handle&matlab.mixin.Copyable
    %%���۷�����
    properties  %%���������
        EvaluationName;
    end
    
    methods   %�����෽��
        function obj=Evaluation(EvaluationName)
            obj.EvaluationName=EvaluationName;
        end      
    end
    
    methods(Abstract)
       obj=Run(obj,dataobj,truevector,precisionvector,varargin); 
    end
    
end