function f = cec14_eotp_c(x,no)
fid = fopen('input.dat','w');
fprintf(fid,'%d %d \n', numel(x), no);
fprintf(fid,'%.16f\n', x);
fclose(fid);


!"./CEC14_EOTP_C.exe" <input.dat >output.dat

f = load('output.dat','-ascii');

end

