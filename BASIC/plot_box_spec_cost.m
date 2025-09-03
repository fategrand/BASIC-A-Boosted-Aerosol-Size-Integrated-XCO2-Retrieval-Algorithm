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

d_start='2017';
d_end='2019';
tccon_name='TK';

DATA_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\',tccon_name,'\aggragate_data\',d_start,'_to_',d_end,'_Data_l2std_tccon.mat'];
data_tk=load(DATA_PATH);

d_start='2018';
d_end='2020';
tccon_name='RJ';

DATA_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\',tccon_name,'\aggragate_data\',d_start,'_to_',d_end,'_Data_l2std_tccon.mat'];
data_rj=load(DATA_PATH);

xh_site_data=data_xh.aggragate_data;
hf_site_data=data_hf.aggragate_data;
js_site_data=data_js.aggragate_data;
tk_site_data=data_tk.aggragate_data;
rj_site_data=data_rj.aggragate_data;

DATA_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\','full_site_aggragate_data.mat'];
load(DATA_PATH);

tccon_name='JS';



%%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% XH
tccon_name='RJ';
if tccon_name=='XH'
    month_arr={'201901','201907','201911','201912','202001','202002',...
        '202008','202010','202012','202101','202105',...
        '202106','202107','202110','202111','202112'};
    aerosol_arr={'so','water','water','so',...
        'du','oc','water','ss','so',...
        'oc','du','bc','water','bc','so','water'};
end

% JS
if tccon_name=='JS'
    month_arr={'201801','201802','201805','201807','201809',...
        '201901','201905',...
        '202003','202004','202006','202008','202010','202011','202012',...
        '202111','202112'};
    aerosol_arr={'water','water','so','water','so',...
        'water','oc',...
        'ss','bc','du','so','so','oc','water',...
        'so','water'};
end

% HF
if tccon_name=='HF'
    month_arr={'202003','202009','202011',...
    '202106','202107','202109','202111','202112',...
    '202201','202203','202205','202208','202209','202210','202211'};
    aerosol_arr={'water','water','so',...
    'ss','bc','oc','water','ss',...
    'water','du','water','water','water','water','so'};
end

% TK
if tccon_name=='TK'
    month_arr={'201707','201709','201710','201711',...
        '201806','201807','201810','201812',...
        '201901','201902','201903','201910','201911'};
    aerosol_arr={'water','du','oc','so',...
        'ss','du','water','du',...
        'oc','du','so','water','water'};
end

% RJ
if tccon_name=='RJ'
    month_arr={'201801','201803','201805','201807','201809','201811',...
        '201909','201910','201912',...
        '202002','202004','202005','202010','202012'};
    aerosol_arr={'water','so','bc','so','so','water',...
        'du','ss','water',...
        'water','du','du','water','water'};
end

const=min([numel(hf_site_data(:,1)),numel(js_site_data(:,1)),numel(xh_site_data(:,1)),numel(tk_site_data(:,1)),numel(rj_site_data(:,1))]);

xh_l2std_speccost=xh_site_data(:,33);
xh_l2std_speccost=xh_l2std_speccost(randperm(numel(xh_l2std_speccost),const));
js_l2std_speccost=js_site_data(:,33);
js_l2std_speccost=js_l2std_speccost(randperm(numel(js_l2std_speccost),const));
hf_l2std_speccost=hf_site_data(:,33);
hf_l2std_speccost=hf_l2std_speccost(randperm(numel(hf_l2std_speccost),const));
tk_l2std_speccost=tk_site_data(:,33);
tk_l2std_speccost=tk_l2std_speccost(randperm(numel(tk_l2std_speccost),const));
rj_l2std_speccost=rj_site_data(:,33);
rj_l2std_speccost=rj_l2std_speccost(randperm(numel(rj_l2std_speccost),const));

xh_basic_spec_cost=xh_site_data(:,37);
xh_basic_spec_cost=xh_basic_spec_cost(randperm(numel(xh_basic_spec_cost),const));
js_basic_spec_cost=js_site_data(:,37);
js_basic_spec_cost=js_basic_spec_cost(randperm(numel(js_basic_spec_cost),const));
hf_basic_spec_cost=hf_site_data(:,37);
hf_basic_spec_cost=hf_basic_spec_cost(randperm(numel(hf_basic_spec_cost),const));
tk_basic_spec_cost=tk_site_data(:,37);
tk_basic_spec_cost=tk_basic_spec_cost(randperm(numel(tk_basic_spec_cost),const));
rj_basic_spec_cost=rj_site_data(:,37);
rj_basic_spec_cost=rj_basic_spec_cost(randperm(numel(rj_basic_spec_cost),const));

