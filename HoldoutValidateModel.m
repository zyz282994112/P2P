classdef HoldoutValidateModel < ValidateModel
    properties  
        lamada=0.5;
    end
    methods  
        function obj=HoldoutValidateModel(ValidateName)
            obj=obj@ValidateModel(ValidateName);
        end
        
        function evalarray=Run(obj,dataobj,classify,evalarray,m)
            traintag=cell(length(dataobj.DataLabel),1);
            testtag=cell(length(dataobj.DataLabel),1);
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
            PredictionLabel=classify.Run(dataobj,traintag,testtag,m);
            [truedata,predictiondata]=obj.ClearuUnlabeldData(dataobj.DataLabel{m}(testtag{m}==1),PredictionLabel);
            for i=1:length(evalarray)
                evalarray{i}=evalarray{i}.Run(truedata,predictiondata);
            end
        end
        
    end
    
end
