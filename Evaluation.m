classdef Evaluation < handle
   %%���۷�����
   %%����AUC,��������׼ȷ�ʣ��ٻ���!!!�����
   %%AUCʹ��perfcurve��������
    properties  %%���������
        truevector;
        precisionvector;
        ConfusionMatrix;
        precision;
        recall;
    end
    properties(Constant)%�����ೣ��
        
    end
   methods   %�����෽��
       function obj=Evaluation(truevector,precisionvector)
           obj.truevector=truevector;
           obj.precisionvector=precisionvector;
       end    
       
       function ComputeConfusionMatrix(obj)%%����д
           %%�����������
           [truetmp key]=ConvertLabel(obj.truevector);
           predictiontmp=zeros(size(truetmp));
            for i=1:length(key)
                predictiontmp(obj.precisionvector==key(i),i)=1;
            end
            obj.ConfusionMatrix=zeros(length(key));
            for i=1:length(key)
                for j=1:length(key)
                    obj.ConfusionMatrix(i,j)=sum(truetmp(:,i)==predictiontmp(:,j));
                end
            end
       end
       
       function precision_recall(obj)
           %%����׼ȷ�ʣ��ٻ���
           obj.precision=zeros(size(obj.ConfusionMatrix,1));
           obj.recall=zeros(size(obj.ConfusionMatrix,1));
           for i=1:length(obj.recall)
              obj.precision(i)=obj.ConfusionMatrix(i,i)/sum(obj.ConfusionMatrix(:,i));
              obj.recall(i)=obj.ConfusionMatrix(i,i)/sum(obj.ConfusionMatrix(i,:));
           end
       end
             
   end 
    
end