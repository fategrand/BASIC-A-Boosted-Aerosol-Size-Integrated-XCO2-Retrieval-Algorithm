clear;
close all;
clc;
d_start='2019';
d_end='2021';
tccon_name='XH';

DATA_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\',tccon_name,'\aggragate_data\',d_start,'_to_',d_end,'_Data_l2std_tccon.mat'];
data_xh=load(DATA_PATH);

d_start='2018';
d_end='2021';
tccon_name='JS';

DATA_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\',tccon_name,'\aggragate_data\',d_start,'_to_',d_end,'_Data_l2std_tccon.mat'];
data_js=load(DATA_PATH);

d_start='2020';
d_end='2022';
tccon_name='HF';

DATA_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\',tccon_name,'\aggragate_data\',d_start,'_to_',d_end,'_Data_l2std_tccon.mat'];
data_hf=load(DATA_PATH);

xh_site_data=data_xh.aggragate_data;
hf_site_data=data_hf.aggragate_data;
js_site_data=data_js.aggragate_data;
full_site_data=[data_xh.aggragate_data;data_js.aggragate_data;data_hf.aggragate_data];

AEROSOL_DATA_PATH='D:\Data\static_aerosol_file\origin_aerosol_file\l2_aerosol_combined.h5';
[data_strat,data_ice,data_water,data_so,data_du,data_ss,data_bc,data_oc] = os.F_ReadStaticAerosolParam(AEROSOL_DATA_PATH);

wl_mat=zeros(6,10);
for i=1:10
    temp_wl=[6.0;5.0;4.0;3.0;2.0;1.0];
    wl_mat(:,i)=temp_wl;
end

color = [0.4,0.4,0.4];
fill_color={color,color,color};
color1 = [255, 20, 0]/255;
color2 = [0, 150, 204]/255; 

%% case HF 
tccon_name='HF';
month='202106';
ext_arr=[];
scat_arr=[];
sounding_arr=[];

site_data=full_site_data(321:470,:);
for i=1:numel(site_data(:,1))
    month_num=site_data(i,7);
    temp_ext=site_data(i,18:23);
    temp_scat=site_data(i,24:29);
    if month_num==str2double(month)
        ext_arr=[ext_arr;temp_ext];
        scat_arr=[scat_arr;temp_scat];
        sounding_arr=[sounding_arr,site_data(i,6)];
    end
end

