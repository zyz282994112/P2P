%初始化所有y值(仅针对某个类别，如坏账类)
ybo_all_bad=Generate_y_all1_0(inputborrower_bad,unique(R_loan_borrower(:,2)));
yle_all_bad=Generate_y_all(inputlender_bad,unique(R_loan_lender(:,2)));
ylo_all_bad=Generate_y_all(inputloan_bad,unique(R_loan_borrower(:,1)));


%对网络进行抽样
ybo=Network_Sample(ybo_all_bad,minsample);
yle=Network_Sample(yle_all_bad,minsample);
ylo=Network_Sample(ylo_all_bad,minsample);


disp('开始迭代坏账！');
[flo_bad fle_bad fbo_bad]=Iteration_f(Slobo,Slole,ylo,yle,ybo);

