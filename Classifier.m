classdef Classifier < handle
   %%����������������������������ͷ���
    properties  %%���������
        DataLabel;  %%cell���飬����Data(1)��ʾĿ��ڵ��label����
        DataFeature;%%cell���飬����Data(1)��ʾĿ��ڵ��feature����
        DataMatrix;%%cell���飬����Data(1,1)��ʾĿ��ڵ��matrix����
        PredictionLabel;
    end
    
   methods   %�����෽��
      function obj = Classifier(DataLabel,DataFeature,DataMatrix)
           obj.DataLabel=DataLabel;
           obj.DataFeature=DataFeature;
           obj.DataMatrix=DataMatrix;  %%��һ��cell��������DataMatrix{1,1}��ʾtarget��������ľ���{1��x}��ʾtarget�������ڵ�����Ӿ���
      end
      
      function Run(obj,TrainTag,TestTag,m)
          
      end
      
   end
   
end