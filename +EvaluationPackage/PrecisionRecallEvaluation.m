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
        
        function obj=Run(obj,dataobj,truedata,predictiondata,varargin)
            [obj.ConfusionMatrix,order]=confusionmat(strtrim(cellstr(num2str(truedata))),strtrim(cellstr(num2str(predictiondata))));
            %             order'
            %             obj.ConfusionMatrix
%             obj.ConfusionMatrix(sum(obj.ConfusionMatrix')==0,:)=[];%#ok<UDIM> %%真实数据集不包含的label从混淆矩阵中剔除。
            precision=diag(obj.ConfusionMatrix)./sum(obj.ConfusionMatrix)';
            recall=diag(obj.ConfusionMatrix)./sum(obj.ConfusionMatrix')';
            precision(isnan(precision))=0;
            recall(isnan(recall))=0;
            if ~isempty(dataobj.ComputeLabel)
                tag=find(strcmp(order,dataobj.ComputeLabel));%%要计算类别所处的位置
                obj.Precision=precision(tag);
                obj.Recall=recall(tag);
            else
                obj.Precision=sum(precision.*sum(obj.ConfusionMatrix')')/length(truedata);%% compute average precision
                obj.Recall=sum(recall.*sum(obj.ConfusionMatrix')')/length(truedata);%% compute average recall 
            end
            
        end
        
    end
    
end