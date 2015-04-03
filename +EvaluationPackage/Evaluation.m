classdef Evaluation < handle&matlab.mixin.Copyable
    %%评价分类结果
    properties  %%定义类变量
        EvaluationName;
    end
    
    methods   %定义类方法
        function obj=Evaluation(EvaluationName)
            obj.EvaluationName=EvaluationName;
        end      
    end
    
    methods(Abstract)
       obj=Run(obj,truevector,precisionvector); 
    end
    
end