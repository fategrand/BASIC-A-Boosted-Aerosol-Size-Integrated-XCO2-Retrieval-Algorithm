clear;
close all;
clc;
DATA_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\','full_site_aggragate_data.mat'];
load(DATA_PATH);
%%
tccon_xco2=full_site_data(:,2);
del_xco2_BASIC=full_site_data(:,48)-tccon_xco2;
del_xco2_std=full_site_data(:,1)-tccon_xco2;
del_xco2_lt=full_site_data(:,42)-tccon_xco2;
del_xco2_l2run=full_site_data(:,8)-tccon_xco2;

min_xco2=min(tccon_xco2);
max_xco2=max(tccon_xco2);

data=[tccon_xco2,del_xco2_BASIC,del_xco2_l2run,del_xco2_std,del_xco2_lt];

%%
figure;
subplot(2, 1, 1); 
hold on;

sorted_data = sortrows(data, 1);

num_groups = 7;


min_conc = sorted_data(1, 1);
max_conc = sorted_data(end, 1);
edges = linspace(min_conc, max_conc, num_groups + 1);


group_idx = discretize(sorted_data(:, 1), edges);


group_labels = arrayfun(@(x) sprintf('%.0f - %.0f', edges(x), edges(x+1)), 1:num_groups, 'UniformOutput', false);


color1 = [255, 20, 0]/255; 
color2 = [0, 150, 204]/255; 
color3 = [0, 234, 234]/255; 
color4 = [10, 50, 154]/255; % 
colors = [color1; color3; color2;color4];


for j = 1:4
    x_pos = []; 
    y_data = []; 
    num_part_arr=[];

    for i = 1:num_groups
        mask = (group_idx == i);
        if sum(mask) >= 5 
            pos = i + (j-2.5)*0.12; 
            x_pos = [x_pos; repmat(pos, sum(mask), 1)]; 
            y_data = [y_data; sorted_data(mask, j + 1)]; 
        end
        num_part_arr=[num_part_arr,sum(mask)];
    end
    
    boxchart(x_pos, y_data, ...
             'BoxFaceColor', colors(j, :), 'MarkerColor', colors(j, :),'MarkerStyle','o', ...
             'MarkerSize',3,'BoxWidth', 0.10, 'WhiskerLineColor', colors(j, :), ...
             'WhiskerLineStyle', ':','BoxFaceAlpha',0.6); 
end

% 设置长宽
scale=1.2;
figureWidth=15*scale;
figureHeight=12*scale;
fontsize=12*scale;

% xlabel('XCO2 range [ppm]','Fontsize', fontsize,FontWeight='bold');
ylabel('XCO2 Bias [ppm]','Fontsize', fontsize,FontWeight='bold');

legend('BASIC', 'ST', 'L2std', 'L2lite', 'Location', 'northeast');

set(gca, 'XTick', 1:num_groups);
xticklabels(group_labels);


xlim([0.5, num_groups + 0.5]); 

yline(0, '--', 'LineWidth', 1.5, 'HandleVisibility', 'off'); 

set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);
set(gca,'XGrid','on','YGrid','on', 'LineWidth', 1, 'Fontname', 'Times New Roman');
ylim([-10,10])
hold off;
% FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\','full_site_4box_xco2_incease_order','.png'];
% saveas(gcf,FIG_PATH);
%% calculate different group's improvement

subplot(2, 1, 2); 
% set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);
hold on;
num_product=4;
product_rmse_arr=[];
for j=1:num_product
    group_rmse_arr=[];
    serial=0;
    for i=1:num_groups
        delt_arr=sorted_data(serial+1:serial+num_part_arr(i),j+1);
        serial=serial+num_part_arr(i);
        rmse=sqrt(mean(delt_arr.^2));
        group_rmse_arr=[group_rmse_arr,rmse];
    end
    product_rmse_arr=[product_rmse_arr;group_rmse_arr];
end

improve_std=(product_rmse_arr(3,:)-product_rmse_arr(1,:))./product_rmse_arr(3,:);
improve_lt=(product_rmse_arr(4,:)-product_rmse_arr(1,:))./product_rmse_arr(4,:);


for i = 1:4
    plot(1:7, product_rmse_arr(i, :), ...
        'Color', colors(i, :), ...
        'LineWidth', 2.5, ...       
        'Marker', 'o', ...          
        'MarkerSize', 8, ...        
        'MarkerFaceColor', colors(i, :), ... 
        'MarkerEdgeColor', 'none');    
end


xlabel('XCO2 range [ppm]','Fontsize', fontsize-4,FontWeight='bold');
ylabel('XCO2 RMSE [ppm]','Fontsize', fontsize-4,FontWeight='bold');

grid on;

legend('BASIC', 'ST', 'L2std', 'L2lite', 'Location', 'northeast');

xlim([0.5,7.5]);
set(gca, 'XTick', 1:7);
set(gca, 'XTickLabel', group_labels);
set(gca, 'Fontname', 'Times New Roman');
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
%              1    2    3    4    5