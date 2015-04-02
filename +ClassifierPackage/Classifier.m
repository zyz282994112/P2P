classdef Classifier < handle
   %%base Classifier
    properties  
        ClassifyName;
    end
    
   methods   
      function obj = Classifier(ClassifyName)
          obj.ClassifyName=ClassifyName;
      end
   end
   
   methods(Abstract)
      PredictionLabel=Run(obj,dataobj,TrainTag,TestTag,m); 
   end
   
end