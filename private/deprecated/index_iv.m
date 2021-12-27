function c = index_iv(d, s)

% d = d(13:end); % nobase line.
% s = s(13:end); % nobase line.

def = d - s;
def(def < 10^-6) = 0;
defr = def./d;

tf = def > 0;
nSteps = numel(tf); 
% nDef = sum(tf);

ini = find(diff(tf) > 0) + 1;
fin = find(diff(tf) < 0);

if tf(1)
    ini = [1, ini];
end

if tf(end)
    fin = [fin, nSteps];
end

if isempty(ini)
    c = 0;
else
    nSpells = numel(ini);
    smax = nan(1, nSpells);
    for i = 1:nSpells
        m = defr(ini(i):fin(i));
        smax(i) = nanmax(m);
    end
    c = nanmean(smax)*100;
end

end
