 fid = fopen('score.csv','w');
for i=1:length(ybo_all_bad)
    if ybo_all_bad(i)~=0 || ybo_all_normall(i)~=0
        if fbo_bad(i)>fbo_normall(i) || fbo_bad(i)==Inf
            fprintf(fid,'%.6f,%.6f\n',i,fbo_bad(i));
        else 
            fprintf(fid,'%.6f,%.6f\n',i,-fbo_normall(i));
        end
    end
end     
fclose(fid);