xh_ST_spec_cost=xh_site_data(:,41);
xh_ST_spec_cost=xh_ST_spec_cost(randperm(numel(xh_ST_spec_cost),const));
js_ST_spec_cost=js_site_data(:,41);
js_ST_spec_cost=js_ST_spec_cost(randperm(numel(js_ST_spec_cost),const));
hf_ST_spec_cost=hf_site_data(:,41);
hf_ST_spec_cost=hf_ST_spec_cost(randperm(numel(hf_ST_spec_cost),const));
tk_ST_spec_cost=tk_site_data(:,41);
tk_ST_spec_cost=tk_ST_spec_cost(randperm(numel(tk_ST_spec_cost),const));
rj_ST_spec_cost=rj_site_data(:,41);
rj_ST_spec_cost=rj_ST_spec_cost(randperm(numel(rj_ST_spec_cost),const));

xh_l2std_oa_cost=xh_site_data(:,30);
xh_l2std_oa_cost=xh_l2std_oa_cost(randperm(numel(xh_l2std_oa_cost),const));
js_l2std_oa_cost=js_site_data(:,30);
js_l2std_oa_cost=js_l2std_oa_cost(randperm(numel(js_l2std_oa_cost),const));
hf_l2std_oa_cost=hf_site_data(:,30);
hf_l2std_oa_cost=hf_l2std_oa_cost(randperm(numel(hf_l2std_oa_cost),const));
tk_l2std_oa_cost=tk_site_data(:,30);
tk_l2std_oa_cost=tk_l2std_oa_cost(randperm(numel(tk_l2std_oa_cost),const));
rj_l2std_oa_cost=rj_site_data(:,30);
rj_l2std_oa_cost=rj_l2std_oa_cost(randperm(numel(rj_l2std_oa_cost),const));

xh_basic_oa_cost=xh_site_data(:,34);
xh_basic_oa_cost=xh_basic_oa_cost(randperm(numel(xh_basic_oa_cost),const));
js_basic_oa_cost=js_site_data(:,34);
js_basic_oa_cost=js_basic_oa_cost(randperm(numel(js_basic_oa_cost),const));
hf_basic_oa_cost=hf_site_data(:,34);
hf_basic_oa_cost=hf_basic_oa_cost(randperm(numel(hf_basic_oa_cost),const));
tk_basic_oa_cost=tk_site_data(:,34);
tk_basic_oa_cost=tk_basic_oa_cost(randperm(numel(tk_basic_oa_cost),const));
rj_basic_oa_cost=rj_site_data(:,34);
rj_basic_oa_cost=rj_basic_oa_cost(randperm(numel(rj_basic_oa_cost),const));

xh_ST_oa_cost=xh_site_data(:,38);
xh_ST_oa_cost=xh_ST_oa_cost(randperm(numel(xh_ST_oa_cost),const));
js_ST_oa_cost=js_site_data(:,38);
js_ST_oa_cost=js_ST_oa_cost(randperm(numel(js_ST_oa_cost),const));
hf_ST_oa_cost=hf_site_data(:,38);
hf_ST_oa_cost=hf_ST_oa_cost(randperm(numel(hf_ST_oa_cost),const));
tk_ST_oa_cost=tk_site_data(:,38);
tk_ST_oa_cost=tk_ST_oa_cost(randperm(numel(tk_ST_oa_cost),const));
rj_ST_oa_cost=rj_site_data(:,38);
rj_ST_oa_cost=rj_ST_oa_cost(randperm(numel(rj_ST_oa_cost),const));

xh_l2std_wc_cost=xh_site_data(:,31);
xh_l2std_wc_cost=xh_l2std_wc_cost(randperm(numel(xh_l2std_wc_cost),const));
js_l2std_wc_cost=js_site_data(:,31);
js_l2std_wc_cost=js_l2std_wc_cost(randperm(numel(js_l2std_wc_cost),const));
hf_l2std_wc_cost=hf_site_data(:,31);
hf_l2std_wc_cost=hf_l2std_wc_cost(randperm(numel(hf_l2std_wc_cost),const));
tk_l2std_wc_cost=tk_site_data(:,31);
tk_l2std_wc_cost=tk_l2std_wc_cost(randperm(numel(tk_l2std_wc_cost),const));
rj_l2std_wc_cost=rj_site_data(:,31);
rj_l2std_wc_cost=rj_l2std_wc_cost(randperm(numel(rj_l2std_wc_cost),const));

