function T = perfmeas(Dem, Sup, varargin)
% Reliability, resilience and vulnerability performance measures.


% Parse and check input arguments.
persistent P
if isempty(P)
    P = inputParser;
    addRequired(P, 'Dem',(@(x) validateattributes(x, {'table'}, {'nonempty'})))
    addRequired(P, 'Sup',(@(x) validateattributes(x, {'table'}, {'nonempty'})))
    
    addParameter(P, 'isRel', true, (@(x) validateattributes(x, {'logical'}, {'scalar'})));
    addParameter(P, 'isRes', true, (@(x) validateattributes(x, {'logical'}, {'scalar'})));
    addParameter(P, 'isVul', true, (@(x) validateattributes(x, {'logical'}, {'scalar'})));
    addParameter(P, 'isDri', true, (@(x) validateattributes(x, {'logical'}, {'scalar'})));
    addParameter(P, 'isSi', true, (@(x) validateattributes(x, {'logical'}, {'scalar'})));
    
    addParameter(P, 'relMethod', 'time', (@(x) validateattributes(x, {'char'}, {'vector'})));
    addParameter(P, 'resMethod', 'meanDur', (@(x) validateattributes(x, {'char'}, {'vector'})));
    addParameter(P, 'vulMethod', 'maxDef', (@(x) validateattributes(x, {'char'}, {'vector'})));
    
    addParameter(P, 'tol', 10^-6, (@(x) validateattributes(x, {'numeric'}, {'scalar'})));
end
parse(P, Dem, Sup, varargin{:});


%
Par = P.Results;
if Par.isRel
    rel = reliability(Dem{:,:}, Sup{:,:}, Par.relMethod, tol);
else
    rel = [];
end

if Par.isRes
    res = resilience(Dem{:,:}, Sup{:,:}, Par.resMethod, tol);
else
    res = [];
end

if Par.isRes
    vul = vulnerability(Dem{:,:}, Sup{:,:}, Par.vulMethod, tol);
else
    vul = [];
end

if isDri
    dri = droughtrisk(rel, res, vul);
else
    dri = [];
end

if isSi
    si = sustainability(rel, res, vul);
else
    si = [];
end

indNames = {['REL_' Par.relMethod], ['RES_' Par.resMethod], ['VUL_' Par.vulMethod], 'DRI', 'SI'};
indValues = {rel.', res.', vul.', dri.', si.'};
isInd = cellfun('isempty', indValues);

indNames = indNames(isInd);
indValues = cell2mat(indValues(isInd));

T = cell2table(num2cell(indValues));
T.Properties.VariableNames = indNames;
T.Properties.RowNames = Dem.Properties.VariableNames;

end
