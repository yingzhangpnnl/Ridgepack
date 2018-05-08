
clear
clf

set(0,'DefaultTextInterpreter','Latex')

set(gca,'FontSize',12)
labelsize=get(gca,'FontSize');

arrowhead=0.010;
envelope=0.06;
textoffset=0.012;
cols=lines(10);


% dimensions of outer box
%xl=0.1;
%xr=0.9;
%yb=0.1;
%yt=0.9;
xl=0.08;
xr=0.92;
yb=0.08;
yt=0.92;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% first figure
ridgepack_multiplot(1,2,1,1)

% create initial deformation box
iboxx=[xl xr xr xl xl];
iboxy=[yb yb yt yt yb];
plot(iboxx,iboxy,'--','Color',0.25*[1 1 1])

% calculate ridge dimenions based on strain 
% based on frac of the floe deforming
frac=0.5
strain=-1/3
LF=frac*(xr-xl);
LK=LF*(1+strain);
xrl=(1-LK)/2;
xrr=(1+LK)/2;

% plot deformed box, where half of each side is underformed
xdl=1/2-LK/2-(1-frac)*(xr-xl)/2;
xdr=1/2+LK/2+(1-frac)*(xr-xl)/2;
ydb=yb;
ydt=yt;
iboxx=[xdl xdr xdr xdl xdl];
iboxy=[ydb ydb ydt ydt ydb];
plot(iboxx,iboxy,'-','Color',0*[1 1 1])

% change in x-distance from compression
deltax=(xdl-xl);

% ridge color
ridgecolor=0.75*[1 1 1];

% plot ridge box
yrb=yb;
yrt=yt;
iboxx=[xrl xrr xrr xrl xrl];
iboxy=[yrb yrb yrt yrt yrb];
patch(iboxx,iboxy,ridgecolor,'EdgeColor','none')

% plot pressure ridge edges
iboxx=[xrr xrr NaN xrl xrl];
iboxy=[yrb yrt NaN yrt yrb];
plot(iboxx,iboxy,'-.','Color',cols(2,:))

% plot cross-hairs
xc=(xl+xr)/2;
yc=(yt+yb)/2;
plot([xc xc],[yb yt],':','Color',cols(1,:))
%plot([xr xl],[yc yc],':k')

% add ridge annotation
text(xc,(1.2*yt+0.8*yc)/2,...
      'Ridge Line',...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','center',...
      'Interpreter','Latex',...
      'BackgroundColor',ridgecolor,...
      'Rotation',-90,...
      'Margin',0.5,...
      'Fontsize',labelsize,...
      'Color',cols(1,:));

% add leading edge annotation
text(xrl,(1.2*yt+0.8*yc)/2,...
      'Leading Edge',...
      'VerticalAlignment','top',...
      'HorizontalAlignment','center',...
      'Interpreter','Latex',...
      'Rotation',-90,...
      'Fontsize',labelsize-3,...
      'Color',cols(2,:));

text(xrr,(1.2*yt+0.8*yc)/2,...
      'Leading Edge',...
      'VerticalAlignment','top',...
      'HorizontalAlignment','center',...
      'Interpreter','Latex',...
      'Rotation',90,...
      'Fontsize',labelsize-3,...
      'Color',cols(2,:));

% add floe annotation
text((xdl+xrl)/2,yc+6*textoffset,...
      'Floe $F_a$',...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','center',...
      'Interpreter','Latex',...
      'Rotation',0,...
      'Fontsize',labelsize-2,...
      'Color',0.25*[1 1 1]);

text((xdr+xrr)/2,yc+6*textoffset,...
      'Floe $F_b$',...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','center',...
      'Interpreter','Latex',...
      'Rotation',0,...
      'Fontsize',labelsize-2,...
      'Color',0.25*[1 1 1]);

