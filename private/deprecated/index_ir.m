function c = index_ir(d, s)

% d = d(13:end); % nobase line.
% s = s(13:end); % nobase line.

def = d - s;
def(def < 10^-6) = 0;

tf = def > 0;

nDef = sum(tf);

ini = find(diff(tf) > 0) + 1;

if tf(1)
    ini = [1, ini];
end

% if tf(end)
%     indf = [fin, nSteps];
% end

if isempty(ini)
    c = 100;    
else
    nSpells = numel(ini);
    c = nSpells/nDef*100;
end

end
