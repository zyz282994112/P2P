classdef  TestClassifier < ClassifierPackage.Classifier
    properties  %%���������
        
    end
    
   methods   %�����෽��
      function obj = TestClassifier(ClassifyName)
           obj=obj@ClassifierPackage.Classifier(ClassifyName);
      end
      
      function PredictionLabel=Run(obj,dataobj,TrainTag,TestTag)
          %%m��ʾҪ�Ե�m��ڵ�������ΪĿ��ڵ���з���
          m=dataobj.TargetDataSet;
          PredictionLabel = ones(sum(TestTag{m}),1); 
      end
            
   end
   
end