xh_basic_wc_cost=xh_site_data(:,35);
xh_basic_wc_cost=xh_basic_wc_cost(randperm(numel(xh_basic_wc_cost),const));
js_basic_wc_cost=js_site_data(:,35);
js_basic_wc_cost=js_basic_wc_cost(randperm(numel(js_basic_wc_cost),const));
hf_basic_wc_cost=hf_site_data(:,35);
hf_basic_wc_cost=hf_basic_wc_cost(randperm(numel(hf_basic_wc_cost),const));
tk_basic_wc_cost=tk_site_data(:,35);
tk_basic_wc_cost=tk_basic_wc_cost(randperm(numel(tk_basic_wc_cost),const));
rj_basic_wc_cost=rj_site_data(:,35);
rj_basic_wc_cost=rj_basic_wc_cost(randperm(numel(rj_basic_wc_cost),const));

xh_ST_wc_cost=xh_site_data(:,39);
xh_ST_wc_cost=xh_ST_wc_cost(randperm(numel(xh_ST_wc_cost),const));
js_ST_wc_cost=js_site_data(:,39);
js_ST_wc_cost=js_ST_wc_cost(randperm(numel(js_ST_wc_cost),const));
hf_ST_wc_cost=hf_site_data(:,39);
hf_ST_wc_cost=hf_ST_wc_cost(randperm(numel(hf_ST_wc_cost),const));
tk_ST_wc_cost=tk_site_data(:,39);
tk_ST_wc_cost=tk_ST_wc_cost(randperm(numel(tk_ST_wc_cost),const));
rj_ST_wc_cost=rj_site_data(:,39);
rj_ST_wc_cost=rj_ST_wc_cost(randperm(numel(rj_ST_wc_cost),const));

xh_l2std_sc_cost=xh_site_data(:,32);
xh_l2std_sc_cost=xh_l2std_sc_cost(randperm(numel(xh_l2std_sc_cost),const));
js_l2std_sc_cost=js_site_data(:,32);
js_l2std_sc_cost=js_l2std_sc_cost(randperm(numel(js_l2std_sc_cost),const));
hf_l2std_sc_cost=hf_site_data(:,32);
hf_l2std_sc_cost=hf_l2std_sc_cost(randperm(numel(hf_l2std_sc_cost),const));
tk_l2std_sc_cost=tk_site_data(:,32);
tk_l2std_sc_cost=tk_l2std_sc_cost(randperm(numel(tk_l2std_sc_cost),const));
rj_l2std_sc_cost=rj_site_data(:,32);
rj_l2std_sc_cost=rj_l2std_sc_cost(randperm(numel(rj_l2std_sc_cost),const));

xh_basic_sc_cost=xh_site_data(:,36);
xh_basic_sc_cost=xh_basic_sc_cost(randperm(numel(xh_basic_sc_cost),const));
js_basic_sc_cost=js_site_data(:,36);
js_basic_sc_cost=js_basic_sc_cost(randperm(numel(js_basic_sc_cost),const));
hf_basic_sc_cost=hf_site_data(:,36);
hf_basic_sc_cost=hf_basic_sc_cost(randperm(numel(hf_basic_sc_cost),const));
tk_basic_sc_cost=tk_site_data(:,36);
tk_basic_sc_cost=tk_basic_sc_cost(randperm(numel(tk_basic_sc_cost),const));
rj_basic_sc_cost=rj_site_data(:,36);
rj_basic_sc_cost=rj_basic_sc_cost(randperm(numel(rj_basic_sc_cost),const));

xh_ST_sc_cost=xh_site_data(:,39);
xh_ST_sc_cost=xh_ST_sc_cost(randperm(numel(xh_ST_sc_cost),const));
js_ST_sc_cost=js_site_data(:,39);
js_ST_sc_cost=js_ST_sc_cost(randperm(numel(js_ST_sc_cost),const));
hf_ST_sc_cost=hf_site_data(:,39);
hf_ST_sc_cost=hf_ST_sc_cost(randperm(numel(hf_basic_sc_cost),const));
tk_ST_sc_cost=tk_site_data(:,39);
tk_ST_sc_cost=tk_ST_sc_cost(randperm(numel(tk_basic_sc_cost),const));
rj_ST_sc_cost=rj_site_data(:,39);
rj_ST_sc_cost=rj_ST_sc_cost(randperm(numel(rj_basic_sc_cost),const));

