function v = resilience(dem, sup, varargin)
% Index of resilience
%
% Syntax
%   v = resilience(dem, sup)
%   v = resilience(__, method, tol)
%
% Input arguments
%   dem    - Matrix of demands (each column is a site).
%   sup    - Matrix of supplies.
%   method - Method of resilience (regarding durations of spells).
%            Options: 'mean' (default), 'max', 'q90'
%   tol    - Tolerance, 10^-6 by default.
%
% Output arguments
%   v      - vector of resilience.

% Brayan Torres Z. (torres.zagastizabal@gmail.com)


% Check arguments.
if nargin < 3 || isempty(varargin{1})
    method = 'mean';
else
    method = varargin{1};
end

if nargin < 4 || isempty(varargin{2})
    tol = 10^-6;
else
    tol = varargin{2};
end

% Resilience.
switch method
    case 'mean'
        funcMethod = @mean;
    case 'max'
        funcMethod = @max;
    case 'q90'
        funcMethod = @quantile90;
    otherwise
        error('Invalid method.')
end

def = dem - sup;
def(def < tol) = 0;

nCols = size(def, 2);
v = nan(1, nCols);
for i = 1:nCols
    [ini, fin] = locspells(def(:,i));
    if ~isempty(ini)
        dur = fin - ini + 1;
        v(i) = (funcMethod(dur))^-1;
    else
        v(i) = 1;
    end
end

end

function v = quantile90(d)

v = quantile(d, 0.9);

end
