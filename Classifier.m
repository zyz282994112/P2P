classdef Classifier < handle
   %%基分类器。定义分类器基本参数和方法
    properties  %%定义类变量
        DataLabel;  %%cell数组，其中Data(1)表示目标节点的label数组
        DataFeature;%%cell数组，其中Data(1)表示目标节点的feature数组
        DataMatrix;%%cell数组，其中Data(1,1)表示目标节点的matrix数组
        PredictionLabel;
    end
    
   methods   %定义类方法
      function obj = Classifier(DataLabel,DataFeature,DataMatrix)
           obj.DataLabel=DataLabel;
           obj.DataFeature=DataFeature;
           obj.DataMatrix=DataMatrix;  %%是一个cell矩阵，其中DataMatrix{1,1}表示target数据自身的矩阵{1，x}表示target与其它节点的连接矩阵
      end
      
      function Run(obj,TrainTag,TestTag,m)
          
      end
      
   end
   
end