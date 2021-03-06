function [variablenames,numbervariables]=ridgepack_name(nc)

% ridgepack_name - Provides the names and number of variables in an nc structure
%
% function [variablenames,numbervariables]=ridgepack_name(nc)
%
% INPUT:
%
% This function extracts the names of variables in the data structure
% nc designed to have the following setup:
%
% nc.attributes - global netcdf attributes (or nc.global_atts)
% nc.name1      - netcdf variable structure 
% ..
% ..
% nc.nameN      - netcdf variable structure 
%
% Where the netcdf variable structure is defined in the documentation
% of ridgepack_struct.  The main purpose of this function is to extract
% only name1 to nameN, leaving out 'attributes' object.   Note
% that the structure may include nc.global_atts as an alternative
% to nc.attributes for global attributes.
%
%
% OUTPUT:
%
% variablenames   - cell array of variable names
% numbervariables - number of variables names in variablenames
%
% Ridgepack Version 1.0
% Andrew Roberts, Naval Postgraduate School, March 2018 (afrobert@nps.edu)
%

global debug;
if debug; disp(['Entering ',mfilename,'...']); end

% Check data is a structure
if ~isstruct(nc);
	    error([inputname(1),' is not a structure']);
end     


% Get number of variables to be written from the input structure
% being sure to filter out global attributes.
varn=fieldnames(nc);
numv=length(varn);
numbervariables=0;
for m = 1:numv
	if not(strcmp(varn(m),'attributes')) &&...
	   not(strcmp(varn(m),'global_atts')) ;
		numbervariables=numbervariables+1;
		variablenames(numbervariables)=varn(m);
	end
end

if numbervariables==0;
	error('There are no variables in nc')
end

if debug; disp(['...Leaving ',mfilename]); end

