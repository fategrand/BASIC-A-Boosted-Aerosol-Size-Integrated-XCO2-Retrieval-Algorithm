clear;
close all;
clc;
DATA_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\','full_site_aggragate_data.mat'];
load(DATA_PATH);
%%
bc_r0=1.18e-8;
bc_sig=2.0;

du_r0=6.7e-7;
du_sig=2.0;

oc_r0=2.12e-8;
oc_sig=2.2;

so_r0=6.95e-8;
so_sig=2.03;

ss_r0=6.95e-7;
ss_sig=2.03;

water_r0=1.0e-6;
water_sig=0.275;

%%
du_data=[];
ss_data=[];
water_data=[];

bc_data=[];
so_data=[];
oc_data=[];

ss_r_arr=[];
for i=1:numel(full_site_data(:,1))
    aerosol_type=full_site_data(i,9);
    r=full_site_data(i,16);
    sig=full_site_data(i,17);
    if aerosol_type==1
        dif_r0=-(bc_r0-r);
        dif_sig=-(bc_sig-sig);
        temp_row=[aerosol_type,dif_r0,dif_sig];
        bc_data=[bc_data;temp_row];
    end
    if aerosol_type==2
        dif_r0=-(du_r0-r);
        dif_sig=-(du_sig-sig);
        temp_row=[aerosol_type,dif_r0,dif_sig];
        du_data=[du_data;temp_row];
    end
    if aerosol_type==3
        dif_r0=-(oc_r0-r);
        dif_sig=-(oc_sig-sig);
        temp_row=[aerosol_type,dif_r0,dif_sig];
        oc_data=[oc_data;temp_row];
    end
    if aerosol_type==4
        dif_r0=-(so_r0-r);
        dif_sig=-(so_sig-sig);
        temp_row=[aerosol_type,dif_r0,dif_sig];
        so_data=[so_data;temp_row];
    end
    if aerosol_type==5
        dif_r0=-(ss_r0-r);
        dif_sig=-(ss_sig-sig);
        ss_r_arr=[ss_r_arr;r];
        temp_row=[aerosol_type,dif_r0,dif_sig];
        ss_data=[ss_data;temp_row];
    end
    if aerosol_type==6
        dif_r0=-(water_r0-r);
        dif_sig=-(water_sig-sig);
        temp_row=[aerosol_type,dif_r0,dif_sig];
        water_data=[water_data;temp_row];
    end
end

data=[bc_data;du_data;oc_data;so_data;ss_data;water_data];
coarse_data=[du_data;ss_data;water_data];
fine_data=[bc_data;oc_data;so_data];
for i=1:numel(coarse_data(:,1))
    type=coarse_data(i,1);
    switch type
        case 2
            coarse_data(i,1)=1;
        case 5
            coarse_data(i,1)=2;
        case 6
            coarse_data(i,1)=3;
    end
end
for i=1:numel(fine_data(:,1))
    type=fine_data(i,1);
    switch type
        case 1
            fine_data(i,1)=1;
        case 3
            fine_data(i,1)=2;
        case 4
            fine_data(i,1)=3;
    end
end
%% %%%%%%%%%%%%%%%%%%%%%%%%%coarse aerosol radius

unique_types = unique(coarse_data(:, 1));
num_types = length(unique_types);

% define aerosol type
aerosol_names = {
    1, 'Dust';
    2, 'Sea Salt';
    3, 'Water Cloud';
    
};

% color index
color_idx=[2,5,6];

% set spacing
spacing = 3;       
scale_factor = 0.8; 
fill_alpha = 0.6;  

figure;
hold on;

colors = lines(6);

% draw each aerosols psd
for i = 1:num_types
    current_type = unique_types(i);

    radius_deviations = coarse_data(coarse_data(:, 1) == current_type, 2);
    
    [f, xi] = ksdensity(radius_deviations);
    
    f_normalized = (f - min(f)) / (max(f) - min(f));
    f_scaled = scale_factor * f_normalized; 
    
    x_center = current_type * spacing;
    
    x_left = x_center - f_scaled;  
    x_right = x_center + f_scaled; 
    
    fill_x = [x_left, fliplr(x_right)];
    fill_y = [xi, fliplr(xi)];
    
    name_idx = find(cell2mat(aerosol_names(:, 1)) == current_type);
    type_name = aerosol_names{name_idx, 2};
    
    fill(fill_x, fill_y, colors(color_idx(i), :), ...
         'FaceAlpha', fill_alpha, 'EdgeColor', 'none', ...
         'DisplayName', type_name); 
    
    plot(x_left, xi, 'Color', colors(color_idx(i), :), 'LineWidth', 1.5, ...
         'HandleVisibility', 'off'); 
    plot(x_right, xi, 'Color', colors(color_idx(i), :), 'LineWidth', 1.5, ...
         'HandleVisibility', 'off'); 
end

scale=1.2;
figureWidth=12*scale;
figureHeight=12*scale;
fontsize=12*scale;

xticks(unique_types * spacing); 
xtick_labels = arrayfun(@(x) aerosol_names{find(cell2mat(aerosol_names(:, 1)) == x), 2}, unique_types, 'UniformOutput', false);
xticklabels(xtick_labels);
ylabel('Modal Radius Deviation [m]');
title('Coarse Aerosol Radius Parameter');


ylim([-2e-8,8e-8])

set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);
set(gca,'XGrid','on','YGrid','on', 'LineWidth', 1, 'Fontname', 'Times New Roman','FontSize',fontsize);
hold off;

% FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\aerosol_size_distribution\prob_distribution\','coarse_aerosol_radius','.png'];
% saveas(gcf,FIG_PATH);
%% %%%%%%%%%%%%%%%%%%%fine aerosol radius

unique_types = unique(fine_data(:, 1));
num_types = length(unique_types);

aerosol_names = {
    1, 'Black Carbon';
    2, 'Organic Carbon';
    3, 'Sulfate';
    
};

color_idx=[1,3,4];

spacing = 3;       
scale_factor = 0.8; 
fill_alpha = 0.6;  

figure;
hold on;

colors = lines(6);

for i = 1:num_types
    current_type = unique_types(i);
    radius_deviations = fine_data(fine_data(:, 1) == current_type, 2);
    
    [f, xi] = ksdensity(radius_deviations);
    
    f_normalized = (f - min(f)) / (max(f) - min(f));
    f_scaled = scale_factor * f_normalized; 
    
    x_center = current_type * spacing;
    
    x_left = x_center - f_scaled;  
    x_right = x_center + f_scaled; 
    
    fill_x = [x_left, fliplr(x_right)];
    fill_y = [xi, fliplr(xi)];
    
    name_idx = find(cell2mat(aerosol_names(:, 1)) == current_type);
    type_name = aerosol_names{name_idx, 2};
    

    fill(fill_x, fill_y, colors(color_idx(i), :), ...
         'FaceAlpha', fill_alpha, 'EdgeColor', 'none', ...
         'DisplayName', type_name);
    
    plot(x_left, xi, 'Color', colors(color_idx(i), :), 'LineWidth', 1.5, ...
         'HandleVisibility', 'off'); 
    plot(x_right, xi, 'Color', colors(color_idx(i), :), 'LineWidth', 1.5, ...
         'HandleVisibility', 'off'); 
end


scale=1.2;
figureWidth=12*scale/0.9;
figureHeight=12*scale;
fontsize=12*scale;

xticks(unique_types * spacing); 
xtick_labels = arrayfun(@(x) aerosol_names{find(cell2mat(aerosol_names(:, 1)) == x), 2}, unique_types, 'UniformOutput', false);
xticklabels(xtick_labels);
ylabel('Modal Radius Deviation [m]');
title('Fine Aerosol Radius Parameter');

ax = gca;                      
ax.YAxisLocation = 'right';    


ax.YLabel.Rotation = 270;      
ax.YLabel.HorizontalAlignment = 'center'; 

ylabelHandle = ax.YLabel;

labelPos = ylabelHandle.Position;
labelPos(1) = labelPos(1) + 0.8; 
ylabelHandle.Position = labelPos; 

ax.Position(3) = ax.Position(3) * 0.90; 

hold off;


set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);
set(gca,'XGrid','on','YGrid','on', 'LineWidth', 1, 'Fontname', 'Times New Roman','FontSize',fontsize);


FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\aerosol_size_distribution\prob_distribution\','fine_aerosol_radius','.png'];
saveas(gcf,FIG_PATH);
%% aerosol sigma parameter


unique_types = unique(data(:, 1));
num_types = length(unique_types);

aerosol_names = {
    1, 'Black Carbon';
    2, 'Dust';
    3, 'Organic Carbon';
    4, 'Sulfate';
    5, 'Sea Salt';
    6, 'Water Cloud';
    
};

spacing = 3;       
scale_factor = 0.8; 
fill_alpha = 0.6;  

figure;
hold on;

colors = lines(num_types);

for i = 1:num_types
    current_type = unique_types(i);

    radius_deviations = data(data(:, 1) == current_type, 3);
    
    [f, xi] = ksdensity(radius_deviations);
    
    f_normalized = (f - min(f)) / (max(f) - min(f));
    f_scaled = scale_factor * f_normalized; 
    
    x_center = current_type * spacing;
    
    x_left = x_center - f_scaled;  
    x_right = x_center + f_scaled; 
    
    fill_x = [x_left, fliplr(x_right)];
    fill_y = [xi, fliplr(xi)];
    
    name_idx = find(cell2mat(aerosol_names(:, 1)) == current_type);
    type_name = aerosol_names{name_idx, 2};
    
    fill(fill_x, fill_y, colors(i, :), ...
         'FaceAlpha', fill_alpha, 'EdgeColor', 'none', ...
         'DisplayName', type_name); 
    
    plot(x_left, xi, 'Color', colors(i, :), 'LineWidth', 1.5, ...
         'HandleVisibility', 'off'); 
    plot(x_right, xi, 'Color', colors(i, :), 'LineWidth', 1.5, ...
         'HandleVisibility', 'off'); 
end

scale=1.2;
figureWidth=24*scale;
figureHeight=12*scale;
fontsize=12*scale;

xticks(unique_types * spacing); 
xtick_labels = arrayfun(@(x) aerosol_names{find(cell2mat(aerosol_names(:, 1)) == x), 2}, unique_types, 'UniformOutput', false);
xticklabels(xtick_labels);

ylabel('Sigma Deviation');

legend('Location', 'southeast');

title('Aerosol Sigma Parameter');

set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);
set(gca,'XGrid','on','YGrid','on', 'LineWidth', 1, 'Fontname', 'Times New Roman','FontSize',fontsize);

hold off;
% FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\aerosol_size_distribution\prob_distribution\','aerosol_sigma','.png'];
% saveas(gcf,FIG_PATH);
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