% plot LK metric bar
arrowheads=arrowhead*cosd(45);
x=[xrl+arrowheads xrl xrl+arrowheads xrl xrr xrr-arrowheads xrr xrr-arrowheads];
y=[yc+arrowheads yc yc-arrowheads yc yc yc-arrowheads yc yc+arrowheads];
plot(x,y,'Color',[1 0. 0],'LineWidth',0.7)

text((xrl+xc)/2,yc,...
      '$\,L_K$',...
      'VerticalAlignment','bottom',...
      'HorizontalAlignment','center',...
      'Interpreter','Latex',...
      'Rotation',0,...
      'Fontsize',labelsize-1,...
      'Color','r');

% add feeding plate left arrows
x=[xrl-2*envelope ...
   xrl-2*arrowhead ...
   xrl-2*arrowhead ...
   xrl ...
   xrl-2*arrowhead ...
   xrl-2*arrowhead];
y=[yc ...
   yc ...
   yc+arrowhead ...
   yc ...
   yc-arrowhead ...
   yc];
plot(x,y,'k','LineWidth',0.7)

text((xrl-2*envelope),yc,...
      '$\hat{v}_{F_a}$',...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','right',...
      'Interpreter','Latex',...
      'Fontsize',labelsize,...
      'Color','k');

% also plot latex arrow at edge of plate
text(xdl,yc,...
      '$\rightarrow$',...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','right',...
      'Interpreter','Latex',...
      'Fontsize',labelsize,...
      'Color',0.5*[1 1 1]);

% add feeding plate right arrows
x=[xrr+2*envelope ...
   xrr+2*arrowhead ...
   xrr+2*arrowhead ...
   xrr ...
   xrr+2*arrowhead ...
   xrr+2*arrowhead];
y=[yc ...
   yc ...
   yc+arrowhead ...
   yc ...
   yc-arrowhead ...
   yc];
plot(x,y,'k','LineWidth',0.7)

text((xrr+2*envelope),yc,...
      '$\;\hat{v}_{F_b}$',...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','left',...
      'Interpreter','Latex',...
      'Fontsize',labelsize,...
      'Color','k');

% also plot latex arrow at edge of plate
text(xdr,yc,...
      '$\leftarrow$',...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','left',...
      'Interpreter','Latex',...
      'Fontsize',labelsize,...
      'Color',0.5*[1 1 1]);


% add axes and aspect ratio annotation 
  boxrightx=xdl;
  ylbottom=ydb;
  scaleaxes=0.08;
  envelopex=0.06;
  envelopey=envelopex+scaleaxes;

  x=[boxrightx+envelopex-0.5*arrowhead ...
     boxrightx+envelopex ... 
     boxrightx+envelopex+0.5*arrowhead ...
     boxrightx+envelopex ... 
     boxrightx+envelopex ...
     boxrightx+envelopex+scaleaxes ...
     boxrightx+envelopex+scaleaxes-arrowhead ...
     boxrightx+envelopex+scaleaxes ...
     boxrightx+envelopex+scaleaxes-arrowhead];

  y=[ylbottom+envelopey-arrowhead ...
     ylbottom+envelopey ...
     ylbottom+envelopey-arrowhead ...
     ylbottom+envelopey ...
     ylbottom+envelopey-scaleaxes ...
     ylbottom+envelopey-scaleaxes ...
     ylbottom+envelopey-scaleaxes+0.5*arrowhead  ...
     ylbottom+envelopey-scaleaxes ...
     ylbottom+envelopey-scaleaxes-0.5*arrowhead];

  greycol=0.5*[1 1 1]
  line(x,y,'Color',greycol)

  text(x(2)-textoffset,(y(end-1)+y(1))/2,...
           '$\hat{y}$',...
           'Color',greycol,...
           'VerticalAlignment','middle',...
           'HorizontalAlignment','right',...
           'Interpreter','Latex',...
           'Fontsize',labelsize-1,...
           'EdgeColor','none')

  text((x(2)+x(end-3))/2,y(end-1),...
           '$\hat{x}$',...
           'Color',greycol,...
           'VerticalAlignment','top',...
           'HorizontalAlignment','center',...
           'Interpreter','Latex',...
           'Fontsize',labelsize-1,...
           'EdgeColor','none')

  text((x(2)+x(end-1))/2,(y(end-1)+y(2))/2,...
           {'$\hat{x}$:$\hat{y}$','1:1'},...
           'Color',greycol,...
           'VerticalAlignment','middle',...
           'HorizontalAlignment','center',...
           'Interpreter','Latex',...
           'Fontsize',labelsize-1,...
           'EdgeColor','none')


