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
          
          PredictionLabel=zeros(sum(TestTag{m}),1);
          for i=1:sum(TestTag{m})
              if rand>0.0476
              PredictionLabel(i) = 1; 
              else
                PredictionLabel(i) = -1;   
              end
          end
%           PredictionLabel = ones(sum(TestTag{m}),1); 
      end
            
   end
   
end