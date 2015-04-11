classdef AUCEvaluation < EvaluationPackage.Evaluation
    %%评价分类结果
    properties  %%定义类变量
        AUC;
    end
    
    methods   %定义类方法
        function obj=AUCEvaluation(EvaluationName)
            obj=obj@EvaluationPackage.Evaluation(EvaluationName);
        end
        
        function obj=Run(obj,dataobj,truedata,~,score)
            [~,~,~,obj.AUC]=perfcurve(truedata,score,dataobj.ComputeLabel);
        end
    end
    
end