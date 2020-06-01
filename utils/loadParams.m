function params = loadParams(fName, params)
%loadParams Loads the parameters from fName and adds them to the struct
%params

%% Read in File
str = fileread(fName);

%% Extract Fields
fieldRegex = '(?<field>(^(?!\%))\w+[\.]?\w+[\.]?\w+?\n?)\s+';
valueRegex = '(?<value>[^\n%]+)';
commentregex = '(?<comment>%[^\n$]+)?';

% regular expression magic, don't touch
pieces = regexp(str, [fieldRegex valueRegex commentregex], ...
    'names','dotexceptnewline','lineanchors');

%% Loop Over Arguements
for k=1:length(pieces)
    field = pieces(k).field;
    val = pieces(k).value;
    tf= ismember(val, char([34 39]));    %remove " and ' from string
    val = strtrim(val(~tf));    %also remove spaces
    %try to convert to double.  If successful, use converted value,
    %otherwise use original (string) value
    valn = str2double(val);
    vale = [];
    try
        vale = eval(val);
    catch
    end
    
    if ~isnan(valn) %conversion successful, use as numeric
        val = valn;
    elseif ~isempty(vale)
        val = vale;
    end
    
    % account for sub structs
    fields = strsplit(field,'.');
    
    % add to output
    params = setfield(params, fields{:}, val);
end


end