tccon_arr={'XH','JS','HF','TK','RJ'};

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%site whole spec cost

figure();
group1 = [xh_basic_spec_cost,js_basic_spec_cost,hf_basic_spec_cost,tk_basic_spec_cost,rj_basic_spec_cost];
group2 = [xh_l2std_speccost,js_l2std_speccost,hf_l2std_speccost,tk_l2std_speccost,rj_l2std_speccost];
group3 = [xh_ST_spec_cost,js_ST_spec_cost,hf_ST_spec_cost,tk_ST_spec_cost,rj_ST_spec_cost];

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

factors = numel(tccon_arr);
factor=[];
factor1=[];
factor2=[];
factor3=[];

for i=1:numel(tccon_arr)
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

axesbox = boxchart(datatab.factor,datatab.data,'GroupByColor',datatab.group,BoxWidth=0.8,BoxFaceAlpha=0.6,WhiskerLineStyle='--',MarkerSize=5);
hold on

set(axesbox, {'BoxFaceColor'}, color,{'MarkerColor'},color, 'LineWidth',1.2);
set(gca, 'XTick', factor_vec, 'XTickLabel', tccon_arr);
set(gca,'XGrid','on','YGrid','on', 'LineWidth', 1, 'Fontsize', 14,'Fontname', 'Times New Roman');
l= legend(axesbox);
xlabel('Site Name');
ylabel('Spectral Fitting Residual',FontSize=16)
title('All Band',FontSize=18,FontWeight="bold");

scale=1.2;
figureWidth=18*scale;
figureHeight=9*scale;
set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);


x_axis_max=datatab1(end,2).Variables+const1;
xlim([0 x_axis_max]);
y_max=max(max(group1(:)),max(group2(:)));
y_min=min(min(group1(:)),min(group2(:)));
ylim([y_min-100 5000]);
% FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\','5_site_spec_cost','.fig'];
% saveas(gcf,FIG_PATH);
%% site OA band spec cost
figure();

group1 = [xh_basic_oa_cost,js_basic_oa_cost,hf_basic_oa_cost,tk_basic_oa_cost,rj_basic_oa_cost];
group2 = [xh_l2std_oa_cost,js_l2std_oa_cost,hf_l2std_oa_cost,tk_l2std_oa_cost,rj_l2std_oa_cost];
group3 = [xh_ST_oa_cost,js_ST_oa_cost,hf_ST_oa_cost,tk_ST_oa_cost,rj_ST_oa_cost];

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

factors = numel(tccon_arr);
factor=[];
factor1=[];
factor2=[];
factor3=[];

for i=1:numel(tccon_arr)
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

axesbox = boxchart(datatab.factor,datatab.data,'GroupByColor',datatab.group,BoxWidth=0.8,BoxFaceAlpha=0.6,WhiskerLineStyle='--',MarkerSize=5);
hold on

set(axesbox, {'BoxFaceColor'}, color,{'MarkerColor'},color, 'LineWidth',1.2);
set(gca, 'XTick', factor_vec, 'XTickLabel', tccon_arr);
set(gca,'XGrid','on','YGrid','on', 'LineWidth', 1, 'Fontsize', 14,'Fontname', 'Times New Roman');

% l= legend(axesbox);
xlabel('Site Name');
ylabel('Spectral Fitting Residual',FontSize=16)
title('O_2 A Band',FontSize=18,FontWeight="bold");

scale=1.2;
figureWidth=18*scale;
figureHeight=9*scale;
set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);


x_axis_max=datatab1(end,2).Variables+const1;
xlim([0 x_axis_max]);
y_max=max(max(group1(:)),max(group2(:)));
y_min=min(min(group1(:)),min(group2(:)));
ylim([y_min-100 2600]);
% FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\','5_site_oa_band_cost','.png'];
% saveas(gcf,FIG_PATH);
%% site WC band spec cost
figure();

group1 = [xh_basic_wc_cost,js_basic_wc_cost,hf_basic_wc_cost,tk_basic_wc_cost,rj_basic_wc_cost];
group2 = [xh_l2std_wc_cost,js_l2std_wc_cost,hf_l2std_wc_cost,tk_l2std_wc_cost,rj_l2std_wc_cost];
group3 = [xh_ST_wc_cost,js_ST_wc_cost,hf_ST_wc_cost,tk_ST_wc_cost,rj_ST_wc_cost];

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

