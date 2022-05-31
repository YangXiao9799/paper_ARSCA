function data = loaddata


fileArray = dir('*.txt');
countFile = numel(fileArray);
data = cell(countFile, 1);

for fi = 1:length(fileArray)
    [~,~,~,pd] = regexpi(fileArray(fi).name,'(\d*)(\d*)');
    pd = [str2num(pd{1}) str2num(pd{2})];    
    dataRaw = textread(fileArray(fi).name);
    row = (pd(1)-1)*3 + pd(2) / 10;
    data{row} = [dataRaw(1,:);
    	dataRaw(2,:)];   
end
end