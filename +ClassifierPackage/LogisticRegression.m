classdef  LogisticRegression < ClassifierPackage.Classifier
    %%only 2-classifier
    properties  %%定义类变量
    end
    
   methods   %定义类方法
      function obj = LogisticRegression(ClassifyName)
           obj=obj@ClassifierPackage.Classifier(ClassifyName);
      end
     
      function [PredictionLabel,score]=Run(~,dataobj,TrainTag,TestTag)
          %%m表示要对第m类节点类型作为目标节点进行分类
          m=dataobj.TargetDataSet;
          trainlabel=dataobj.DataLabel{m}(TrainTag{m},:);
          trainfeature=dataobj.DataFeature{m}(TrainTag{m},:);
          testfeature=dataobj.DataFeature{m}(TestTag{m},:);
          tag=unique(trainlabel);
          tmp=trainlabel;
          trainlabel(tmp==tag(1))=1;
          trainlabel(tmp==tag(2))=0;
          model = GeneralizedLinearModel.fit(trainfeature,trainlabel,'Distribution','binomial');
          score = model.predict(testfeature);
          PredictionLabel=zeros(length(score),1);
          PredictionLabel(score>=0.5)=tag(1);
          PredictionLabel(score<0.5)=tag(2);
      end
            
   end
   
end