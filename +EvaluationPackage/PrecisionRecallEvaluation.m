classdef PrecisionRecallEvaluation < EvaluationPackage.Evaluation
    properties
        Precision;
        Recall;
    end
    
    properties(Hidden)
        ConfusionMatrix;
    end
    
    methods
        function obj=PrecisionRecallEvaluation(EvaluationName)
            obj=obj@EvaluationPackage.Evaluation(EvaluationName);
        end
        
        %         function obj=Run(obj,truedata,predictiondata)
        %             cp = classperf(strtrim(cellstr(num2str(truedata))));
        %             classperf(cp,strtrim(cellstr(num2str(predictiondata))));
        %             cp.ClassLabels
        %             confusionmat(strtrim(cellstr(num2str(truedata))),strtrim(cellstr(num2str(predictiondata))))
        %             obj.Precision=cp.PositivePredictiveValue;
        %             obj.Recall=cp.Sensitivity;
        %         end
        
        function obj=Run(obj,truedata,predictiondata)
            [obj.ConfusionMatrix,order]=confusionmat(strtrim(cellstr(num2str(truedata))),strtrim(cellstr(num2str(predictiondata))));
            order'
            obj.ConfusionMatrix(sum(obj.ConfusionMatrix')==0,:)=[];%#ok<UDIM> %%��ʵ���ݼ���������label�ӻ����������޳���
            precision=zeros(size(obj.ConfusionMatrix,1),1);  %%��Ҫ����ÿ�����ķ�������Ļ��������ֵ
            recall=zeros(size(obj.ConfusionMatrix,1),1);
            obj.Precision=0;
            obj.Recall=0;
            for i=1:length(recall)
                precision(i)=obj.ConfusionMatrix(i,i)/sum(obj.ConfusionMatrix(:,i));
                recall(i)=obj.ConfusionMatrix(i,i)/sum(obj.ConfusionMatrix(i,:));
                %                 sprintf('%.4f,%.4f',precision(i),recall(i))
                if isnan(precision(i))
                    precision(i)=0;
                end
                if isnan(recall(i))
                    recall(i)=0;
                end
                obj.Precision=obj.Precision+precision(i)*sum(obj.ConfusionMatrix(i,:));
                obj.Recall=obj.Recall+recall(i)*sum(obj.ConfusionMatrix(i,:));
            end
            obj.Precision=obj.Precision/length(truedata);
            obj.Recall=obj.Recall/length(truedata);
            obj.ConfusionMatrix
        end
        
    end
    
end