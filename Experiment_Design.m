classdef Experiment_Design < handle
    %实验设置
    properties  %%定义类变量
        DataLabel;  %%cell数组，其中Data(1)表示目标节点的label数组
        DataFeature;%%cell数组，其中Data(1)表示目标节点的feature数组
        DataMatrix;%%cell数组，其中Data(1,1)表示目标节点的matrix数组
    end
    properties(Constant)%定义类常量
        
    end
   methods   %定义类方法
       function obj=Experiment_Design(DataLabel,DataFeature,DataMatrix)
           obj.DataLabel=DataLabel;
           obj.DataFeature=DataFeature;
           obj.DataMatrix=DataMatrix;  %%是一个cell矩阵，其中DataMatrix{1,1}表示target数据自身的矩阵{1，x}表示target与其它节点的连接矩阵
       end
       
%        function [truelabel,predictionlabel]=crossValidateModel(obj,classify,k) 
       function [inputLabel]=crossValidateModel(obj,k) 
           tmp=cell(size(obj.DataLabel));
           count=cell(size(obj.DataLabel));
           output=cell(size(obj.DataLabel));
%            PredictionLabel=cell(size(obj.DataLabel));
           inputLabel=cell(size(obj.DataLabel));
           for i=0:k-1
               for j=1:length(obj.DataLabel)
                   tmp{j}=randperm(length(obj.DataLabel{j}));
                   count{j}=fix(length(obj.DataLabel{j})/k);
                   output{j}=zeros(size(obj.DataLabel{j}));
                   inputLabel{j}=obj.DataLabel{j};
                   if i~=k-1
                       inputLabel{j}(tmp{j}((count{j}*i+1):(count{j}*(i+1))))=0;
                   else
                       inputLabel{j}(tmp{j}((count{j}*i+1):end))=0;
                   end
               end
%                for j=1:length(obj.DataLabel)
%                    classify.Run(inputLabel,j);%%分类器输入之前需要初始化，包括传入数据，此步骤只进行分类。
%                    PredictionLabel{j}=classify.PredictionLabel;
%                    PredictionLabel{j}(inputLabel{j}~=0,:)=0;%%只考虑预测项，不考虑已知项
%                    output{j}=output{j}+PredictionLabel{j};%%将所有预测结果合并，为之后检测用。
%                end
           end
%            truelabel=obj.DataLabel{1};
%            predictionlabel=output{1};
       end
       
       function [TrueLabel,PredictionLabel]=SampleValidateModel(obj,classify,lamada) 
           tmp=randperm(length(obj.DataLabel{1}));
           count=fix(length(obj.DataLabel{1})*lamada);
           inputLabel=zeros(size(obj.DataLabel{1}));
           inputLabel(tmp(1:count))=input(tmp(1:count));
           classify.Run(inputLabel);%%分类器输入之前需要初始化，包括传入数据，此步骤只进行分类。
           PredictionLabel=classify.PredictionLabel;
           PredictionLabel(inputLabel~=0,:)=[];%%将预测类别中，本来就输入的已知数据剔除掉，从而只对比剩下的数据
           TrueLabel=obj.DataLabel{1};
           TrueLabel(inputLabel~=0,:)=[];%%将真实类别中，本来就输入的已知数据剔除掉，从而只对比剩下的数据
       end
              
   end
    
end
