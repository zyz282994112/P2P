function f=IterationSolution(~,S,y,lamada,afa)
%%���ļ���f�ĵ�����ʵ��
f=y;
for t=1:3000
    oldf=f;
    for i=1:length(f)
        for k=1:size(y{i},2)
            tmp=afa(i)*y{i}(:,k)+lamada(i,i)*S{i,i}*f{i}(:,k);
            for j=1:length(f)
                tmp=tmp+lamada(i,j)*S{i,j}*f{j}(:,k);
            end
            f{i}(:,k)=tmp/(sum(lamada(i,:))+lamada(i,i)+afa(i));
        end
    end
    if isequal(oldf,f)
        disp('ѭ����ֹʱ����������');
        disp(t);
        break;
    end
end

end