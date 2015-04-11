classdef DataSet < handle
    %load dataset
    properties
        DatasetName;
        TargetDataSet=1;
        UnlabelTag;
        ComputeLabel;
    end
    properties(Hidden)
        DataLabel;
        DataFeature;
        DataMatrix;
    end
    
    methods
        function obj=DataSet(DatasetName,TargetDataSet)
            if ~exist([DatasetName,'.mat'],'file')
                error('No such dataset!');
            end
            obj.DatasetName=DatasetName;
            data=load(DatasetName);
            tmp=fieldnames(data);
            for i=1:length(tmp)
                obj.(tmp{i})=data.(tmp{i});
            end
            if nargin==2
                obj.TargetDataSet=TargetDataSet;
            end
        end
    end
end
