%��ʼ������yֵ(�����ĳ������绵����)
ybo_all_bad=Generate_y_all1_0(inputborrower_bad,unique(R_loan_borrower(:,2)));
yle_all_bad=Generate_y_all(inputlender_bad,unique(R_loan_lender(:,2)));
ylo_all_bad=Generate_y_all(inputloan_bad,unique(R_loan_borrower(:,1)));


%��������г���
ybo=Network_Sample(ybo_all_bad,minsample);
yle=Network_Sample(yle_all_bad,minsample);
ylo=Network_Sample(ylo_all_bad,minsample);


disp('��ʼ�������ˣ�');
[flo_bad fle_bad fbo_bad]=Iteration_f(Slobo,Slole,ylo,yle,ybo);

