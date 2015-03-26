classdef AUCEvaluation < Evaluation
    %%���۷�����
    properties  %%���������
        AUC;
        ClassLabel=1;
    end
    
    methods   %�����෽��
        function obj=AUCEvaluation(EvaluationName)
            obj=obj@Evaluation(EvaluationName);
        end
        
        function obj=Run(obj,truevector,precisionvector)
            [~,~,~,obj.AUC]=perfcurve(truevector,precisionvector,obj.ClassLabel);
        end
    end
    
end