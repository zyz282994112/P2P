classdef AUCEvaluation < Evaluation
    %%评价分类结果
    properties  %%定义类变量
        AUC;
        ClassLabel=1;
    end
    
    methods   %定义类方法
        function obj=AUCEvaluation(EvaluationName)
            obj=obj@Evaluation(EvaluationName);
        end
        
        function obj=Run(obj,truevector,precisionvector)
            [~,~,~,obj.AUC]=perfcurve(truevector,precisionvector,obj.ClassLabel);
        end
    end
    
end