classdef PrecisionRecallEvaluation < Evaluation
    %%���۷�����
    properties  %%���������
        Precision;
        Recall;
    end
    
    methods   %�����෽��
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