% set limits on plot
xlim([0 1])
ylim([0 1])
axis square
set(gca,'XTicklabel',[],'XTick',[],'XColor','none')
set(gca,'YTicklabel',[],'YTick',[],'YColor','none')
set(gca,'YColor','none')

% figurare notation and title 
text(xl,(yt+1)/2,'a)','HorizontalAlignment','left',...
             'VerticalAlignment','middle',...
             'Units','normalized',...
             'FontName','Helvetica',...
             'Interpreter','Tex',...
             'FontSize',labelsize-1,'Color','k',...
             'Parent',gca,'Interpreter','Tex');
text((xl+xr)/2,(yt+1)/2,'Pressure Ridge','HorizontalAlignment','center',...
             'VerticalAlignment','middle',...
             'Units','normalized',...
             'FontName','Serif',...
             'Interpreter','Tex',...
             'FontSize',labelsize,'Color','k',...
             'Parent',gca,'Interpreter','Tex');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% second figure
ridgepack_multiplot(1,2,1,2)

% create initial deformation box
iboxx=[xl xr xr xl xl];
iboxy=[yb yb yt yt yb];
plot(iboxx,iboxy,'--','Color',0.25*[1 1 1])

%angle of compressional repose
alpha_R=22;

%angle of actual repose
theta=55;

% apparent angle of repose
alpha=acotd(cosd(theta)*cotd(alpha_R));

if theta<45
 error('Graphics only set up for theta>=45')
end

% plot ridge line patch
xdl=xl+deltax;
xdrt=xr+deltax;
xdrb=xr-deltax;
ydlt=yb+0.5*(yt-yb)*(1+cotd(theta))-deltax*cotd(theta);
ydlb=yb+0.5*(yt-yb)*(1+cotd(theta))-deltax*cotd(theta)-LK*cotd(theta)/2;
ydrt=yb+0.5*(yt-yb)*(1-cotd(theta))-deltax*cotd(theta);
ydrb=yb+0.5*(yt-yb)*(1-cotd(theta))-deltax*cotd(theta);
iboxx=[xdl xdl xdrt xdrb xdl];
iboxy=[ydlb ydlt ydrt ydrb ydlb];
patch(iboxx,iboxy,ridgecolor,'EdgeColor','none')

% plot first deformed box
xdl=xl+deltax;
xdr=xr+deltax;
xdm=xr+deltax;
ydb=yb
ydm=yb+0.5*(yt-yb)*(1-cotd(theta))-deltax*cotd(theta);
ydt=yb+0.5*(yt-yb)*(1+cotd(theta))-deltax*cotd(theta);
iboxx=[xdl xdl xdl xdr xdm];
iboxy=[ydt ydb ydb ydb ydm];
plot(iboxx,iboxy,'-','Color',0*[1 1 1])

% annotate lower ridge
text((xdl+xrl)/2,yc-6*textoffset,...
      'Floe $F_a$',...
      'VerticalAlignment','top',...
      'HorizontalAlignment','center',...
      'Interpreter','Latex',...
      'Rotation',0,...
      'Fontsize',labelsize-2,...
      'Color',0.25*[1 1 1]);

% store dimensions of first floe
xdm1=xdm;
xdl1=xdl;
ydm1=ydm;
ydt1=ydt;
ydb1=ydb;

