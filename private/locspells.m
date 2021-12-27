function [ini, fin] = locspells(p)
% Locate spells.
% p is a vector.

tf = p > 0;
n = size(p, 1);

ini = find(diff(tf) > 0) + 1;
fin = find(diff(tf) < 0);

if tf(1)
    ini = [1; ini];
end

if tf(end)
    fin = [fin; n];
end

end
