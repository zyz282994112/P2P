classdef Experiment_Design < handle
    %ʵ������
    properties  %%���������
        DataLabel;  %%cell���飬����Data(1)��ʾĿ��ڵ��label����
        DataFeature;%%cell���飬����Data(1)��ʾĿ��ڵ��feature����
        DataMatrix;%%cell���飬����Data(1,1)��ʾĿ��ڵ��matrix����
    end
    properties(Constant)%�����ೣ��
        
    end
   methods   %�����෽��
       function obj=Experiment_Design(DataLabel,DataFeature,DataMatrix)
           obj.DataLabel=DataLabel;
           obj.DataFeature=DataFeature;
           obj.DataMatrix=DataMatrix;  %%��һ��cell��������DataMatrix{1,1}��ʾtarget��������ľ���{1��x}��ʾtarget�������ڵ�����Ӿ���
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
%                    classify.Run(inputLabel,j);%%����������֮ǰ��Ҫ��ʼ���������������ݣ��˲���ֻ���з��ࡣ
%                    PredictionLabel{j}=classify.PredictionLabel;
%                    PredictionLabel{j}(inputLabel{j}~=0,:)=0;%%ֻ����Ԥ�����������֪��
%                    output{j}=output{j}+PredictionLabel{j};%%������Ԥ�����ϲ���Ϊ֮�����á�
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
           classify.Run(inputLabel);%%����������֮ǰ��Ҫ��ʼ���������������ݣ��˲���ֻ���з��ࡣ
           PredictionLabel=classify.PredictionLabel;
           PredictionLabel(inputLabel~=0,:)=[];%%��Ԥ������У��������������֪�����޳������Ӷ�ֻ�Ա�ʣ�µ�����
           TrueLabel=obj.DataLabel{1};
           TrueLabel(inputLabel~=0,:)=[];%%����ʵ����У��������������֪�����޳������Ӷ�ֻ�Ա�ʣ�µ�����
       end
              
   end
    
end
