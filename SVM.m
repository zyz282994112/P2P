classdef  SVM < Classifier
    properties  %%定义类变量
    end
    
   methods   %定义类方法
      function obj = SVM(DataLabel,DataFeature,DataMatrix)
           obj=obj@Classifier(DataLabel,DataFeature,DataMatrix);
      end
      
      function Run(obj,TrainTag,TestTag,m)
          %%m表示要对第m类节点类型作为目标节点进行分类
          trainlabel=obj.DataLabel{m}(TrainTag{m},:);
          testlabel=obj.DataLabel{m}(TestTag{m},:);
          trainfeature=obj.DataFeature{m}(TrainTag{m},:);
          testfeature=obj.DataFeature{m}(TestTag{m},:);
          
          model = svmtrain(trainlabel, trainfeature, '-c 1 -g 0.07');
          obj.PredictionLabel = svmpredict(testlabel,testfeature,model);        
      end
      
   end
   
end