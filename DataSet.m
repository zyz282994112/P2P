classdef DataSet < handle
    %load dataset
    properties  
        DatasetName;
    end
    properties(Hidden) 
        DataLabel;   
        DataFeature;
        DataMatrix;
    end
    
    methods   
        function obj=DataSet(DatasetName)
            if ~exist(DatasetName,'file')
                disp('No such dataset!')
                return
            end            
            obj.DatasetName=DatasetName;
            tmp=load(DatasetName);  
            obj.DataLabel=tmp.DataLabel;    
            obj.DataFeature=tmp.DataFeature;
            obj.DataMatrix=tmp.DataMatrix;
        end
    end
end
