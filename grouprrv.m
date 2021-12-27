function [v, gName] = grouprrv(rrv, varWeight, groupVar)
% Reliability, resilience and vulnerability performance measures by groups.
% rrv, each column is a performance measure and each row a site.
% varWeight, variable to weighting rrv.
% groupVar, categorical or str, must be column.

% Brayan Torres Z. (torres.zagastizabal@gmail.com)


%
nCols = size(rrv, 2);
v = cell(1, nCols);
for i = 1:nCols
    [gInd, gName] = findgroups(groupVar);
    v{i} = splitapply(@waverage, rrv(:, i), varWeight, gInd);
end
v = horzcat(v{:});

end

%% Weighted average.
function b = waverage(a, v)

w = v/sum(v);
b = sum(w.*a);

end







