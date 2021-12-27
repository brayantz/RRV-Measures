function g = index_gm(d, s, tf)

% d = d(13:end); % nobase line.
% s = s(13:end); % nobase line.

def = d - s;
def(def < 10^-6) = 0;

if tf
    nDef = sum(def > 0*d);
else
    nDef = sum(def > 0);
end

nSteps = numel(d);
g = (nSteps - nDef)/nSteps*100;

end
