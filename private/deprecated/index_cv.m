function c = index_cv(d, s)

% d = d(13:end); % nobase line.
% s = s(13:end); % nobase line.

def = d - s;
def(def < 10^-6) = 0;
c = nansum(d - def)/nansum(d)*100;  

end
