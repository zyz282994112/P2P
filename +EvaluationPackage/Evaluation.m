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
       obj=Run(obj,truevector,precisionvector); 
    end
    
end