%% plot data site by site
clear;
close all;
clc;
tccon_name='HF';
mode='ND';
year=month(1:4);
state_size=54;
d_start='2020';
d_end='2022';
tccon_name='HF';

DATA_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\',tccon_name,'\aggragate_data\',d_start,'_to_',d_end,'_Data_l2std_tccon.mat'];
data_hf=load(DATA_PATH);
data_hf=data_hf.aggragate_data;

% HF
% month_arr={'202003','202009','202011',...
%     '202106','202107','202109','202111','202112',...
%     '202201','202203','202205','202208','202209','202210','202211'};
% aerosol_arr={'water','water','so',...
%     'ss','bc','oc','water','ss',...
%     'water','du','water','water','water','water','so'};

month_arr={'2020-03','2020-09','2020-11',...
    '2021-06','2021-07','2021-09','2021-11','2021-12',...
    '2022-01','2022-03','2022-05','2022-08','2022-09','2022-10','2022-11'};
aerosol_arr={'water','water','so',...
    'ss','bc','oc','water','ss',...
    'water','du','water','water','water','water','so'};

%%
x_BASIC_del=data_hf(:,48)-data_hf(:,2);
x_l2std_del=data_hf(:,1)-data_hf(:,2);
x_ST_del=data_hf(:,8)-data_hf(:,2);

x_BASIC_del=reshape(x_BASIC_del,10,15);
x_l2std_del=reshape(x_l2std_del,10,15);
x_ST_del=reshape(x_ST_del,10,15);

%% 3 Grouped L2std  BASIC and ST
figure();

group1 = x_BASIC_del;
group2 = x_l2std_del;
group3 = x_ST_del;

datatab = table();
datatab1 = table();
datatab2 = table();
datatab3 = table();

data = zeros(size(group1,1), 3*size(group1, 2));
data(:, 1:3:end) = group1;
data(:, 2:3:end) = group2;
data(:,3:3:end) = group3;
datatab.data = reshape(data,[],1);
datatab1.data1 = reshape(group1,[],1);
datatab2.data2 = reshape(group2,[],1);
datatab3.data3 = reshape(group3,[],1);

factors = numel(month_arr);
factor=[];
factor1=[];
factor2=[];
factor3=[];

for i=1:numel(month_arr)
    temp_factors=i*ones(3*size(group1, 1),1);
    temp_fact=i*ones(size(group1, 1),1);
    factor=[factor;temp_factors];
    factor1=[factor1;temp_fact];
    factor2=[factor2;temp_fact];
    factor3=[factor3;temp_fact];
end

groupmark1 = repmat(["BASIC"], size(group1, 1), 1);
groupmark2 = repmat(["L2std"], size(group2, 1), 1);
groupmark3 = repmat(["ST"], size(group2, 1), 1);
groupmark = repmat([groupmark1; groupmark2; groupmark3], factors, 1);
datatab.group = groupmark;

const1=1.3;
datatab.factor = const1*factor;
datatab1.factor1 = const1*factor1;
datatab2.factor2 = const1*factor2;

factor_vec = const1*unique(factor);

color1 = [255, 20, 0]/255; 
color2 = [0, 150, 204]/255; 
color3 = [0, 234, 234]/255; 
color = {color1; color2; color3};

axesbox = boxchart(datatab.factor,datatab.data,'GroupByColor',datatab.group,BoxWidth=0.8);
hold on
yline(0,'--',LineWidth=1.2);

set(axesbox, {'BoxFaceColor'}, color,{'MarkerColor'},color, 'LineWidth',1.2,{'WhiskerLineStyle'},{':';':';':'},'BoxFaceAlpha',0.6);
set(gca, 'XTick', factor_vec, 'XTickLabel', month_arr);
set(gca,'XGrid','off','YGrid','off', 'LineWidth', 1, 'Fontsize', 12,'Fontname', 'Times New Roman');
l= legend(axesbox);
xlabel('Date');
ylabel('XCO2 Error [ppm]',FontSize=14,FontWeight="bold")
title([tccon_name,' Site'],FontSize=16,FontWeight="bold");

scale=1.2;
figureWidth=18*scale;
figureHeight=9*scale;
set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);

xlim
x_axis_max=datatab1(end,2).Variables+const1;
xlim([0 x_axis_max]);
y_max=max([max(group1(:)),max(group2(:)),max(group3(:))]);
y_min=min([min(group1(:)),min(group2(:)),min(group3(:))]);
ylim([y_min y_max]);

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