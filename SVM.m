classdef  SVM < Classifier
    properties  %%���������
    end
    
   methods   %�����෽��
      function obj = SVM(DataLabel,DataFeature,DataMatrix)
           obj=obj@Classifier(DataLabel,DataFeature,DataMatrix);
      end
      
      function Run(obj,TrainTag,TestTag,m)
          %%m��ʾҪ�Ե�m��ڵ�������ΪĿ��ڵ���з���
          trainlabel=obj.DataLabel{m}(TrainTag{m},:);
          testlabel=obj.DataLabel{m}(TestTag{m},:);
          trainfeature=obj.DataFeature{m}(TrainTag{m},:);
          testfeature=obj.DataFeature{m}(TestTag{m},:);
          
          model = svmtrain(trainlabel, trainfeature, '-c 1 -g 0.07');
          obj.PredictionLabel = svmpredict(testlabel,testfeature,model);        
      end
      
   end
   
end