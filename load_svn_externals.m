% Tue  8 Oct 09:33:30 PST 2019
% Karl Kastner, Berlin
%
%% script emulating svn:external, which is not supported by GitHub
%
file_str = 'svn-externals.csv';
tab = readtable(file_str,'HeaderLines',0,'Delimiter','tab','MultipleDelimsAsOne',1);
for idx=1:size(tab,1)
	dir_str  = tab{idx,1}{1};
	rev      = tab{idx,2}(1);
	rev_str  = num2str(rev);
	repo_str = tab{idx,3}{1};
	% trailing slash necessary, workaround for matlab bug detecting non-existing directories
	if (~exist([dir_str,'/'],'dir'))
		[stat, ret_str] = system(['svn info --show-item revision ',repo_str]);
		rev_latest = str2num(ret_str);
		if (rev_latest > rev)
			fprintf(['Note: Newer revision available for repository ',repo_str,'\n']);
		end
		%if (~exist(dir_str,'dir')
			% check out
			system(['svn checkout -r',rev_str,' ',repo_str,' ',dir_str]);
		%end
	else
		fprintf(['Directory ',dir_str,' exists already, nothing to do\n']);
	end % else of if ~exist
end % for idx
 
