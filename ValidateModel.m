classdef ValidateModel < handle
    %set experiment.
    properties
        ValidateName;
        WriteMode='w';
        UnlabelDataTag=NaN;
    end
    methods
        function obj=ValidateModel(ValidateName)
            obj.ValidateName=ValidateName;
        end
        
        function [truedata,predictiondata]=ClearuUnlabeldData(obj,truedata,predictiondata)
            if ~isnan(obj.UnlabelDataTag) && isnumeric(obj.UnlabelDataTag)
                predictiondata(truedata==obj.UnlabelDataTag)=[];
                truedata(truedata==obj.UnlabelDataTag)=[];
            end
        end
        
        function SaveResult(obj,objarray,resultpath)
            switch nargin
                case 2
                    c=fopen('result.xml',obj.WriteMode);
                case 3
                    fid=[resultpath,'.xml'];
                    c=fopen(fid,obj.WriteMode);
                otherwise
                    disp('input error!');
                    return;
            end
            
            fprintf(c,'<OneTest>\n');
            digui(c,objarray);
            fprintf(c,'</OneTest>\n');
            fclose(c);
        end
    end
    
    methods(Abstract)
        evalarray=Run(obj,dataobj,classify,evalarray,m);
    end
    
end

function writexml(c,obj)
objclass=metaclass(obj);
Name=objclass.Name;
objclass=objclass.PropertyList;
fprintf(c,'<%s>\n',Name);
for i=1:length(objclass)
    if objclass(i).Hidden==0
        disp([objclass(i).Name,' : ',num2str(obj.(objclass(i).Name))]);
        fprintf(c,'<%s>%s</%s>\n',objclass(i).Name,num2str(obj.(objclass(i).Name)),objclass(i).Name);
    end
end
fprintf(c,'</%s>\n',Name);
end

function digui(c,objarray)
if iscell(objarray)
    for i=1:length(objarray)
        digui(c,objarray{i})
    end
else
    writexml(c,objarray);
end
end


