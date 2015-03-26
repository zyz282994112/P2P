classdef PrecisionRecallEvaluation < Evaluation
    %%评价分类结果
    properties  %%定义类变量
        Precision;
        Recall;
    end
    
    methods   %定义类方法
        function obj=PrecisionRecallEvaluation(EvaluationName)
            obj=obj@Evaluation(EvaluationName);
        end
        
        function obj=Run(obj,truevector,precisionvector)
            cp = classperf(cellstr(num2str(truevector)));
            classperf(cp,cellstr(num2str(precisionvector)));
            obj.Precision=cp.PositivePredictiveValue;
            obj.Recall=cp.Sensitivity;
        end
        
    end
    
end