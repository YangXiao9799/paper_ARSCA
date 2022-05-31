function ret = toggle_data_set(set)



ret = 0;


switch lower(set)
    case 'a'
        !rm *B*.txt
        !cp SOMODS_A/*.txt ./        
    case 'b'
        !rm *A*.txt
        !cp SOMODS_B/*.txt ./        
    otherwise
        fprintf('Do not know data set %s.\n', set);
end