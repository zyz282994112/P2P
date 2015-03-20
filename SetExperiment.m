classdef SetExperiment < handle
    %实验设置
    properties  %%定义类变量
        DataLabel;
        DataFeature;
        DataMatrix;
    end
    methods   %定义类方法
        function obj=SetExperiment(DataLabel,DataFeature,DataMatrix)
            obj.DataLabel=DataLabel;
            obj.DataFeature=DataFeature;
            obj.DataMatrix=DataMatrix;
        end
        
        function crossValidateModel(obj,classify,k)
            indices = crossvalind('Kfold',obj.DataLabel{1},k);
            cp = classperf(cellstr(num2str(obj.DataLabel{1})));
            prediction=zeros(size(obj.DataLabel{1}));
            for i = 1:k
                testtag = (indices == i); traintag = ~testtag;
                classify.Run(traintag,testtag,1);
                classperf(cp,cellstr(num2str(classify.PredictionLabel)),testtag);
                prediction(indices==i,:)=classify.PredictionLabel;
            end
            [~,~,~,auc]=perfcurve(obj.DataLabel{1},prediction,cp.ClassLabels{1});
            auc
            cp.ErrorRate
        end
        
        function [traintag,testtag]=HoldoutValidation(obj,classify,m,lamada)
            traintag=cell(length(lamada),1);   
            testtag=cell(length(lamada),1);
            for i=1:length(lamada)
                switch lamada(i)
                    case 1
                        traintag{i}=ones(size(obj.DataLabel{i}));
                        testtag{i}=zeros(size(obj.DataLabel{i}));
                    case 0
                        testtag{i}=ones(size(obj.DataLabel{i}));
                        traintag{i}=zeros(size(obj.DataLabel{i}));
                    otherwise
                        [traintag{i},testtag{i}] = crossvalind('HoldOut',obj.DataLabel{i},1-lamada(i));
                end
            end
            classify.Run(traintag,testtag,m);
            tmp1=obj.DataLabel{m}(testtag{m}==1);
            tmp2=classify.PredictionLabel;
%             tmp2(tmp1==0)=[];
%             tmp1(tmp1==0)=[];
            
            cp = classperf(cellstr(num2str(tmp1)));
            classperf(cp,cellstr(num2str(tmp2)));
            cp.CorrectRate
%             [~,~,~,auc]=perfcurve(obj.DataLabel{m}(testtag{m}==1),classify.PredictionLabel,cp.ClassLabels{1});
%             auc
        end
        
    end
    
end
