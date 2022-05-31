function data = loaddata


fileArray = dir('*expensive.txt');
countFile = numel(fileArray);
data = cell(countFile, 1);
for fi = 1:length(fileArray)
    [~,~,~,pd] = regexpi(fileArray(fi).name,'(\d*)(\d*)');
    pd = [str2num(pd{1}) str2num(pd{2})];    
    dataRaw = importdata(fileArray(fi).name,'\t');
    res1 = textscan(dataRaw.rowheaders{1},'%s%f');
    res2 = textscan(dataRaw.rowheaders{2},'%s%f');
    row = (pd(1)-1)*3 + pd(2) / 10;
    data{row} =  [res1{2} dataRaw.data(1,:);res2{2} dataRaw.data(2,:)];   
end
end