factors = numel(tccon_arr);
factor=[];
factor1=[];
factor2=[];
factor3=[];

for i=1:numel(tccon_arr)
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

axesbox = boxchart(datatab.factor,datatab.data,'GroupByColor',datatab.group,BoxWidth=0.8,BoxFaceAlpha=0.6,WhiskerLineStyle='--',MarkerSize=5);
hold on

set(axesbox, {'BoxFaceColor'}, color,{'MarkerColor'},color, 'LineWidth',1.2);
set(gca, 'XTick', factor_vec, 'XTickLabel', tccon_arr);
set(gca,'XGrid','on','YGrid','on', 'LineWidth', 1, 'Fontsize', 14,'Fontname', 'Times New Roman');

% l= legend(axesbox);
xlabel('Site Name');
ylabel('Spectral Fitting Residual',FontSize=16)
title('Weak CO_2 Band',FontSize=18,FontWeight="bold");
% 设置长宽
scale=1.2;
figureWidth=18*scale;
figureHeight=9*scale;
set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);

% 最后根据实际情况调整x轴范围
x_axis_max=datatab1(end,2).Variables+const1;
xlim([0 x_axis_max]);
y_max=max(max(group1(:)),max(group2(:)));
y_min=min(min(group1(:)),min(group2(:)));
ylim([y_min-50 1200]);
% FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\','5_site_wc_band_cost','.png'];
% saveas(gcf,FIG_PATH);
%% site SC band spec cost
figure();

group1 = [xh_basic_sc_cost,js_basic_sc_cost,hf_basic_sc_cost,tk_basic_sc_cost,rj_basic_sc_cost];
group2 = [xh_l2std_sc_cost,js_l2std_sc_cost,hf_l2std_sc_cost,tk_l2std_sc_cost,rj_l2std_sc_cost];
group3 = [xh_ST_sc_cost,js_ST_sc_cost,hf_ST_sc_cost,tk_ST_sc_cost,rj_ST_sc_cost];

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

factors = numel(tccon_arr);
factor=[];
factor1=[];
factor2=[];
factor3=[];

for i=1:numel(tccon_arr)
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

axesbox = boxchart(datatab.factor,datatab.data,'GroupByColor',datatab.group,BoxWidth=0.8,BoxFaceAlpha=0.6,WhiskerLineStyle='--',MarkerSize=5);
hold on

set(axesbox, {'BoxFaceColor'}, color,{'MarkerColor'},color, 'LineWidth',1.2);
set(gca, 'XTick', factor_vec, 'XTickLabel', tccon_arr);
set(gca,'XGrid','on','YGrid','on', 'LineWidth', 1, 'Fontsize', 14,'Fontname', 'Times New Roman');
% l= legend(axesbox);
xlabel('Site Name');
ylabel('Spectral Fitting Residual',FontSize=16)
title('Strong CO_2 Band',FontSize=18,FontWeight="bold");
% 设置长宽
scale=1.2;
figureWidth=18*scale;
figureHeight=9*scale;
set(gcf, 'Units', 'centimeters', 'Position', [0 0 figureWidth figureHeight]);

x_axis_max=datatab1(end,2).Variables+const1;
xlim([0 x_axis_max]);
y_max=max(max(group1(:)),max(group2(:)));
y_min=min(min(group1(:)),min(group2(:)));
ylim([y_min-150 1700]);
% FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\','5_site_sc_band_cost','.png'];
% saveas(gcf,FIG_PATH);

%% calculate different band's contribution to spec cost value
std_cs=full_site_data(:,30:33);
basic_cs=full_site_data(:,34:37);
st_cs=full_site_data(:,38:41);

mean_std_cs=mean(std_cs,1);
mean_basic_cs=mean(basic_cs,1);
mean_st_cs=mean(st_cs,1);

del_basic_std=mean_std_cs-mean_basic_cs;
del_basic_st=mean_st_cs-mean_basic_cs;

pt_std_cs=mean_std_cs(1:3)./mean_std_cs(4);
pt_basic_cs=mean_basic_cs(1:3)./mean_basic_cs(4);
pt_st_cs=mean_st_cs(1:3)./mean_st_cs(4);
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