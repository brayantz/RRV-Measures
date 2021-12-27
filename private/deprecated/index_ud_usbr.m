function [ud01, ud02, ud10] = index_ud_usbr(d, s)

% d = d(13:end); % nobase line.
% s = s(13:end); % nobase line.

def = d - s;
def(def < 10^-6) = 0;

def01 = sum(reshape(def, 12, []));
def02 = movsum(def01, 2, 'Endpoints', 'discard');
def10 = movsum(def01, 10, 'Endpoints', 'discard');

daMean = mean(sum(reshape(d(13:end), 12, []))); % no base line.
t01 = 0.25*daMean;
t02 = 0.50*daMean;
t10 = 1.00*daMean;

ud01 = sum(def01 > t01);
ud02 = sum(def02 > t02);
ud10 = sum(def10 > t10);
end
