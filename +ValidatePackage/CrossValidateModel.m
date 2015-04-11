classdef CrossValidateModel < ValidatePackage.ValidateModel
    properties
        k=10;
    end
    methods
        function obj=CrossValidateModel(ValidateName)
            obj=obj@ValidatePackage.ValidateModel(ValidateName);
        end
        
        function evalarray=Run(obj,dataobj,classify,evalarray)
            m=dataobj.TargetDataSet;
            indices=cell(length(dataobj.DataLabel),1);
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
                [PredictionLabel,score]=classify.Run(dataobj,traintag,testtag);
                for j=1:length(evalarray)
                    evalarray{j}.Run(dataobj,dataobj.DataLabel{m}(testtag{m}==1&dataobj.DataLabel{m}~=dataobj.UnlabelTag),PredictionLabel(dataobj.DataLabel{m}(testtag{m}==1)~=dataobj.UnlabelTag),score(dataobj.DataLabel{m}(testtag{m}==1)~=dataobj.UnlabelTag));
                    result{j,i}=copy(evalarray{j});
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
