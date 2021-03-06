classdef  SVM < ClassifierPackage.Classifier
    properties  %%定义类变量
        s=0;
        t=2;
        c=1;
        g=0;
    end
    
   methods   %定义类方法
      function obj = SVM(ClassifyName)
           obj=obj@ClassifierPackage.Classifier(ClassifyName);
      end
      
      function [PredictionLabel,score]=Run(obj,dataobj,TrainTag,TestTag)
          %%m表示要对第m类节点类型作为目标节点进行分类
          m=dataobj.TargetDataSet;
          trainlabel=dataobj.DataLabel{m}(TrainTag{m},:);
          testlabel=dataobj.DataLabel{m}(TestTag{m},:);
          trainfeature=dataobj.DataFeature{m}(TrainTag{m},:);
          testfeature=dataobj.DataFeature{m}(TestTag{m},:);
          
          model = svmtrain(trainlabel, trainfeature,['-c ',num2str(obj.c),' -s ',num2str(obj.s),' -t ',num2str(obj.t),' -g ',num2str(obj.g)]);
          [PredictionLabel,~,score] = svmpredict(testlabel,testfeature,model);
      end
            
   end
   
end