% add feeding plate left arrows
x=[xrl-2*envelope ...
   xrl-2*arrowhead ...
   xrl-2*arrowhead ...
   xrl ...
   xrl-2*arrowhead ...
   xrl-2*arrowhead];
y=[yc ...
   yc ...
   yc+arrowhead ...
   yc ...
   yc-arrowhead ...
   yc];
plot(x,y,'k','LineWidth',0.7)

text((xrl-2*envelope),yc,...
      '$\hat{v}_{F_a}$',...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','right',...
      'Interpreter','Latex',...
      'Fontsize',labelsize,...
      'Color','k');

% also plot latex arrow at edge of plate
text(xdl,yc,...
      '$\rightarrow$',...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','right',...
      'Interpreter','Latex',...
      'Fontsize',labelsize,...
      'Color',0.5*[1 1 1]);

% add feeding plate left arrow at hard right edge
x=[xdr-2*envelope ...
   xdr-2*arrowhead ...
   xdr-2*arrowhead ...
   xdr ...
   xdr-2*arrowhead ...
   xdr-2*arrowhead];
y=[(ydb+ydm)/2 ...
   (ydb+ydm)/2 ...
   (ydb+ydm)/2+arrowhead ...
   (ydb+ydm)/2 ...
   (ydb+ydm)/2-arrowhead ...
   (ydb+ydm)/2];
plot(x,y,'k','LineWidth',0.7)

text((xdr-2*envelope),(ydb+ydm)/2,...
      '$\hat{v}_{F_a}$',...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','right',...
      'Interpreter','Latex',...
      'Fontsize',labelsize,...
      'Color','k');

% plot ridge line patch
xdlt=xl+deltax;
xdlb=xl-deltax;
xdr=xr-deltax;
ydlt=yb+0.5*(yt-yb)*(1+cotd(theta))+deltax*cotd(theta);
ydlb=yb+0.5*(yt-yb)*(1+cotd(theta))+deltax*cotd(theta);
ydrt=yb+0.5*(yt-yb)*(1-cotd(theta))+deltax*cotd(theta)+LK*cotd(theta)/2;
ydrb=yb+0.5*(yt-yb)*(1-cotd(theta))+deltax*cotd(theta);
iboxx=[xdlb xdlt xdr xdr xdlb];
iboxy=[ydlb ydlt ydrt ydrb ydlb];
patch(iboxx,iboxy,ridgecolor,'EdgeColor','none')

% plot second deformed box
xdl=xl-deltax;
xdr=xr-deltax;
xdm=xl-deltax;
ydt=yt;
ydm=yb+0.5*(yt-yb)*(1+cotd(theta))+deltax*cotd(theta);
ydb=yb+0.5*(yt-yb)*(1-cotd(theta))+deltax*cotd(theta);
iboxx=[xdm xdl xdr xdr];
iboxy=[ydm ydt ydt ydb];
plot(iboxx,iboxy,'-','Color',0*[1 1 1])


% annotate ridge line
iboxx=[xdm1 xdm];
iboxy=[ydm1 ydm];
plot(iboxx,iboxy,':','Color',cols(4,:))

text(xdl1-0.035*cosd(90+theta),ydt1-(0.035*sind(90+theta)),...
      'Ridge Line',...
      'BackgroundColor',ridgecolor,...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','left',...
      'Interpreter','Latex',...
      'Rotation',theta-90,...
      'Margin',0.5,...
      'Fontsize',labelsize-1,...
      'Color',cols(4,:));

% plot pressure ridge edges
iboxx=[xrr xrr NaN xrl xrl];
iboxy=[yrb yrt NaN yrt yrb];
plot(iboxx,iboxy,'-.','Color',cols(2,:))

% plot cross-hairs
xc=(xl+xr)/2;
yc=(yt+yb)/2;
plot([xc xc],[yb yt],':','Color',cols(1,:))
%plot([xr xl],[yc yc],':k')

% add feeding plate right arrows
x=[xrr+2*envelope ...
   xrr+2*arrowhead ...
   xrr+2*arrowhead ...
   xrr ...
   xrr+2*arrowhead ...
   xrr+2*arrowhead];
