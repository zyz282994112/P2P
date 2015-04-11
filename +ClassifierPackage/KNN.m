classdef  KNN < ClassifierPackage.Classifier
    properties  %%定义类变量
        k=1;
    end
    
   methods   %定义类方法
      function obj = KNN(ClassifyName)
           obj=obj@ClassifierPackage.Classifier(ClassifyName);
      end
      
      function PredictionLabel=Run(obj,dataobj,TrainTag,TestTag)
          %%m表示要对第m类节点类型作为目标节点进行分类
          m=dataobj.TargetDataSet;
          similar=zeros(length(dataobj.DataLabel{m}));
          for i=1:length(similar)
              for j=1:length(similar)
                  similar(i,j)=sum(dataobj.DataMatrix{1,2}(i,:)&dataobj.DataMatrix{1,2}(j,:))/sum(dataobj.DataMatrix{1,2}(i,:)|dataobj.DataMatrix{1,2}(j,:));
              end
          end
%           save 'simlar.mat'
          tmp=zeros(length(dataobj.DataLabel{m}),1);
          tmp(TrainTag{m})=dataobj.DataLabel{m}(TrainTag{m});
          for i=1:length(TrainTag{m})
              if tmp(i)==0
                  tmp=digui(tmp,i,similar);
              end
          end
          PredictionLabel=tmp(TestTag{m});
      end
            
   end
   
end

function tmp=digui(tmp,i,sim)
    if tmp(i)==0
        [~,d]=max(sim(i,:));
        if tmp(d)==0
           tmp =digui(tmp,d,sim);
        else
            tmp(i)=tmp(d);
        end
    else
        return;
    end

end

