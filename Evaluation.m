classdef Evaluation < handle
   %%评价分类结果
   %%包含AUC,混淆矩阵，准确率，召回率!!!待添加
   %%AUC使用perfcurve函数即可
    properties  %%定义类变量
        truevector;
        precisionvector;
        ConfusionMatrix;
        precision;
        recall;
    end
    properties(Constant)%定义类常量
        
    end
   methods   %定义类方法
       function obj=Evaluation(truevector,precisionvector)
           obj.truevector=truevector;
           obj.precisionvector=precisionvector;
       end    
       
       function ComputeConfusionMatrix(obj)%%待重写
           %%计算混淆矩阵
           [truetmp key]=ConvertLabel(obj.truevector);
           predictiontmp=zeros(size(truetmp));
            for i=1:length(key)
                predictiontmp(obj.precisionvector==key(i),i)=1;
            end
            obj.ConfusionMatrix=zeros(length(key));
            for i=1:length(key)
                for j=1:length(key)
                    obj.ConfusionMatrix(i,j)=sum(truetmp(:,i)==predictiontmp(:,j));
                end
            end
       end
       
       function precision_recall(obj)
           %%计算准确率，召回率
           obj.precision=zeros(size(obj.ConfusionMatrix,1));
           obj.recall=zeros(size(obj.ConfusionMatrix,1));
           for i=1:length(obj.recall)
              obj.precision(i)=obj.ConfusionMatrix(i,i)/sum(obj.ConfusionMatrix(:,i));
              obj.recall(i)=obj.ConfusionMatrix(i,i)/sum(obj.ConfusionMatrix(i,:));
           end
       end
             
   end 
    
end