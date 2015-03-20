function f=Iteration_f_pushi(S,y,lamada,afa)
    f=y; 
    for t=1:3000
      oldf=f;
      for i=1:length(f)
          for k=1:size(f{i},2)
              if isempty(S{i,i})
                tmp=afa(i)*y{i}(:,k);
              else
                tmp=afa(i)*y{i}(:,k)+lamada(i,i)*S{i,i}*f{i}(:,k);
              end
              for j=1:length(f)
                  if isempty(S{i,j}) 
                      lamada(i,j)=0;
                      continue; 
                  end
                  tmp=tmp+lamada(i,j)*S{i,j}*f{j}(:,k);
              end
              f{i}(:,k)=tmp/(sum(lamada(i,:))+lamada(i,i)+afa(i));
              %%不改变真实节点的类型
              for j=1:size(f{i},2)
                  if j~=k
                    f{i}(y{i}(:,k)==1,j)=0;
                  else
                    f{i}(y{i}(:,k)==1,k)=1;
                  end
              end
          end
      end
      for i=1:length(f)
          if all(all(oldf{i}==f{i}))
              if i==length(f)
                  disp('循环终止');
                  disp(t);
                  return;
              else
                  continue;
              end
          else
              break;
          end;
      end;
    end;
    
end