y=[yc ...
   yc ...
   yc+arrowhead ...
   yc ...
   yc-arrowhead ...
   yc];
plot(x,y,'k','LineWidth',0.7)

text((xrr+2*envelope),yc,...
      '$\;\hat{v}_{F_b}$',...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','left',...
      'Interpreter','Latex',...
      'Fontsize',labelsize,...
      'Color','k');

% also plot latex arrow at edge of plate
text(xdr,yc,...
      '$\leftarrow$',...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','left',...
      'Interpreter','Latex',...
      'Fontsize',labelsize,...
      'Color',0.5*[1 1 1]);

% add feeding plate right arrows on left of plate
x=[xdl+2*envelope ...
   xdl+2*arrowhead ...
   xdl+2*arrowhead ...
   xdl ...
   xdl+2*arrowhead ...
   xdl+2*arrowhead];
y=[(yrt+ydm)/2 ...
   (yrt+ydm)/2 ...
   (yrt+ydm)/2+arrowhead ...
   (yrt+ydm)/2 ...
   (yrt+ydm)/2-arrowhead ...
   (yrt+ydm)/2];
plot(x,y,'k','LineWidth',0.7)

text((xdl+2*envelope),(yrt+ydm)/2,...
      '$\;\hat{v}_{F_b}$',...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','left',...
      'Interpreter','Latex',...
      'Fontsize',labelsize,...
      'Color','k');

% add floe annotation
text((xdr+xrr)/2,yc+6*textoffset,...
      'Floe $F_b$',...
      'VerticalAlignment','middle',...
      'HorizontalAlignment','center',...
      'Interpreter','Latex',...
      'Rotation',0,...
      'Fontsize',labelsize-2,...
      'Color',0.25*[1 1 1]);

% plot LK metric bar
arrowheads=arrowhead*cosd(45);

% plot LK metric bar
xlk=0.5-(LK/2)*cosd(theta)*cosd(theta)
xrk=0.5+(LK/2)*cosd(theta)*cosd(theta)
ybk=0.5-(LK/2)*cosd(theta)*sind(theta)
ytk=0.5+(LK/2)*cosd(theta)*sind(theta)
x=[xlk xrk];
y=[ybk ytk];
plot(x,y,'Color',[1 0. 0],'LineWidth',0.7)

xx=(arrowhead)*cosd(theta-45-90)
yy=(arrowhead)*sind(theta-45-90)
x=[xrk xrk+xx];
y=[ytk ytk+yy];
plot(x,y,'Color',[1 0. 0],'LineWidth',0.7)

xx=(arrowhead)*cosd(theta+45+90)
yy=(arrowhead)*sind(theta+45+90)
x=[xrk xrk+xx];
y=[ytk ytk+yy];
plot(x,y,'Color',[1 0. 0],'LineWidth',0.7)

xx=(arrowhead)*cosd(theta+45)
yy=(arrowhead)*sind(theta+45)
x=[xlk xlk+xx];
y=[ybk ybk+yy];
plot(x,y,'Color',[1 0. 0],'LineWidth',0.7)

xx=(arrowhead)*cosd(theta-45)
yy=(arrowhead)*sind(theta-45)
x=[xlk xlk+xx];
y=[ybk ybk+yy];
plot(x,y,'Color',[1 0. 0],'LineWidth',0.7)

text(xlk,ybk,...
      '$\,L_K$',...
      'VerticalAlignment','bottom',...
      'HorizontalAlignment','left',...
      'Interpreter','Latex',...
      'Rotation',theta,...
      'Fontsize',labelsize-1,...
      'Color','r');

% plot angle
radius=1.5*deltax*cotd(theta);
angle=[0:0.1:theta]+90;
x=radius*cosd(angle);
y=radius*sind(angle);
plot(0.5+x,0.5+y,'-','Color','b','LineWidth',0.7)

