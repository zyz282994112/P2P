function [y,key]=ConvertLabel(label)
    count=length(unique(label));
    key=unique(label);
    y=zeros(size(label,1),count);
    for i=1:length(key)
        if key(i)==0
            continue;
        end
        y(label==key(i),i)=1;
    end
 end