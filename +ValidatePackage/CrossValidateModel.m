classdef CrossValidateModel < ValidatePackage.ValidateModel
    properties
        k=10;
    end
    methods
        function obj=CrossValidateModel(ValidateName)
            obj=obj@ValidatePackage.ValidateModel(ValidateName);
        end
        
        function evalarray=Run(obj,dataobj,classify,evalarray,m)
            indices=cell(length(dataobj.DataLabel),1);
            length(indices)
            for i=1:length(indices)
                indices{i} = crossvalind('Kfold',dataobj.DataLabel{i},obj.k);
            end
            result=cell(length(evalarray),obj.k);
            testtag=cell(length(indices),1);
            traintag=cell(length(indices),1);
            for i = 1:obj.k
                for j=1:length(indices)
                    testtag{j} = (indices{j} == i); traintag{j} = ~testtag{j};
                end
                PredictionLabel=classify.Run(dataobj,traintag,testtag,m);
                [truedata,predictiondata]=obj.ClearuUnlabeldData(dataobj.DataLabel{m}(testtag{m}==1),PredictionLabel);
                for j=1:length(evalarray)
                    result{j,i}=evalarray{j}.Run(truedata,predictiondata);
                end
            end
            for j=1:length(evalarray)
                for i = 1:obj.k
                    objclass=metaclass(result{j,i});
                    objclass=objclass.PropertyList;
                    for t=1:length(objclass)
                        if objclass(t).Hidden==0 && isnumeric(result{j,i}.(objclass(t).Name))
                            if i==1
                                evalarray{j}.(objclass(t).Name)=0;
                            end
                            evalarray{j}.(objclass(t).Name)=evalarray{j}.(objclass(t).Name)+result{j,i}.(objclass(t).Name);
                        end
                    end
                end
                objclass=metaclass(evalarray{j});
                objclass=objclass.PropertyList;
                for t=1:length(objclass)
                    if objclass(t).Hidden==0 && isnumeric(result{j,i}.(objclass(t).Name))
                        evalarray{j}.(objclass(t).Name)=evalarray{j}.(objclass(t).Name)/obj.k;
                    end
                end
            end
            
        end
        
        
    end
    
end
