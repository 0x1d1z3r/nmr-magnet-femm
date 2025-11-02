%ADD YOUR FEMM INSTALL PATH HERE 
addpath("/home/user/.wine/drive_c/femm42/mfiles/");
savepath;
tic
openfemm(0);
newdocument(0);
smartmesh(1);
yoke_thickness = 5;
pole_cap_thickness = 2.25;
pole_cap_height=2.5;
pole_cap_base = 0.5;
centerresflag = 1; % if center should be meshed seperately
mag_yoke_dist = 4; % vertical distance between magnet and yoke (in cm)
magnet_height = 7; % height of magnet (in cm)
magnet_width = 3; % width of magnet (in cm)
pole_cap_dist = 0.4;% distance of pole caps (in cm)
yoke_width = 2*yoke_thickness + 2* pole_cap_thickness + pole_cap_dist + 2*magnet_width + 2*pole_cap_base;
yoke_height = 2*yoke_thickness + 2 * mag_yoke_dist + magnet_height;
mi_getmaterial('Air');
magnet_material = 'N40';
yoke_material = '1117 Steel';
pole_cap_material = '1117 Steel';
if ~strcmp(pole_cap_material,yoke_material)
    mi_getmaterial(pole_cap_material);
end
mi_getmaterial(magnet_material);
mi_getmaterial(yoke_material);
if centerresflag == 1
    mi_drawrectangle(yoke_thickness+magnet_width+pole_cap_base+pole_cap_thickness,yoke_thickness+mag_yoke_dist+magnet_height/2-pole_cap_height/2,yoke_width-yoke_thickness-magnet_width-pole_cap_base-pole_cap_thickness,yoke_thickness+mag_yoke_dist+magnet_height/2+pole_cap_height/2)
    %SET UPPER AIR BLOCKPROPS
    mi_addblocklabel(yoke_width/2,yoke_height-yoke_thickness-mag_yoke_dist/2);
    mi_selectlabel(yoke_width/2,yoke_height-yoke_thickness-mag_yoke_dist/2);
    mi_setblockprop('Air',1,0, '' ,0, 0,1);
    mi_clearselected()
    %SET LOWER AIR BLOCKPROPS
    mi_addblocklabel(yoke_width/2,yoke_thickness+mag_yoke_dist/2);
    mi_selectlabel(yoke_width/2,yoke_thickness+mag_yoke_dist/2);
    mi_setblockprop('Air',1,0, '' ,0, 0,1);
    mi_clearselected()
else
    %LEFT POLE
    mi_drawline(yoke_thickness+magnet_width+pole_cap_thickness+pole_cap_base,yoke_thickness+mag_yoke_dist+(magnet_height/2)-(pole_cap_height/2),yoke_thickness+magnet_width+pole_cap_base+pole_cap_thickness,yoke_thickness+mag_yoke_dist+(magnet_height/2)+(pole_cap_height/2))
    %RIGHT POLE
    mi_drawline(pole_cap_dist+yoke_thickness+magnet_width+pole_cap_thickness,yoke_thickness+mag_yoke_dist+(magnet_height/2)-(pole_cap_height/2),yoke_thickness+pole_cap_base+magnet_width+pole_cap_thickness+pole_cap_dist,yoke_thickness+mag_yoke_dist+(magnet_height/2)+(pole_cap_height/2))
