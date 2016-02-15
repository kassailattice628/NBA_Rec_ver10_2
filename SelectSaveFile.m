function SelectSaveFile
global recobj

if isfield(recobj,'dirname') == 0
    [recobj.fname,recobj.dirname] = uiputfile('*.*');
else %一度フォルダを選択している場合は同じフォルダでを最初に開く
    recobj.fname = uiputfile('*.*','Select File to Write',recobj.dirname);
end

%拡張子はずす
pat = regexptranslate('wildcard', '.*');
if recobj.fname ~= 0
    recobj.fname = regexprep(recobj.fname, pat,'');
end

