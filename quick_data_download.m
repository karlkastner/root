% Sun 20 Oct 17:50:15 PST 2019
% quick fix to get ADCP processing example running

% repository
%url='https://drive.google.com/drive/folders/1xa5Af9IlIBpIqulmSI571QeV5wcH2OOg?usp=sharing';
%
%file_C = {	['dat/kapuas/2013-12-09-sanggau-transect/mat/vadcp.mat'];
%		['dat/kapuas/2014-02-20-sanggau-transect/mat/vadcp.mat'];
%		['dat/kapuas/2014-04-18-sanggau-vadcp/mat/vadcp.mat'];
%		['dat/kapuas/2014-06-18-sanggau-vadcp/mat/vadcp.mat'];
%                ['dat/kapuas/2015-04-27-sanggau-vadcp/mat/vadcp.mat'];
%		['src/water-level/mat/water-level.mat'];
%	};
%
%for idx=1:length(file_C)
%	dirname_ = dirname(file_C{idx});
%	mkdir(dirname_);	
%	system(['wget -c ', url,'/',file_C{idx},' --output-document ',file_C{idx}]);
%end
%

% google has stopped file server like downloads, workaround:
%url='https://drive.google.com/open?id=1Q4vYf93-t-QwlrPOAZ67n-YqGPbLLyFM'
% skip virus scan
url='https://docs.google.com/uc?export=download&confirm=MGpv&id=1Q4vYf93-t-QwlrPOAZ67n-YqGPbLLyFM';
system(['wget -c ', url, ' --output-document phd.zip']);
system(['unzip phd.zip']); 