end
%OUTER LINE FOR YOKE
mi_drawrectangle(0,0,yoke_width,yoke_height)
%INNER LINE FOR YOKE
mi_drawrectangle(yoke_thickness,yoke_thickness,yoke_width-yoke_thickness,yoke_height-yoke_thickness)
%LEFT MAGNET
mi_drawrectangle(yoke_thickness,yoke_thickness + mag_yoke_dist,yoke_thickness + magnet_width,yoke_thickness + mag_yoke_dist+ magnet_height)
%RIGHT MAGNET
mi_drawrectangle(yoke_thickness+2*pole_cap_thickness+pole_cap_dist+magnet_width+2*pole_cap_base,yoke_thickness+mag_yoke_dist,yoke_width-yoke_thickness,yoke_height-yoke_thickness-mag_yoke_dist)
%LEFT POLECAP BASE
mi_addnode(yoke_thickness+magnet_width+pole_cap_base,yoke_thickness+mag_yoke_dist)
mi_addnode(yoke_thickness+magnet_width+pole_cap_base,yoke_thickness+mag_yoke_dist+magnet_height)
mi_addsegment(yoke_thickness+magnet_width,yoke_thickness+mag_yoke_dist,yoke_thickness+magnet_width+pole_cap_base,yoke_thickness+mag_yoke_dist)
mi_addsegment(yoke_thickness+magnet_width,yoke_thickness+mag_yoke_dist+magnet_height,yoke_thickness+magnet_width+pole_cap_base,yoke_thickness+mag_yoke_dist+magnet_height)
%RIGHT POLECAP BASE
mi_addnode(yoke_width-yoke_thickness-magnet_width-pole_cap_base,yoke_thickness+mag_yoke_dist)
mi_addnode(yoke_width-yoke_thickness-magnet_width-pole_cap_base,yoke_thickness+mag_yoke_dist+magnet_height)
mi_addsegment(yoke_width-yoke_thickness-magnet_width,yoke_thickness+mag_yoke_dist,yoke_width-yoke_thickness-magnet_width-pole_cap_base,yoke_thickness+mag_yoke_dist)
mi_addsegment(yoke_width-yoke_thickness-magnet_width,yoke_thickness+mag_yoke_dist+magnet_height,yoke_width-yoke_thickness-magnet_width-pole_cap_base,yoke_thickness+mag_yoke_dist+magnet_height)
%LEFT POLECAP SLOPES
mi_addsegment(yoke_thickness+magnet_width+pole_cap_base,yoke_thickness+mag_yoke_dist,yoke_thickness+magnet_width+pole_cap_thickness,yoke_thickness+mag_yoke_dist+(magnet_height/2)-(pole_cap_height/2))
mi_addsegment(yoke_thickness+magnet_width+pole_cap_base,yoke_thickness+mag_yoke_dist+magnet_height,yoke_thickness+magnet_width+pole_cap_thickness,yoke_thickness+mag_yoke_dist+(magnet_height/2)+(pole_cap_height/2))
%RIGHT POLECAP SLOPES
mi_addsegment(yoke_thickness+magnet_width+pole_cap_base+pole_cap_thickness+pole_cap_dist,yoke_thickness+mag_yoke_dist+(magnet_height/2)-(pole_cap_height/2),yoke_width-yoke_thickness-magnet_width-pole_cap_base,yoke_thickness+mag_yoke_dist)
mi_addsegment(yoke_thickness+magnet_width+pole_cap_base+pole_cap_thickness+pole_cap_dist,yoke_thickness+mag_yoke_dist+(pole_cap_height/2)+(magnet_height/2),yoke_width-yoke_thickness-magnet_width-pole_cap_base,yoke_height-yoke_thickness-mag_yoke_dist);
%SET YOKE BLOCKPROPS
mi_addblocklabel(yoke_thickness/2,yoke_height/2);
mi_selectlabel(yoke_thickness/2,yoke_height/2);
mi_setblockprop(yoke_material,1,0, '' ,0, 0,1);
mi_clearselected()
%SET LEFT MAGNET BLOCKPROPS
mi_addblocklabel(yoke_thickness+magnet_width/2,yoke_height/2);
mi_selectlabel(yoke_thickness+magnet_width/2,yoke_height/2);
mi_setblockprop(magnet_material,1,0, '' ,0, 0,1);
mi_clearselected()
%SET RIGHT MAGNET BLOCKPROPS
mi_addblocklabel(yoke_width-yoke_thickness-magnet_width/2,yoke_height/2);
mi_selectlabel(yoke_width-yoke_thickness-magnet_width/2,yoke_height/2);
mi_setblockprop(magnet_material,1,0, '' ,0, 0,1);
mi_clearselected()
if centerresflag == 1
    %SET LEFT POLECAP BLOCKPROPS
    mi_addblocklabel(yoke_thickness+magnet_width+pole_cap_thickness/2,yoke_height/2);
    mi_selectlabel(yoke_thickness+magnet_width+pole_cap_thickness/2,yoke_height/2);
    mi_setblockprop(pole_cap_material,0,1, '' ,0, 0,1);
    mi_clearselected()
    %SET RIGHT POLECAP BLOCKPROPS
    mi_addblocklabel(yoke_width-yoke_thickness-magnet_width-pole_cap_thickness/2,yoke_height/2);
    mi_selectlabel(yoke_width-yoke_thickness-magnet_width-pole_cap_thickness/2,yoke_height/2);
    mi_setblockprop(pole_cap_material,0,1, '' ,0, 0,1);
    mi_clearselected()
    %SET CENTER AIR BLOCKPROPS
    mi_addblocklabel(yoke_width/2,yoke_height/2);
    mi_selectlabel(yoke_width/2,yoke_height/2);
    mi_setblockprop('Air',0,0.005, '' ,0, 0,1);
    mi_clearselected()

else
    %SET LEFT POLECAP BLOCKPROPS
    mi_addblocklabel(yoke_thickness+magnet_width+pole_cap_thickness/2,yoke_height/2);
    mi_selectlabel(yoke_thickness+magnet_width+pole_cap_thickness/2,yoke_height/2);
    mi_setblockprop(pole_cap_material,1,0, '' ,0, 0,1);
    mi_clearselected()
    %SET RIGHT POLECAP BLOCKPROPS
    mi_addblocklabel(yoke_width-yoke_thickness-magnet_width-pole_cap_thickness/2,yoke_height/2);
    mi_selectlabel(yoke_width-yoke_thickness-magnet_width-pole_cap_thickness/2,yoke_height/2);
    mi_setblockprop(pole_cap_material,1,0, '' ,0, 0,1);
    mi_clearselected()
    %SET CENTER AIR BLOCKPROPS
    mi_addblocklabel(yoke_width/2,yoke_height/2);
    mi_selectlabel(yoke_width/2,yoke_height/2);
    mi_setblockprop('Air',1,0, '' ,0, 0,1);
    mi_clearselected() 
