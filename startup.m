% Tue  8 Oct 09:47:41 PST 2019
% Karl Kastner, Berlin

% first call to set persistent rootfolder
ROOTFOLDER();

% fetch sub-repositories
load_svn_externals();

% add sub-repositories to search path
addpath('.');
addpath_recursive(['./lib/']);

%quick_data_download();

% remove recursively fetched directories with
% rm -rf phd.zip lib/ sanggau/ src/ dat/
% and run restoredefaultpath

