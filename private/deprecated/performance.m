function performance(demandFile, supplyFile, indicadorFile, outFile)

[~, ~, dem] = xlsread(demandFile); % dem and sup must be the same size.
[~, ~, sup] = xlsread(supplyFile);
[~, ~, ind] = xlsread(indicadorFile);
tf = cell2mat(ind(5:end, 2));

[sites, dataDem] = readData(dem);
[~, dataSup] = readData(sup);

n = numel(sites);
CV = nan(n, 1);
GM = nan(n, 1);
GA = nan(n, 1);
IR = nan(n, 1);
IV = nan(n, 1);
ID = nan(n, 1);
UD01 = nan(n, 1);
UD02 = nan(n, 1);
UD10 = nan(n, 1);

for i = 1:n
    CV(i) = index_cv(dataDem(i,:), dataSup(i,:));
    GM(i) = index_gm(dataDem(i,:), dataSup(i,:), tf(i));
    GA(i) = index_ga(dataDem(i,:), dataSup(i,:), tf(i));
    IR(i) = index_ir(dataDem(i,:), dataSup(i,:));
    IV(i) = index_iv(dataDem(i,:), dataSup(i,:));
    ID(i) = index_id_usace(dataDem(i,:), dataSup(i,:));
    [UD01(i), UD02(i), UD10(i)] = index_ud_usbr(dataDem(i,:), dataSup(i,:));
end

T = table(sites, CV, GM, GA, IR, IV, ID, UD01, UD02, UD10);
writetable(T, outFile)
end


function [sites, data] = readData(c)

nCols = size(c, 2);
if rem(nCols, 2) == 0
    c(:,end) = [];
end

c(1:4,:) = []; 
sites = c(:,1);
data = c(:,2:end);
data = cell2mat(data);

end