text(0.5+x(floor(end/2)),0.5+y(floor(end/2)),...
      '$\pi{-}\theta_R$',...
      'VerticalAlignment','bottom',...
      'HorizontalAlignment','center',...
      'Interpreter','Latex',...
      'Margin',0.01,...
      'Fontsize',labelsize-3,...
      'Rotation',mean(angle)-90,...
      'Color','b');

% add axes and aspect ratio annotation 
  boxrightx=xdl1;
  ylbottom=ydb1;
  scaleaxes=0.08;
  envelopex=0.06;
  envelopey=envelopex+scaleaxes;

  x=[boxrightx+envelopex-0.5*arrowhead ...
     boxrightx+envelopex ... 
     boxrightx+envelopex+0.5*arrowhead ...
     boxrightx+envelopex ... 
     boxrightx+envelopex ...
     boxrightx+envelopex+scaleaxes ...
     boxrightx+envelopex+scaleaxes-arrowhead ...
     boxrightx+envelopex+scaleaxes ...
     boxrightx+envelopex+scaleaxes-arrowhead];

  y=[ylbottom+envelopey-arrowhead ...
     ylbottom+envelopey ...
     ylbottom+envelopey-arrowhead ...
     ylbottom+envelopey ...
     ylbottom+envelopey-scaleaxes ...
     ylbottom+envelopey-scaleaxes ...
     ylbottom+envelopey-scaleaxes+0.5*arrowhead  ...
     ylbottom+envelopey-scaleaxes ...
     ylbottom+envelopey-scaleaxes-0.5*arrowhead];

  greycol=0.5*[1 1 1]
  line(x,y,'Color',greycol)

  text(x(2)-textoffset,(y(end-1)+y(1))/2,...
           '$\hat{y}$',...
           'Color',greycol,...
           'VerticalAlignment','middle',...
           'HorizontalAlignment','right',...
           'Interpreter','Latex',...
           'Fontsize',labelsize-1,...
           'EdgeColor','none')

  text((x(2)+x(end-3))/2,y(end-1),...
           '$\hat{x}$',...
           'Color',greycol,...
           'VerticalAlignment','top',...
           'HorizontalAlignment','center',...
           'Interpreter','Latex',...
           'Fontsize',labelsize-1,...
           'EdgeColor','none')

  text((x(2)+x(end-1))/2,(y(end-1)+y(2))/2,...
           {'$\hat{x}$:$\hat{y}$','1:1'},...
           'Color',greycol,...
           'VerticalAlignment','middle',...
           'HorizontalAlignment','center',...
           'Interpreter','Latex',...
           'Fontsize',labelsize-1,...
           'EdgeColor','none')


% set limits on plot
xlim([0 1])
ylim([0 1])
axis square
set(gca,'XTicklabel',[],'XTick',[],'XColor','none')
set(gca,'YTicklabel',[],'YTick',[],'YColor','none')
set(gca,'YColor','none')

% title
text(xl,(yt+1)/2,'b)','HorizontalAlignment','left',...
             'VerticalAlignment','middle',...
             'Units','normalized',...
             'FontName','Helvetica',...
             'Interpreter','Tex',...
             'FontSize',labelsize-1,'Color','k',...
             'Parent',gca,'Interpreter','Tex');
text((xl+xr)/2,(yt+1)/2,'Shear Ridge','HorizontalAlignment','center',...
             'VerticalAlignment','middle',...
             'Units','normalized',...
             'FontName','Serif',...
             'Interpreter','Tex',...
             'FontSize',labelsize,'Color','k',...
             'Parent',gca,'Interpreter','Tex');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% finalize figure
ridgepack_multialign(gcf)

h=get(gcf,'Children');
set(h(5),'Visible','off');

dir=fileparts(which(mfilename));
cd([dir(1:strfind(dir,'scripts')-1),'output']);
ridgepack_fprint('png',['figure4'],1,2)
ridgepack_fprint('epsc',['figure4'],1,2)

