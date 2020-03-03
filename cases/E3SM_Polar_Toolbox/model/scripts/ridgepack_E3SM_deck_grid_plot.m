
clf
clear

% Arctic Center
centlat=69; % degrees north
centlon=-100; % degrees east
horizon=90; % degrees of satellite horizon (0-90)
altitude=1; % Mean Earth radius multiple
cgrid=true; % plot c-grid coastline
coastname='DECK'; % grid name
plotmesh=true;

% location of grid file
gridloc='C:\Users\zhan006\OneDrive - PNNL\InteRFACE\Data_processing\Data\E3SM';
gridfile='oEC60to30v3_60layer.restartFrom_anvil0926.171101.nc';

% plot location
plotloc='C:\Users\zhan006\OneDrive - PNNL\InteRFACE\Data_processing\Fig';

% %%%%%%%%%%%%%%% CHANGE ABOVE THIS LINE %%%%%%%%%%%%%%%%%% %

% obtain grid information
cd(gridloc)
ncvert=ridgepack_clone(gridfile,{'latVertex','lonVertex','dcEdge',...
                                 'verticesOnCell','indexToCellID',...
                                 'nEdgesOnCell','edgesOnCell',...
                                 'cellsOnEdge','areaCell'});

nccell=ridgepack_clone(gridfile,{'latCell','lonCell','areaCell'});

nccell.areaCell.data=sqrt(nccell.areaCell.data)/1000;

ridgepack_satview(centlat,centlon,horizon,1,2)

if ~plotmesh

 % define contours
 cont=[26:2:62];
 ref=min(cont);

 % plot cell resolution
 ridgepack_psatcole3sm(nccell,'areaCell',ncvert,cont,ref,...
                       centlat,centlon,horizon,altitude);

 ridgepack_colorbar(cont,'km')

 title('Resolution')

else

 % plot mesh
 ridgepack_psatmeshe3sm(ncvert,centlat,centlon,horizon,altitude);

 title('Grid Outline')

end

% plot coastal outline
ridgepack_psatcoaste3sm(ncvert,cgrid,coastname,...
                             centlat,centlon,horizon);

cd(plotloc)
ridgepack_fprint('png','DECK_mesh2_horiz90',1,1)


