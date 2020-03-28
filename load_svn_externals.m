% Tue  8 Oct 09:33:30 PST 2019
% Karl Kastner, Berlin
%
%% script emulating svn:external, which is not supported by GitHub
%
function load_svn_externals(testflag)

if (nargin()<1)
	testflag = 0;
end

file_str = 'svn-externals.csv';
tab = readtable(file_str,'HeaderLines',0,'Delimiter','tab','MultipleDelimsAsOne',1);
for idx=1:size(tab,1)
	dir_str  = tab{idx,1}{1};
	rev      = tab{idx,2}(1);
	rev_str  = num2str(rev);
	repo_str = tab{idx,3}{1};
	% trailing slash necessary, workaround for matlab bug detecting non-existing directories
	cmd = ['svn info --show-item revision ',repo_str];
	disp(cmd);
	[stat, ret_str] = system(cmd);
	disp(stat);
	disp(ret_str);
	if (stat > 0)
		disp(ret_str);
		error(sprintf('svn terminated with stat %d',stat));
	end
	rev_latest      = str2num(ret_str);
	if (rev_latest > rev)
		fprintf(['Note: Chosen revision %d of repository %s which is older than latest available revision %d\n'], rev, repo_str, rev_latest);
	end
	if (rev_latest < rev)
		fprintf(['Note: Chosen revision %d of repository %s is higher than latest available revision %d\n'], rev, repo_str, rev_latest);
		rev = rev_latest;
	end
	if (~textflag)
	if (~exist([dir_str,'/'],'dir'))
		%if (~exist(dir_str,'dir')
			% check out
			system(['svn checkout -r',rev_str,' ',repo_str,' ',dir_str]);
		%end
	else
		fprintf(['Directory ',dir_str,' exists already, nothing to do\n']);
	end % else of if ~exist
	end
end % for idx

end % function load_svn_externals

