%��������������г���
%%Ϊ��Ҫ��borrower��lender��������������ʲô����֪ʶ����ģ�����������ΪҪ��ÿ�����͵Ľڵ㶼���࣬�������ݼ���ֻ�ں�loan���Ͱ���
%%������Ϊ��ȫ����������׷���ĳ�ʻ�����loan�ĳ�����û���֣�����borrower�ĳ����г��֣��Ӷ��㷨�ݴ˺������ж���loan���ˡ���������������������еĿ����ԡ�
%%֪ʶ����ģ���г���������Ϊ���ж������ͣ���ͬ���ͼ�ڵ����ӽ϶࣬��������ʵ��ֻ���������磬�о�Ч������ܺá�
ybo=Network_Sample(ybo_all_bad,minsample);
yle=Network_Sample(yle_all_bad,minsample);           
ylo=Network_Sample(ylo_all_bad,minsample);


%���������������г���
ybo_n=Network_Sample(ybo_all_normall,minsample);
yle_n=Network_Sample(yle_all_normall,minsample);
ylo_n=Network_Sample(ylo_all_normall,minsample);

ybo=ybo-ybo_n;
yle=yle-yle_n;
ylo=ylo-ylo_n;

disp('��ʼ�������ˣ�');
[flo_bad fle_bad fbo_bad]=Iteration_f(Slobo,Slole,ylo,yle,ybo);


disp('��ʼ���������������');
[flo_normall fle_normall fbo_normall]=Iteration_f(Slobo,Slole,-ylo,-yle,-ybo);



