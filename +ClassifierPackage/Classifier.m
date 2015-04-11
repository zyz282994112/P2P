classdef Classifier < handle
   %%base Classifier
    properties  
        ClassifyName;
    end
    
   methods   
      function obj = Classifier(ClassifyName)
%           obj=eval([ClassifyName,'(''',ClassifyName,''')']);
          obj.ClassifyName=ClassifyName;
      end
   end
   
   methods(Abstract)
      [PredictionLabel,score]=Run(obj,dataobj,TrainTag,TestTag); 
   end
   
end