% input L2lt file
L2FILE_DIR=['D:\Data\TCCON_ND_data\TCCON_matched_L1data\',tccon_name,'\',month(1:4),'\'];
[l2_paths,l2_names,l2_sum]=os.F_GetDirPath(L2FILE_DIR,'*.nc4');
for j=1:l2_sum
    if l2_names{j}(12:15)==month(3:6)
        data_l2lt=os.F_ReadL2liteParam(l2_paths{j},month(3:6));
        break
    end
end
aod_arr=[];
for i=1:numel(sounding_arr)
    sounding_id=sounding_arr(i);
    idx=find(data_l2lt.sounding_id==sounding_id);
    ice_aod=data_l2lt.ice(idx);
    water_aod=data_l2lt.water(idx);
    strat_aod=data_l2lt.strataer(idx);
    du_aod=data_l2lt.du(idx);
    so_aod=data_l2lt.so(idx);
    ss_aod=data_l2lt.ss(idx);
    bc_aod=data_l2lt.bc(idx);
    oc_aod=data_l2lt.oc(idx);
    total_aod=data_l2lt.total_aod(idx);
    temp_arr=[ice_aod,water_aod,strat_aod,du_aod,so_aod,ss_aod,bc_aod,oc_aod,total_aod];
    aod_arr=[aod_arr;temp_arr];
end

origin_ext_arr=[];
origin_scat_arr=[];
for i=1:numel(sounding_arr)
    ice_ext=data_ice.extinction'*(aod_arr(i,1)/aod_arr(i,9));
    water_ext=data_water.extinction'*(aod_arr(i,2)/aod_arr(i,9));
    strat_ext=data_strat.extinction'*(aod_arr(i,3)/aod_arr(i,9));
    du_ext=data_du.extinction'*(aod_arr(i,4)/aod_arr(i,9));
    so_ext=data_so.extinction'*(aod_arr(i,5)/aod_arr(i,9));
    ss_ext=data_ss.extinction'*(aod_arr(i,6)/aod_arr(i,9));
    bc_ext=data_bc.extinction'*(aod_arr(i,7)/aod_arr(i,9));
    oc_ext=data_oc.extinction'*(aod_arr(i,8)/aod_arr(i,9));
    temp_ext=ice_ext+water_ext+strat_ext+du_ext+so_ext+ss_ext+bc_ext+oc_ext;
    origin_ext_arr=[origin_ext_arr;temp_ext];

    ice_scat=data_ice.scatter'*(aod_arr(i,1)/aod_arr(i,9));
    water_scat=data_water.scatter'*(aod_arr(i,2)/aod_arr(i,9));
    strat_scat=data_strat.scatter'*(aod_arr(i,3)/aod_arr(i,9));
    du_scat=data_du.scatter'*(aod_arr(i,4)/aod_arr(i,9));
    so_scat=data_so.scatter'*(aod_arr(i,5)/aod_arr(i,9));
    ss_scat=data_ss.scatter'*(aod_arr(i,6)/aod_arr(i,9));
    bc_scat=data_bc.scatter'*(aod_arr(i,7)/aod_arr(i,9));
    oc_scat=data_oc.scatter'*(aod_arr(i,8)/aod_arr(i,9));
    temp_scat=ice_ext+water_ext+strat_ext+du_ext+so_ext+ss_ext+bc_ext+oc_ext;
    origin_scat_arr=[origin_scat_arr;temp_scat];
end

figure();
x_min=min(wl_mat(6,1));
x_max=max(wl_mat(1,1));
p1=plot(wl_mat,origin_scat_arr',LineWidth=1.2,Color=color2);
hold on;
p2=plot(wl_mat,scat_arr',LineWidth=2.0,Color=color1);
legend([p1(1),p2(1)],{'ACOS result','BASIC result'},FontSize=14,FontWeight="bold");
xlim([x_min,x_max]);
ylabel('Mass Scattering Coefficient (m^2/kg)',FontWeight='bold')
title(['2021-06 Case'],FontSize=18,FontWeight="bold")

% define filled area parameter
regions = [1 2; 3 4; 5 6];
y_limits = ylim; 
alpha_value = 0.3; 

% fill each area
for i = 1:size(regions, 1)
    x1 = regions(i, 1);
    x2 = regions(i, 2);
    X = [x1, x2, x2, x1]; % 四边形的x坐标
    Y = [y_limits(1), y_limits(1), y_limits(2), y_limits(2)]; % y坐标
    fill(X, Y, fill_color{i}, 'FaceAlpha', alpha_value, 'EdgeColor', 'none',HandleVisibility='off');
end

xticks([1,2,3,4,5,6]);
xtick_labels={'OA_1','OA_2','WC_1','WC_2','SC_1','SC_2'};
xticklabels(xtick_labels);

ax = gca;

% set font
ax.XAxis.FontSize = 11;      
ax.XAxis.FontWeight = 'bold'; 
ax.YAxis.FontSize = 10;      
ax.YAxis.FontWeight = 'bold'; 
ax.YLabel.FontSize = 12;

% set scale
scale=1.2;
figureWidth=12*scale;
figureHeight=9*scale;
set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);
% set(gca,'XGrid','on','YGrid','on');

FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\evaluation\spec_cost_analyse\scatter_analyse\',tccon_name,'_site_',month,'_big_diff','.png'];
saveas(gcf,FIG_PATH);

% mean_origin_scat=mean(origin_scat_arr,1);
% mean_scat=mean(scat_arr);
% mean_origin_scat_oa=mean(mean_origin_scat(5:6));
% mean_scat_oa=mean(mean_scat(5:6));
% diff=mean_origin_scat_oa/mean_scat_oa
%% case HF large error
tccon_name='HF';
month='202109';
ext_arr=[];
scat_arr=[];
sounding_arr=[];

site_data=hf_site_data;
for i=1:numel(site_data(:,1))
    month_num=site_data(i,7);
    temp_ext=site_data(i,18:23);
    temp_scat=site_data(i,24:29);
    if month_num==str2double(month)
        ext_arr=[ext_arr;temp_ext];
        scat_arr=[scat_arr;temp_scat];
        sounding_arr=[sounding_arr,site_data(i,6)];
    end
end

% 对应的L2lt文件
L2FILE_DIR=['D:\Data\TCCON_ND_data\TCCON_matched_L1data\',tccon_name,'\',month(1:4),'\'];
[l2_paths,l2_names,l2_sum]=os.F_GetDirPath(L2FILE_DIR,'*.nc4');
for j=1:l2_sum
    if l2_names{j}(12:15)==month(3:6)
        data_l2lt=os.F_ReadL2liteParam(l2_paths{j},month(3:6));
        break
    end
end
aod_arr=[];
for i=1:numel(sounding_arr)
    sounding_id=sounding_arr(i);
    idx=find(data_l2lt.sounding_id==sounding_id);
    ice_aod=data_l2lt.ice(idx);
    water_aod=data_l2lt.water(idx);
    strat_aod=data_l2lt.strataer(idx);
    du_aod=data_l2lt.du(idx);
    so_aod=data_l2lt.so(idx);
    ss_aod=data_l2lt.ss(idx);
    bc_aod=data_l2lt.bc(idx);
    oc_aod=data_l2lt.oc(idx);
    total_aod=data_l2lt.total_aod(idx);
    temp_arr=[ice_aod,water_aod,strat_aod,du_aod,so_aod,ss_aod,bc_aod,oc_aod,total_aod];
    aod_arr=[aod_arr;temp_arr];
end

origin_ext_arr=[];
origin_scat_arr=[];
for i=1:numel(sounding_arr)
    ice_ext=data_ice.extinction'*(aod_arr(i,1)/aod_arr(i,9));
    water_ext=data_water.extinction'*(aod_arr(i,2)/aod_arr(i,9));
    strat_ext=data_strat.extinction'*(aod_arr(i,3)/aod_arr(i,9));
    du_ext=data_du.extinction'*(aod_arr(i,4)/aod_arr(i,9));
    so_ext=data_so.extinction'*(aod_arr(i,5)/aod_arr(i,9));
    ss_ext=data_ss.extinction'*(aod_arr(i,6)/aod_arr(i,9));
    bc_ext=data_bc.extinction'*(aod_arr(i,7)/aod_arr(i,9));
    oc_ext=data_oc.extinction'*(aod_arr(i,8)/aod_arr(i,9));
    temp_ext=ice_ext+water_ext+strat_ext+du_ext+so_ext+ss_ext+bc_ext+oc_ext;
    origin_ext_arr=[origin_ext_arr;temp_ext];

    ice_scat=data_ice.scatter'*(aod_arr(i,1)/aod_arr(i,9));
    water_scat=data_water.scatter'*(aod_arr(i,2)/aod_arr(i,9));
    strat_scat=data_strat.scatter'*(aod_arr(i,3)/aod_arr(i,9));
    du_scat=data_du.scatter'*(aod_arr(i,4)/aod_arr(i,9));
    so_scat=data_so.scatter'*(aod_arr(i,5)/aod_arr(i,9));
    ss_scat=data_ss.scatter'*(aod_arr(i,6)/aod_arr(i,9));
    bc_scat=data_bc.scatter'*(aod_arr(i,7)/aod_arr(i,9));
    oc_scat=data_oc.scatter'*(aod_arr(i,8)/aod_arr(i,9));
    temp_scat=ice_ext+water_ext+strat_ext+du_ext+so_ext+ss_ext+bc_ext+oc_ext;
    origin_scat_arr=[origin_scat_arr;temp_scat];
end


figure();
x_min=min(wl_mat(6,1));
x_max=max(wl_mat(1,1));
p1=plot(wl_mat,origin_scat_arr',LineWidth=1.2,Color=color2);
hold on;
p2=plot(wl_mat,scat_arr',LineWidth=1.2,Color=color1);
legend([p1(1),p2(1)],{'ACOS result','BASIC result'},FontSize=14,FontWeight="bold");
xlim([x_min,x_max]);

ylabel('Mass Scattering Coefficient (m^2/kg)',FontWeight='bold');
title(['2021-09 Case'],FontSize=18,FontWeight="bold")


regions = [1 2; 3 4; 5 6];
y_limits = ylim; 
alpha_value = 0.3; 


for i = 1:size(regions, 1)
    x1 = regions(i, 1);
    x2 = regions(i, 2);
    X = [x1, x2, x2, x1]; 
    Y = [y_limits(1), y_limits(1), y_limits(2), y_limits(2)]; 
    fill(X, Y, fill_color{i}, 'FaceAlpha', alpha_value, 'EdgeColor', 'none',HandleVisibility='off');
end

xticks([1,2,3,4,5,6]);
xtick_labels={'OA_1','OA_2','WC_1','WC_2','SC_1','SC_2'};
xticklabels(xtick_labels);

ax = gca;


ax.XAxis.FontSize = 11;      % 字体大小
ax.XAxis.FontWeight = 'bold'; % 字体粗细（'normal' 或 'bold'）
ax.YAxis.FontSize = 10;      % 字体大小
ax.YAxis.FontWeight = 'bold'; % 字体粗细（'normal' 或 'bold'）
ax.YLabel.FontSize = 12;

scale=1.2;
figureWidth=12*scale;
figureHeight=9*scale;
set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);

FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\evaluation\spec_cost_analyse\scatter_analyse\',tccon_name,'_site_',month,'_small_diff','.png'];
saveas(gcf,FIG_PATH);

% mean_origin_scat=mean(origin_scat_arr,1);
% mean_scat=mean(scat_arr);
% mean_origin_scat_oa=mean(mean_origin_scat(5:6));
% mean_scat_oa=mean(mean_scat(5:6));
% diff=mean_origin_scat_oa/mean_scat_oa

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% case XH large error
tccon_name='XH';
month='202111';
ext_arr=[];
scat_arr=[];
sounding_arr=[];
for i=1:numel(xh_site_data(:,1))
    month_num=xh_site_data(i,7);
    temp_ext=xh_site_data(i,18:23);
    temp_scat=xh_site_data(i,24:29);
    if month_num==str2double(month)
        ext_arr=[ext_arr;temp_ext];
        scat_arr=[scat_arr;temp_scat];
        sounding_arr=[sounding_arr,xh_site_data(i,6)];
    end
end


L2FILE_DIR=['D:\Data\TCCON_ND_data\TCCON_matched_L1data\',tccon_name,'\',month(1:4),'\'];
[l2_paths,l2_names,l2_sum]=os.F_GetDirPath(L2FILE_DIR,'*.nc4');
for j=1:l2_sum
    if l2_names{j}(12:15)==month(3:6)
        data_l2lt=os.F_ReadL2liteParam(l2_paths{j},month(3:6));
        break
    end
end
aod_arr=[];
for i=1:numel(sounding_arr)
    sounding_id=sounding_arr(i);
    idx=find(data_l2lt.sounding_id==sounding_id);
    ice_aod=data_l2lt.ice(idx);
    water_aod=data_l2lt.water(idx);
    strat_aod=data_l2lt.strataer(idx);
    du_aod=data_l2lt.du(idx);
    so_aod=data_l2lt.so(idx);
    ss_aod=data_l2lt.ss(idx);
    bc_aod=data_l2lt.bc(idx);
    oc_aod=data_l2lt.oc(idx);
    total_aod=data_l2lt.total_aod(idx);
    temp_arr=[ice_aod,water_aod,strat_aod,du_aod,so_aod,ss_aod,bc_aod,oc_aod,total_aod];
    aod_arr=[aod_arr;temp_arr];
end


origin_ext_arr=[];
origin_scat_arr=[];
for i=1:numel(sounding_arr)
    ice_ext=data_ice.extinction'*(aod_arr(i,1)/aod_arr(i,9));
    water_ext=data_water.extinction'*(aod_arr(i,2)/aod_arr(i,9));
    strat_ext=data_strat.extinction'*(aod_arr(i,3)/aod_arr(i,9));
    du_ext=data_du.extinction'*(aod_arr(i,4)/aod_arr(i,9));
    so_ext=data_so.extinction'*(aod_arr(i,5)/aod_arr(i,9));
    ss_ext=data_ss.extinction'*(aod_arr(i,6)/aod_arr(i,9));
    bc_ext=data_bc.extinction'*(aod_arr(i,7)/aod_arr(i,9));
    oc_ext=data_oc.extinction'*(aod_arr(i,8)/aod_arr(i,9));
    temp_ext=ice_ext+water_ext+strat_ext+du_ext+so_ext+ss_ext+bc_ext+oc_ext;
    origin_ext_arr=[origin_ext_arr;temp_ext];

    ice_scat=data_ice.scatter'*(aod_arr(i,1)/aod_arr(i,9));
    water_scat=data_water.scatter'*(aod_arr(i,2)/aod_arr(i,9));
    strat_scat=data_strat.scatter'*(aod_arr(i,3)/aod_arr(i,9));
    du_scat=data_du.scatter'*(aod_arr(i,4)/aod_arr(i,9));
    so_scat=data_so.scatter'*(aod_arr(i,5)/aod_arr(i,9));
    ss_scat=data_ss.scatter'*(aod_arr(i,6)/aod_arr(i,9));
    bc_scat=data_bc.scatter'*(aod_arr(i,7)/aod_arr(i,9));
    oc_scat=data_oc.scatter'*(aod_arr(i,8)/aod_arr(i,9));
    temp_scat=ice_ext+water_ext+strat_ext+du_ext+so_ext+ss_ext+bc_ext+oc_ext;
    origin_scat_arr=[origin_scat_arr;temp_scat];
end


figure();
x_min=min(wl_mat(6,1));
x_max=max(wl_mat(1,1));
p1=plot(wl_mat,origin_scat_arr',LineWidth=1.2,Color=color2);
hold on;
p2=plot(wl_mat,scat_arr',LineWidth=1.2,Color=color1);
% legend([p1(1),p2(1)],{'ACOS result','BASIC result'});
xlim([x_min,x_max]);

ylabel('Mass Scattering Coefficient (m^2/kg)',FontWeight='bold')
title(['2021-11 Case'],FontSize=18,FontWeight="bold")


regions = [1 2; 3 4; 5 6];
y_limits = ylim; 
alpha_value = 0.3; 

for i = 1:size(regions, 1)
    x1 = regions(i, 1);
    x2 = regions(i, 2);
    X = [x1, x2, x2, x1];
    Y = [y_limits(1), y_limits(1), y_limits(2), y_limits(2)]; 
    fill(X, Y, fill_color{i}, 'FaceAlpha', alpha_value, 'EdgeColor', 'none',HandleVisibility='off');
end

xticks([1,2,3,4,5,6]);
xtick_labels={'OA_1','OA_2','WC_1','WC_2','SC_1','SC_2'};
xticklabels(xtick_labels);

ax = gca;

ax.XAxis.FontSize = 11;      
ax.XAxis.FontWeight = 'bold'; 
ax.YAxis.FontSize = 10;      
ax.YAxis.FontWeight = 'bold'; 
ax.YLabel.FontSize = 12;

scale=1.2;
figureWidth=12*scale;
figureHeight=9*scale;
set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);

FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\evaluation\spec_cost_analyse\scatter_analyse\',tccon_name,'_site_',month,'_big_diff','.png'];
saveas(gcf,FIG_PATH);

%% case XH minor error
tccon_name='XH';
month='202001';
ext_arr=[];
scat_arr=[];

sounding_arr=[];
for i=1:numel(xh_site_data(:,1))
    month_num=xh_site_data(i,7);
    temp_ext=xh_site_data(i,18:23);
    temp_scat=xh_site_data(i,24:29);
    if month_num==str2double(month)
        ext_arr=[ext_arr;temp_ext];
        scat_arr=[scat_arr;temp_scat];
        sounding_arr=[sounding_arr,xh_site_data(i,6)];
    end
end

const=2.0;
ext_arr=ext_arr.*const;
scat_arr=scat_arr.*const;

% 对应的L2lt文件
L2FILE_DIR=['D:\Data\TCCON_ND_data\TCCON_matched_L1data\',tccon_name,'\',month(1:4),'\'];
[l2_paths,l2_names,l2_sum]=os.F_GetDirPath(L2FILE_DIR,'*.nc4');
for j=1:l2_sum
    if l2_names{j}(12:15)==month(3:6)
        data_l2lt=os.F_ReadL2liteParam(l2_paths{j},month(3:6));
        break
    end
end
aod_arr=[];
for i=1:numel(sounding_arr)
    sounding_id=sounding_arr(i);
    idx=find(data_l2lt.sounding_id==sounding_id);
    ice_aod=data_l2lt.ice(idx);
    water_aod=data_l2lt.water(idx);
    strat_aod=data_l2lt.strataer(idx);
    du_aod=data_l2lt.du(idx);
    so_aod=data_l2lt.so(idx);
    ss_aod=data_l2lt.ss(idx);
    bc_aod=data_l2lt.bc(idx);
    oc_aod=data_l2lt.oc(idx);
    total_aod=data_l2lt.total_aod(idx);
    temp_arr=[ice_aod,water_aod,strat_aod,du_aod,so_aod,ss_aod,bc_aod,oc_aod,total_aod];
    aod_arr=[aod_arr;temp_arr];
end

origin_ext_arr=[];
origin_scat_arr=[];
for i=1:numel(sounding_arr)
    ice_ext=data_ice.extinction'*(aod_arr(i,1)/aod_arr(i,9));
    water_ext=data_water.extinction'*(aod_arr(i,2)/aod_arr(i,9));
    strat_ext=data_strat.extinction'*(aod_arr(i,3)/aod_arr(i,9));
    du_ext=data_du.extinction'*(aod_arr(i,4)/aod_arr(i,9));
    so_ext=data_so.extinction'*(aod_arr(i,5)/aod_arr(i,9));
    ss_ext=data_ss.extinction'*(aod_arr(i,6)/aod_arr(i,9));
    bc_ext=data_bc.extinction'*(aod_arr(i,7)/aod_arr(i,9));
    oc_ext=data_oc.extinction'*(aod_arr(i,8)/aod_arr(i,9));
    temp_ext=ice_ext+water_ext+strat_ext+du_ext+so_ext+ss_ext+bc_ext+oc_ext;
    origin_ext_arr=[origin_ext_arr;temp_ext];

    ice_scat=data_ice.scatter'*(aod_arr(i,1)/aod_arr(i,9));
    water_scat=data_water.scatter'*(aod_arr(i,2)/aod_arr(i,9));
    strat_scat=data_strat.scatter'*(aod_arr(i,3)/aod_arr(i,9));
    du_scat=data_du.scatter'*(aod_arr(i,4)/aod_arr(i,9));
    so_scat=data_so.scatter'*(aod_arr(i,5)/aod_arr(i,9));
    ss_scat=data_ss.scatter'*(aod_arr(i,6)/aod_arr(i,9));
    bc_scat=data_bc.scatter'*(aod_arr(i,7)/aod_arr(i,9));
    oc_scat=data_oc.scatter'*(aod_arr(i,8)/aod_arr(i,9));
    temp_scat=ice_ext+water_ext+strat_ext+du_ext+so_ext+ss_ext+bc_ext+oc_ext;
    origin_scat_arr=[origin_scat_arr;temp_scat];
end


figure();
x_min=min(wl_mat(6,1));
x_max=max(wl_mat(1,1));
p1=plot(wl_mat,origin_scat_arr',LineWidth=1.2,Color=color2);
hold on;
p2=plot(wl_mat,scat_arr',LineWidth=1.2,Color=color1);
% legend([p1(1),p2(1)],{'ACOS result','BASIC result'});
xlim([x_min,x_max]);

ylabel('Mass Scattering Coefficient (m^2/kg)',FontWeight='bold')
title(['2020-01 Case'],FontSize=18,FontWeight="bold")

regions = [1 2; 3 4; 5 6];
y_limits = ylim; 
alpha_value = 0.3; 


for i = 1:size(regions, 1)
    x1 = regions(i, 1);
    x2 = regions(i, 2);
    X = [x1, x2, x2, x1]; 
    Y = [y_limits(1), y_limits(1), y_limits(2), y_limits(2)]; 
    fill(X, Y, fill_color{i}, 'FaceAlpha', alpha_value, 'EdgeColor', 'none',HandleVisibility='off');
end

xticks([1,2,3,4,5,6]);
xtick_labels={'OA_1','OA_2','WC_1','WC_2','SC_1','SC_2'};
xticklabels(xtick_labels);

ax = gca;
% 设置x轴刻度标签的字体大小和粗细
ax.XAxis.FontSize = 11;      % 字体大小
ax.XAxis.FontWeight = 'bold'; % 字体粗细（'normal' 或 'bold'）
ax.YAxis.FontSize = 10;      % 字体大小
ax.YAxis.FontWeight = 'bold'; % 字体粗细（'normal' 或 'bold'）
ax.YLabel.FontSize = 12;

% 设置长宽
scale=1.2;
figureWidth=12*scale;
figureHeight=9*scale;
set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);

FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\evaluation\spec_cost_analyse\scatter_analyse\',tccon_name,'_site_',month,'_small_diff','.png'];
saveas(gcf,FIG_PATH);


%%%%%%%%%%%%%%%%%%%%% J S %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% case JS large error
tccon_name='JS';
month='202003';
ext_arr=[];
scat_arr=[];
sounding_arr=[];
for i=1:numel(js_site_data(:,1))
    month_num=js_site_data(i,7);
    temp_ext=js_site_data(i,18:23);
    temp_scat=js_site_data(i,24:29);
    if month_num==str2double(month)
        ext_arr=[ext_arr;temp_ext];
        scat_arr=[scat_arr;temp_scat];
        sounding_arr=[sounding_arr,js_site_data(i,6)];
    end
end

% 对应的L2lt文件
L2FILE_DIR=['D:\Data\TCCON_ND_data\TCCON_matched_L1data\',tccon_name,'\',month(1:4),'\'];
[l2_paths,l2_names,l2_sum]=os.F_GetDirPath(L2FILE_DIR,'*.nc4');
for j=1:l2_sum
    if l2_names{j}(12:15)==month(3:6)
        data_l2lt=os.F_ReadL2liteParam(l2_paths{j},month(3:6));
        break
    end
end
aod_arr=[];
for i=1:numel(sounding_arr)
    sounding_id=sounding_arr(i);
    idx=find(data_l2lt.sounding_id==sounding_id);
    ice_aod=data_l2lt.ice(idx);
    water_aod=data_l2lt.water(idx);
    strat_aod=data_l2lt.strataer(idx);
    du_aod=data_l2lt.du(idx);
    so_aod=data_l2lt.so(idx);
    ss_aod=data_l2lt.ss(idx);
    bc_aod=data_l2lt.bc(idx);
    oc_aod=data_l2lt.oc(idx);
    total_aod=data_l2lt.total_aod(idx);
    temp_arr=[ice_aod,water_aod,strat_aod,du_aod,so_aod,ss_aod,bc_aod,oc_aod,total_aod];
    aod_arr=[aod_arr;temp_arr];
end

origin_ext_arr=[];
origin_scat_arr=[];
for i=1:numel(sounding_arr)
    ice_ext=data_ice.extinction'*(aod_arr(i,1)/aod_arr(i,9));
    water_ext=data_water.extinction'*(aod_arr(i,2)/aod_arr(i,9));
    strat_ext=data_strat.extinction'*(aod_arr(i,3)/aod_arr(i,9));
    du_ext=data_du.extinction'*(aod_arr(i,4)/aod_arr(i,9));
    so_ext=data_so.extinction'*(aod_arr(i,5)/aod_arr(i,9));
    ss_ext=data_ss.extinction'*(aod_arr(i,6)/aod_arr(i,9));
    bc_ext=data_bc.extinction'*(aod_arr(i,7)/aod_arr(i,9));
    oc_ext=data_oc.extinction'*(aod_arr(i,8)/aod_arr(i,9));
    temp_ext=ice_ext+water_ext+strat_ext+du_ext+so_ext+ss_ext+bc_ext+oc_ext;
    origin_ext_arr=[origin_ext_arr;temp_ext];

    ice_scat=data_ice.scatter'*(aod_arr(i,1)/aod_arr(i,9));
    water_scat=data_water.scatter'*(aod_arr(i,2)/aod_arr(i,9));
    strat_scat=data_strat.scatter'*(aod_arr(i,3)/aod_arr(i,9));
    du_scat=data_du.scatter'*(aod_arr(i,4)/aod_arr(i,9));
    so_scat=data_so.scatter'*(aod_arr(i,5)/aod_arr(i,9));
    ss_scat=data_ss.scatter'*(aod_arr(i,6)/aod_arr(i,9));
    bc_scat=data_bc.scatter'*(aod_arr(i,7)/aod_arr(i,9));
    oc_scat=data_oc.scatter'*(aod_arr(i,8)/aod_arr(i,9));
    temp_scat=ice_ext+water_ext+strat_ext+du_ext+so_ext+ss_ext+bc_ext+oc_ext;
    origin_scat_arr=[origin_scat_arr;temp_scat];
end


figure();
x_min=min(wl_mat(6,1));
x_max=max(wl_mat(1,1));
p1=plot(wl_mat,origin_scat_arr',LineWidth=1.2,Color=color2);
hold on;
p2=plot(wl_mat,scat_arr',LineWidth=1.8,Color=color1);
% legend([p1(1),p2(1)],{'ACOS result','BASIC result'});
xlim([x_min,x_max]);

ylabel('Mass Scattering Coefficient (m^2/kg)',FontWeight='bold')
title(['2020-03 Case'],FontSize=18,FontWeight="bold")

regions = [1 2; 3 4; 5 6];
y_limits = ylim; 
alpha_value = 0.3; 

for i = 1:size(regions, 1)
    x1 = regions(i, 1);
    x2 = regions(i, 2);
    X = [x1, x2, x2, x1]; 
    Y = [y_limits(1), y_limits(1), y_limits(2), y_limits(2)];
    fill(X, Y, fill_color{i}, 'FaceAlpha', alpha_value, 'EdgeColor', 'none',HandleVisibility='off');
end

xticks([1,2,3,4,5,6]);
xtick_labels={'OA_1','OA_2','WC_1','WC_2','SC_1','SC_2'};
xticklabels(xtick_labels);

ax = gca;

ax.XAxis.FontSize = 11;      
ax.XAxis.FontWeight = 'bold'; 
ax.YAxis.FontSize = 10;      
ax.YAxis.FontWeight = 'bold'; 
ax.YLabel.FontSize = 12;

scale=1.2;
figureWidth=12*scale;
figureHeight=9*scale;
set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);

FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\evaluation\spec_cost_analyse\scatter_analyse\',tccon_name,'_site_',month,'_big_diff','.png'];
saveas(gcf,FIG_PATH);

%% case js large error
tccon_name='JS';
month='201802';
ext_arr=[];
scat_arr=[];
sounding_arr=[];
for i=1:numel(js_site_data(:,1))
    month_num=js_site_data(i,7);
    temp_ext=js_site_data(i,18:23);
    temp_scat=js_site_data(i,24:29);
    if month_num==str2double(month)
        ext_arr=[ext_arr;temp_ext];
        scat_arr=[scat_arr;temp_scat];
        sounding_arr=[sounding_arr,js_site_data(i,6)];
    end
end

% 对应的L2lt文件
L2FILE_DIR=['D:\Data\TCCON_ND_data\TCCON_matched_L1data\',tccon_name,'\',month(1:4),'\'];
[l2_paths,l2_names,l2_sum]=os.F_GetDirPath(L2FILE_DIR,'*.nc4');
for j=1:l2_sum
    if l2_names{j}(12:15)==month(3:6)
        data_l2lt=os.F_ReadL2liteParam(l2_paths{j},month(3:6));
        break
    end
end
aod_arr=[];
for i=1:numel(sounding_arr)
    sounding_id=sounding_arr(i);
    idx=find(data_l2lt.sounding_id==sounding_id);
    ice_aod=data_l2lt.ice(idx);
    water_aod=data_l2lt.water(idx);
    strat_aod=data_l2lt.strataer(idx);
    du_aod=data_l2lt.du(idx);
    so_aod=data_l2lt.so(idx);
    ss_aod=data_l2lt.ss(idx);
    bc_aod=data_l2lt.bc(idx);
    oc_aod=data_l2lt.oc(idx);
    total_aod=data_l2lt.total_aod(idx);
    temp_arr=[ice_aod,water_aod,strat_aod,du_aod,so_aod,ss_aod,bc_aod,oc_aod,total_aod];
    aod_arr=[aod_arr;temp_arr];
end

origin_ext_arr=[];
origin_scat_arr=[];
for i=1:numel(sounding_arr)
    ice_ext=data_ice.extinction'*(aod_arr(i,1)/aod_arr(i,9));
    water_ext=data_water.extinction'*(aod_arr(i,2)/aod_arr(i,9));
    strat_ext=data_strat.extinction'*(aod_arr(i,3)/aod_arr(i,9));
    du_ext=data_du.extinction'*(aod_arr(i,4)/aod_arr(i,9));
    so_ext=data_so.extinction'*(aod_arr(i,5)/aod_arr(i,9));
    ss_ext=data_ss.extinction'*(aod_arr(i,6)/aod_arr(i,9));
    bc_ext=data_bc.extinction'*(aod_arr(i,7)/aod_arr(i,9));
    oc_ext=data_oc.extinction'*(aod_arr(i,8)/aod_arr(i,9));
    temp_ext=ice_ext+water_ext+strat_ext+du_ext+so_ext+ss_ext+bc_ext+oc_ext;
    origin_ext_arr=[origin_ext_arr;temp_ext];

    ice_scat=data_ice.scatter'*(aod_arr(i,1)/aod_arr(i,9));
    water_scat=data_water.scatter'*(aod_arr(i,2)/aod_arr(i,9));
    strat_scat=data_strat.scatter'*(aod_arr(i,3)/aod_arr(i,9));
    du_scat=data_du.scatter'*(aod_arr(i,4)/aod_arr(i,9));
    so_scat=data_so.scatter'*(aod_arr(i,5)/aod_arr(i,9));
    ss_scat=data_ss.scatter'*(aod_arr(i,6)/aod_arr(i,9));
    bc_scat=data_bc.scatter'*(aod_arr(i,7)/aod_arr(i,9));
    oc_scat=data_oc.scatter'*(aod_arr(i,8)/aod_arr(i,9));
    temp_scat=ice_ext+water_ext+strat_ext+du_ext+so_ext+ss_ext+bc_ext+oc_ext;
    origin_scat_arr=[origin_scat_arr;temp_scat];
end


figure();
x_min=min(wl_mat(6,1));
x_max=max(wl_mat(1,1));
p1=plot(wl_mat,origin_scat_arr',LineWidth=1.2,Color=color2);
hold on;
p2=plot(wl_mat,scat_arr',LineWidth=1.2,Color=color1);
% legend([p1(1),p2(1)],{'ACOS result','BASIC result'});
xlim([x_min,x_max]);

ylabel('Mass Scattering Coefficient (m^2/kg)',FontWeight='bold')
title(['2018-02 Case'],FontSize=18,FontWeight="bold")

regions = [1 2; 3 4; 5 6];
y_limits = ylim; 
alpha_value = 0.3; 

% 填充每个区域
for i = 1:size(regions, 1)
    x1 = regions(i, 1);
    x2 = regions(i, 2);
    X = [x1, x2, x2, x1]; % 四边形的x坐标
    Y = [y_limits(1), y_limits(1), y_limits(2), y_limits(2)]; % y坐标
    fill(X, Y, fill_color{i}, 'FaceAlpha', alpha_value, 'EdgeColor', 'none',HandleVisibility='off');
end

xticks([1,2,3,4,5,6]);
xtick_labels={'OA_1','OA_2','WC_1','WC_2','SC_1','SC_2'};
xticklabels(xtick_labels);

ax = gca;

ax.XAxis.FontSize = 11;      
ax.XAxis.FontWeight = 'bold'; 
ax.YAxis.FontSize = 10;     
ax.YAxis.FontWeight = 'bold'; 
ax.YLabel.FontSize = 12;

scale=1.2;
figureWidth=12*scale;
figureHeight=9*scale;
set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);

FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\evaluation\spec_cost_analyse\scatter_analyse\',tccon_name,'_site_',month,'_small_diff','.png'];
saveas(gcf,FIG_PATH);
%% data colum name
% std_xco2 tcc_xco2 BASIC_xco2 my_flag l2_flag sounding_id month ST_xco2 aerosol_type 
%     1        2      3       4        5         6        7        8      9
% BASIC_aod  l2std_total_aod  ice_aod  wt_aod  st_aod  cloud_flag r0  sigma
%     10           11            12      13      14        15     16    17
% ext_arr  scat_arr  std_oa  std_wc  std_sc  std_spec 
%  18-23     24-29     30      31      32       33
% basic_oa  basic_wc  basic_sc  basic_spec ST_oa ST_wc ST_sc ST_spec l2lt_xco2
%   34         35       36         37        38     39     40      41        42
% coarse_aod lt_du lt_ss pred_aerosol_type tccon_code  pred_BASIC_xco2
%     43      44     45          46            47              48
% aerosol_type ('bc','du','oc','so','ss','water')
%                 1    2    3    4    5     6
% site_code ('XH','JS','HF','TK','RJ')
%              1    2    3    4    5