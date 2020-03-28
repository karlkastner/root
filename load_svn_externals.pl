#!/usr/bin/perl
# Tue  8 Oct 09:33:30 PST 2019
# Karl Kastner, Berlin
#
## script emulating svn:external, which is not supported by GitHub
#
# There is a matlab bug with the system command, this perl script is provided as work-around
use strict;
use warnings;

my $fflag = 0;
if ( $#ARGV >= 0)
{
	$fflag = $ARGV[0];
}

use Text::CSV;
my $csv = Text::CSV->new({ sep_char => ';'});

my $file_str = 'svn-externals.csv';

open (my $file, "<", $file_str) or die "cannot open: $!";
#while (my $line = $csv->getline ($file)) {
while (my $line = <$file>) {
    #print @row;
	chomp $line;
	$line =~ s/\s\s*/;/g;
	if (length($line) > 0) {
	if ($csv->parse($line))  {
 	      my @fields = $csv->fields();
		my $dir_str  = $fields[0];
		my $rev_str  = $fields[1];
		my $repo_str = $fields[2];
		if (! -e $dir_str)
		{
		my $cmd = 'svn info --show-item revision '.$repo_str;
		print $cmd."\n";
		my $ret_str = `$cmd`;
		my $stat = $?;
		if (0 == $stat)
		{
			chomp $ret_str;
			#print "stat".$stat."\n";
			if ($rev_str < $ret_str)
			{
				print 'Note: Chosen revision '.$rev_str.' of repository '.$repo_str.' is older than latest available revision '.$ret_str."\n";
			}
			if ($rev_str > $ret_str)
			{
				print 'Note: Chosen revision '.$rev_str.' of repository '.$repo_str.' is higher than latest available revision '.$ret_str."\n";
				$rev_str = $ret_str;
			}
			if ($fflag > 0)
			{
				$cmd = 'svn checkout --quiet -r'.$rev_str.' '.$repo_str.' '.$dir_str;
				print $cmd."\n";
				$ret_str = `$cmd`;
				$stat = $?;
				print $ret_str;
				if (0 != $stat)
				{
					die "svn checkout failed";
				}
			}
		} else {
			die "svn cannot get version number";
		}
		} else {
			print 'Directory '.$dir_str.' exists already, nothing to do'."\n";
		}
  } else {
      warn "Line could not be parsed: $line\n";
  }
	}

}
close($file);
#tab = readtable(file_str,'HeaderLines',0,'Delimiter','tab','MultipleDelimsAsOne',1);
#for idx=1:size(tab,1)
#	dir_str  = tab{idx,1}{1};
#	rev      = tab{idx,2}(1);
#	rev_str  = num2str(rev);
#	repo_str = tab{idx,3}{1};
#	 trailing slash necessary, workaround for matlab bug detecting non-existing directories
#	cmd = ['svn info --show-item revision ',repo_str];
#	disp(cmd);
#	[stat, ret_str] = system(cmd);
#	disp(stat);
#	disp(ret_str);
#	if (stat > 0)
#		disp(ret_str);
#		error(sprintf('svn terminated with stat d',stat));
#	end
#	rev_latest      = str2num(ret_str);
#	if (rev_latest > rev)
#		fprintf(['Note: Chosen revision d of repository %s which is older than latest available revision %d\n'], rev, repo_str, rev_latest);
#	end
#	if (rev_latest < rev)
#		fprintf(['Note: Chosen revision d of repository %s is higher than latest available revision %d\n'], rev, repo_str, rev_latest);
#		rev = rev_latest;
#	end
#	if (~exist([dir_str,'/'],'dir'))
#		if (~exist(dir_str,'dir')
#			 check out
#			system(['svn checkout -r',rev_str,' ',repo_str,' ',dir_str]);
#		end
#	else
#		fprintf(['Directory ',dir_str,' exists already, nothing to do\n']);
#	end  else of if ~exist
#end  for idx
# 
