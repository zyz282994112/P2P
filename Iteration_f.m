function [flo fle fbo]=Iteration_f(Slobo,Slole,ylo,yle,ybo)
    flo=ylo;
    fle=yle;
    fbo=ybo;

    lamada=0.5;
    afa=0.5;
    for t=1:3000
      oldflo=flo;
      oldfle=fle;
      oldfbo=fbo;
%       flo=(lamada*Slobo*fbo+lamada*Slole*fle+afa*ylo)/(2*lamada+afa);
      flo=(lamada*Slobo*fbo+afa*ylo)/(lamada+afa);
      fle=lamada*Slole'*flo+afa*yle;
      fbo=lamada*Slobo'*flo+afa*ybo;
      
      
      %%不改变真实节点的类型
      flo(ylo==1,:)=1;
      flo(ylo==-1,:)=-1;
      fle(yle==1,:)=1;
      fle(yle==-1,:)=-1;
      fbo(ybo==1,:)=1;
      fbo(ybo==-1,:)=-1;
      
      
      
      if all(oldflo==flo) && all(oldfle==fle) && all(oldfbo==fbo)
          disp(t);
          break;
      end
    end
end