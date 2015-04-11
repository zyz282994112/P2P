classdef AUCEvaluation < EvaluationPackage.Evaluation
    %%���۷�����
    properties  %%���������
        AUC;
    end
    
    methods   %�����෽��
        function obj=AUCEvaluation(EvaluationName)
            obj=obj@EvaluationPackage.Evaluation(EvaluationName);
        end
        
        function obj=Run(obj,dataobj,truedata,~,score)
            [~,~,~,obj.AUC]=perfcurve(truedata,score,dataobj.ComputeLabel);
        end
    end
    
end