function v = droughtrisk(rel, res, vul)
% Drought reisk index.
% TODO: add weights option.

if isempty(rel)
    rel = 0;
    nrel = 0;
else
    nrel = 1;
end

if isempty(res) || ~exist(res, 'var')
    res = 0;
    nres = 0;
else
    nres = 1;
end

if isempty(vul) || ~exist(vul, 'var')
    vul = 0;
    nvul = 0;
else
    nvul = 1;
end

t = nrel + nres + nvul;
wrel = nrel/t;
wres = nres/t;
wvul = nvul/t;
v = wrel*(1 - rel) + wres*(1 - res) + wvul*vul;

end
