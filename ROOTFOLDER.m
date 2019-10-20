% So 24. Jan 23:41:39 CET 2016
% Karl Kastner, Berlin
function retval = ROOTFOLDER()
	persistent rootfolder
	if (isempty(rootfolder))
		rootfolder = [pwd(),filesep];
	end
	retval = rootfolder;
end

