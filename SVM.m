classdef  SVM < Classifier
    properties  %%���������
        s=0;
        t=2;
        c=1;
        g=0.07;
    end
    
   methods   %�����෽��
      function obj = SVM(ClassifyName)
           obj=obj@Classifier(ClassifyName);
      end
      
      function PredictionLabel=Run(obj,dataobj,TrainTag,TestTag,m)
          %%m��ʾҪ�Ե�m��ڵ�������ΪĿ��ڵ���з���
          trainlabel=dataobj.DataLabel{m}(TrainTag{m},:);
          testlabel=dataobj.DataLabel{m}(TestTag{m},:);
          trainfeature=dataobj.DataFeature{m}(TrainTag{m},:);
          testfeature=dataobj.DataFeature{m}(TestTag{m},:);
          model = svmtrain(trainlabel, trainfeature,['-c ',num2str(obj.c),' -s ',num2str(obj.s),' -t ',num2str(obj.t),' -g ',num2str(obj.g)]);
          PredictionLabel = svmpredict(testlabel,testfeature,model);        
      end
            
   end
   
end