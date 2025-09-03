function [filepaths,fileNames,fileSum] = F_GetDirPath(DIRPATH,filter)
fileFolder=fullfile(DIRPATH);
% filter='*.h5'
dirH5file=dir(fullfile(fileFolder,filter));

fileNames={dirH5file.name};

fileSum=size(fileNames,2);

filepaths={};

pathstring="";

    for i=1:fileSum
        pathstring=DIRPATH+string(fileNames(i));
        filepaths{i}=pathstring;
    end


end