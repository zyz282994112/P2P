classdef AUCEvaluation < EvaluationPackage.Evaluation
    %%���۷�����
    properties  %%���������
        AUC;
    end
    
    methods   %�����෽��
        function obj=AUCEvaluation(EvaluationName)
            obj=obj@EvaluationPackage.Evaluation(EvaluationName);
        end
        
        function obj=Run(obj,truedata,predictiondata)
            ClassLabel=unique(truedata);
            everyauc=zeros(size(ClassLabel));
            obj.AUC=0;
            for i=1:length(ClassLabel)
                [~,~,~,everyauc(i)]=perfcurve(truedata,predictiondata,ClassLabel(i));
%                 everyauc(i)
                obj.AUC=obj.AUC+everyauc(i)*sum(truedata==ClassLabel(i));
            end
            obj.AUC=obj.AUC/length(truedata);
                
        end
    end
    
end