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

%% TCCON vs BASIC 
y_tccon=full_site_data(:,2);
y_BASIC=full_site_data(:,48);

axis_lim=[min([y_tccon;y_BASIC])-2,max([y_tccon;y_BASIC])+5];
os.F_scatter(y_tccon,y_BASIC,10,axis_lim,'TCCON XCO2','BASIC XCO2');
% FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\evaluation\relavent analyse\xco2_analyse\','BASIC_vs_tccon','.png'];
% saveas(gcf,FIG_PATH);
%% TCCON vs L2std 
y_l2std=full_site_data(:,1);
y_tccon=full_site_data(:,2);
y_BASIC=full_site_data(:,3);

axis_lim=[min([y_tccon;y_BASIC])-2,max([y_tccon;y_BASIC])+5];
os.F_scatter(y_tccon,y_l2std,10,axis_lim,'TCCON XCO2','L2std XCO2');
FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\evaluation\relavent analyse\xco2_analyse\','l2std_vs_tccon','.png'];
saveas(gcf,FIG_PATH);
%% TCCON vs L2lt
y_tccon=full_site_data(:,2);
y_L2lt=full_site_data(:,42);

axis_lim=[min([y_tccon;y_L2lt]-2),max([y_tccon;y_L2lt])+5];
os.F_scatter(y_tccon,y_L2lt,10,axis_lim,'TCCON XCO2','L2lt XCO2');
FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\evaluation\relavent analyse\xco2_analyse\','l2lt_vs_tccon','.png'];
saveas(gcf,FIG_PATH);
%% TCCON vs ST 
y_tccon=full_site_data(:,2);
y_ST=full_site_data(:,8);

axis_lim=[min([y_tccon;y_ST]-2),max([y_tccon;y_ST])+5];
os.F_scatter(y_tccon,y_ST,10,axis_lim,'TCCON XCO2','ST XCO2');
FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\evaluation\relavent analyse\xco2_analyse\','ST_vs_tccon','.png'];
saveas(gcf,FIG_PATH);
%% L2std vs ST 

axis_lim=[min([y_BASIC;y_ST]),max([y_BASIC;y_ST])];
os.F_scatter(y_ST,y_l2std,10,axis_lim,'ST XCO2','L2std XCO2');
FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\evaluation\relavent analyse\xco2_analyse\','ST_vs_l2std','.png'];
saveas(gcf,FIG_PATH);

%% pick du and ss samples
du_data=[];
ss_data=[];

du_idx=[];
ss_idx=[];

site_data=[hf_site_data;xh_site_data];

for i=1:numel(site_data(:,1))
    aerosol_type=site_data(i,9);
    if aerosol_type==2
        du_data=[du_data;site_data(i,:)];
        du_idx=[du_idx,i];
    end
    if aerosol_type==5
        ss_data=[ss_data;site_data(i,:)];
        ss_idx=[ss_idx,i];
    end
end
%% DU sample: BASIC R0 vs Coarse AOD 
BASIC_r0=du_data(:,16);
coarse_aod=du_data(:,43);
x=BASIC_r0;
y=coarse_aod;

x_lim=[min(x)-0.1e-7,max(x)+0.1e-7];
y_lim=[min(y)-0.005,max(y)+0.005];

os.F_scatter_noxyline(x,y,24,x_lim,y_lim,'BASIC r_0([XH,HF] site)','ACOS DWS AOD');
% FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\evaluation\relavent analyse\radius_aod_analyse\','XHHF_DU_BASIC_r0_vs_coarse_aod','.png'];
% saveas(gcf,FIG_PATH);
%% SS sample: BASIC R0 vs Coarse AOD 
BASIC_r0=ss_data(:,16);
coarse_aod=ss_data(:,43);
x=BASIC_r0;
y=coarse_aod;

x_lim=[min(x)-0.01e-7,max(x)+0.01e-7];
y_lim=[min(y),max(y)];

os.F_scatter_noxyline(x,y,24,x_lim,y_lim,'BASIC r_0([XH,HF] site)','ACOS DWS AOD');
% FIG_PATH=['D:\Data\TCCON_ND_data\rodge_result_log\evaluation\relavent analyse\radius_aod_analyse\','XHHF_SS_BASIC_r0_vs_coarse_aod','.png'];
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
