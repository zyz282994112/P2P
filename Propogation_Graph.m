classdef Propogation_Graph < Classifier
   %%Ming Ji 论文方法实现
    properties  %%定义类变量
        lamada;
        afa;
    end
    
    properties(Constant)%定义类常量        
    end
        
    methods   %定义类方法   
        
        function obj = Propogation_Graph(DataLabel,DataFeature,DataMatrix)
           obj=obj@Classifier(DataLabel,DataFeature,DataMatrix);
        end
        
        function Run(obj,inputLabel,id)
            y=cell(length(inputLabel),1);
            key=cell(length(inputLabel),1);
            for i=1:length(inputLabel)
               [y{i},key{i}]=ConvertLabel(inputLabel{i});%%将数组由y{i}-->y{i,k} 
            end
            S=cell(size(obj.DataMatrix));
            %%计算Sij
            for i=1:size(obj.DataMatrix,1)
                for j=1:size(obj.DataMatrix,2)
                    if isempty(obj.DataMatrix(i,j))
                        continue;
                    else
                        S{i,j}=ComputeSij(obj.DataMatrix{i,j});
                    end
                end
            end 
            f=Iteration_f_pushi(S,y,obj.lamada,obj.afa);%%待改进
            obj.RecoverLabel(f{id},key{id});%%返回预测结果,待改进
        end
      
        function RecoverLabel(obj,f,key)
            obj.PredictionLabel=zeros(size(f(:,1)));
            for i=1:length(key)
                obj.PredictionLabel(f(:,i)==1,:)=key(i);
            end
        end
        
    end
    
end
        
 