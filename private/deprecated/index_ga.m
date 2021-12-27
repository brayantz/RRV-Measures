function g = index_ga(d, s, tf)
% 
% d = d(13:end); % nobase line.
% s = s(13:end); % nobase line.

def = d - s;
def(def < 10^-6) = 0;

defa = sum(reshape(def, 12, []));

if tf
    da = sum(reshape(d, 12, []));
    nDefa = sum(defa > 0.05*da);
else
    nDefa = sum(defa > 0);
end

nYears = numel(defa);
g = (nYears - nDefa)/nYears*100;


end
