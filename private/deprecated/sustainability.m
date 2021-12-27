function v = sustainability(rel, res, vul)
% Sustainability index.

if isempty(rel)
    rel = 1;
    nrel = 0;
else
    nrel = 1;
end

if isempty(res) || ~exist(res, 'var')
    res = 1;
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
v = (rel.*res.*(1 - vul)).^(1/t);

end
