classdef  TestClassifier < ClassifierPackage.Classifier
    properties  %%定义类变量
        
    end
    
   methods   %定义类方法
      function obj = TestClassifier(ClassifyName)
           obj=obj@ClassifierPackage.Classifier(ClassifyName);
      end
      
      function PredictionLabel=Run(obj,dataobj,TrainTag,TestTag)
          %%m表示要对第m类节点类型作为目标节点进行分类
          m=dataobj.TargetDataSet;
          PredictionLabel = ones(sum(TestTag{m}),1); 
      end
            
   end
   
end