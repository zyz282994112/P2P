function f=ClosedSolution(S,y,lamada,afa)
%%论文计算f的闭式解实现
num=length(afa);
I=cell(num,1);
A=[];B=[];
for i=1:num
    tmp=[];
    I{i}=sparse(diag(ones(length(S{i,i}),1)));
    for j=1:num
        if i==j
            tmp=[tmp,-((sum(lamada(i,:))-lamada(i,i)+afa(i))*I{i}+2*lamada(i,i)*(I{i}-S{i,i}))];
            B=[B;-afa(i)*y{i}];
        else
            tmp=[tmp,lamada(i,j)*S{i,j}];
        end
    end
    A=[A;tmp];
end

ff=A\B;
f=cell(size(y));
count=0;
for i=1:num
    f{i}=ff((count+1):(count+length(y{i})),:);
    count=count+length(y{i});
end

end