end
%ADD BOUNDARY RECTANGLE
mi_drawrectangle(-2*yoke_width,-2*yoke_height,3*yoke_width,3*yoke_height)
%SET BOUNDARY RECTANGLE BLOCKPROPS
mi_addblocklabel(-yoke_width,yoke_height/2);
mi_selectlabel(-yoke_width,yoke_height/2);
mi_setblockprop('Air',1,0, '' ,0, 0,1);
mi_clearselected()
%REFRESH FOR BLOCK LABELS
mi_refreshview()
mi_saveas('test1output.fem')
mi_analyze(0)
mi_loadsolution()
%%
z=mo_getb(round(yoke_width/2,6),round(yoke_height/2,6));
centerflux = hypot(z(1),z(2));
center_flux_arr = zeros(round(pole_cap_height*100),round(pole_cap_dist*100));
subdiv = 200; % divisions of cm ;for example :100 = 0.1mm
for x= 1:round(pole_cap_dist*subdiv+1)
    for y= 1: round(pole_cap_height*subdiv+1)
        xval=yoke_thickness+magnet_width+pole_cap_base+pole_cap_thickness+1/subdiv*(x-1);
        yval=yoke_thickness+mag_yoke_dist+magnet_height/2-pole_cap_height/2+1/subdiv*(y-1);
        tempval =0;
        %BELOW HERE IS A REAL AWFUL HACK TO BRUTEFORCE THROUGH CALLFEMM ERRORS (PLS DONT REPEAT)
        flag = 1;
        while flag == 1
            try
                tempval=mo_getb(xval,yval);
                flag = 0;
            catch
            end
        end

        center_flux_arr(y,x)=hypot(tempval(1),tempval(2));
    end
end
toc
%%
center_homogeneity_arr = zeros(size(center_flux_arr));
for i = 1:numel(center_flux_arr)
  center_homogeneity_arr(i) = log10(abs(centerflux-center_flux_arr(i)));
end
%closefemm
x = -pole_cap_dist*5:10/subdiv:pole_cap_dist*5;
y = -pole_cap_height*5:10/subdiv:pole_cap_height*5;
[X,Y] = meshgrid(x,y);
contourf(X,Y,center_homogeneity_arr);
daspect([1 1 1])
xlabel('pole cap distance [mm]')
ylabel('pole cap height [mm]')
xticks(linspace(-pole_cap_dist*10/2,pole_cap_dist*10/2,pole_cap_dist*10+1))
yticks(linspace(-pole_cap_height*10/2,pole_cap_height*10/2,pole_cap_height*10+1))
axis([-pole_cap_dist*10/2,pole_cap_dist*10/2,-pole_cap_height*10/2,pole_cap_height*10/2]);
ax = gca; % current axes
ax.FontSize = 12;
ax.TickDir = 'out';
ax.TickLength = [0.02 0.02];
c = colorbar;
c.Label.String = 'log10(Δ center flux density) [T]';
str = {'B_0 = '+ convertCharsToStrings(num2str(centerflux)) + 'T' ,...
    'Frequency ^1H = ' + convertCharsToStrings(num2str(centerflux*42.58)) + 'MHz' ,...
    'yoke thickness = ' + convertCharsToStrings(num2str(yoke_thickness*10)) + 'mm' ,...
    'yoke material = '  + convertCharsToStrings(yoke_material),...
    'distance between magnet and yoke = ' + convertCharsToStrings(num2str(mag_yoke_dist*10)) + 'mm' ,...
    'magnet height = ' + convertCharsToStrings(num2str(magnet_height*10)) + 'mm' ,...
    'magnet width = ' + convertCharsToStrings(num2str(magnet_width*10)) + 'mm' ,...
    'magnet material = ' + convertCharsToStrings(magnet_material) ,...
    'pole cap base = '+ convertCharsToStrings(num2str(pole_cap_base*10)) + 'mm' ,...
    'pole cap thickness = '+ convertCharsToStrings(num2str(pole_cap_thickness*10)) + 'mm' ,...
    'pole cap face height = '+ convertCharsToStrings(num2str(pole_cap_height*10)) + 'mm' ,...
    'pole cap material = '+ convertCharsToStrings(pole_cap_material),...
    'pole cap gap = '+ convertCharsToStrings(num2str(pole_cap_dist*10)) + ' mm'};
annotation('textbox',[.6 .7 .25 .2],'String',str,'EdgeColor','none')
