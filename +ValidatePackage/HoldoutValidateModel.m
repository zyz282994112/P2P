classdef HoldoutValidateModel < ValidatePackage.ValidateModel
    properties  
        lamada;
    end
    methods  
        function obj=HoldoutValidateModel(ValidateName)
            obj=obj@ValidatePackage.ValidateModel(ValidateName);
        end
        
        function evalarray=Run(obj,dataobj,classify,evalarray)
            m=dataobj.TargetDataSet;
            traintag=cell(length(dataobj.DataLabel),1);
            testtag=cell(length(dataobj.DataLabel),1);
            if isempty(obj.lamada)
                obj.lamada=0.5*ones(length(dataobj.DataLabel),1);
            end
            for i=1:length(dataobj.DataLabel)
                switch obj.lamada(i)
                    case 1
                        traintag{i}=ones(size(dataobj.DataLabel{i}));
                        testtag{i}=zeros(size(dataobj.DataLabel{i}));
                    case 0
                        testtag{i}=ones(size(dataobj.DataLabel{i}));
                        traintag{i}=zeros(size(dataobj.DataLabel{i}));
                    otherwise
                        [traintag{i},testtag{i}] = crossvalind('HoldOut',dataobj.DataLabel{i},1-obj.lamada(i));
                end
            end
            PredictionLabel=classify.Run(dataobj,traintag,testtag);
%             [truedata,predictiondata]=obj.ClearUnlabeldData(dataobj.DataLabel{m}(testtag{m}==1),PredictionLabel);
            
            for i=1:length(evalarray)
%                 evalarray{i}.Run(truedata,predictiondata);
                evalarray{i}.Run(dataobj.DataLabel{m}(testtag{m}==1&dataobj.DataLabel{m}~=dataobj.UnlabelTag),PredictionLabel(dataobj.DataLabel{m}(testtag{m}==1)~=dataobj.UnlabelTag));
            end
        end
        
    end
    
end
