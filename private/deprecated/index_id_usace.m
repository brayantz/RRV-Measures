function id = index_id_usace(d, s)

% d = d(13:end); % nobase line.
% s = s(13:end); % nobase line.

def = d - s;
def(def < 10^-6) = 0;

defa = sum(reshape(def, 12, []));
da = sum(reshape(d, 12, []));
rda = defa./da;

nYears = numel(defa);
id = nansum(rda.^2)/nYears*100;

end
