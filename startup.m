% Tue  8 Oct 09:47:41 PST 2019
% Karl Kastner, Berlin

% first call to set persistent rootfolder
ROOTFOLDER();

% fetch sub-repositories
% load_svn_externals();
% there is a matlab bug that makes calls to system commands unreliable,
% so a perl script is called here as a workaround
disp('fetching sub-repositories');
ret_str = perl('load_svn_externals.pl 1');
disp(ret_str);

% add sub-repositories to search path
disp('adding sub-directories to search path');
addpath('.');
addpath_recursive(['./lib/']);

%quick_data_download();

% remove recursively fetched directories with
% rm -rf phd.zip lib/ sanggau/ src/ dat/
% and run restoredefaultpath

