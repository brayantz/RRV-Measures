function v = reliability(dem, sup, varargin)
% Index of reliability
%
% Syntax
%   v = reliability(dem, sup)
%   v = reliability(__, regard, tol)
%
% Input arguments
%   dem    - Matrix of demands (each column is a site).
%   sup    - Matrix vector of supplies.
%   regard - Reliability regarding time or volume.
%            Options: 'time' (default), 'volume'
%   tol    - Tolerance, 10^-6 by default.
% Output arguments
%   v      - vector of reliability.

% Brayan Torres Z. (torres.zagastizabal@gmail.com)


% Check arguments.
if nargin < 3 || isempty(varargin{1})
    regard = 'time';
else
    regard = varargin{1};
end

if nargin < 4 || isempty(varargin{2})
    tol = 10^-6;
else
    tol = varargin{2};
end


% Reliability.
def = dem - sup;
def(def < tol) = 0;

switch regard
    case 'time'
        nTimes = size(def, 1);
        nFails = sum(def > 0);
        v = (nTimes - nFails)./nTimes;
    case 'volume'
        v = sum(dem - def)./sum(dem);
    otherwise
        error('Invalid option.')
        
end






