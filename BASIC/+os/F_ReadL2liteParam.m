function [ data ] = F_ReadL2liteParam( l2lt_path,day )
data.time = h5read(l2lt_path,'/time');
data.date=h5read(l2lt_path,'/date');
data.sounding_id = h5read(l2lt_path,'/sounding_id');
data.xco2=h5read(l2lt_path,'/xco2');
data.lat=h5read(l2lt_path,'/latitude');
data.long=h5read(l2lt_path,'/longitude');
data.quality_flag=h5read(l2lt_path,'/xco2_quality_flag');
data.psurf_apriori=h5read(l2lt_path,'/Retrieval/psurf_apriori');
data.airmass=h5read(l2lt_path,'/Sounding/airmass');
data.day=day;
data.mode=h5read(l2lt_path,'/Sounding/operation_mode'); % 0=nadir 1=glint

data.ice=h5read(l2lt_path,'/Retrieval/aod_ice');
data.water=h5read(l2lt_path,'/Retrieval/aod_water');
data.strataer=h5read(l2lt_path,'/Retrieval/aod_strataer');
data.du=h5read(l2lt_path,'/Retrieval/aod_dust');
data.so=h5read(l2lt_path,'/Retrieval/aod_sulfate');
data.ss=h5read(l2lt_path,'/Retrieval/aod_seasalt');
data.bc=h5read(l2lt_path,'/Retrieval/aod_bc');
data.oc=h5read(l2lt_path,'/Retrieval/aod_oc');
data.total_aod=h5read(l2lt_path,'/Retrieval/aod_total');

data.brdf_mean_o2a=h5read(l2lt_path,'/Retrieval/albedo_o2a');
data.brdf_mean_sco2=h5read(l2lt_path,'/Retrieval/albedo_sco2');
data.brdf_mean_wco2=h5read(l2lt_path,'/Retrieval/albedo_wco2');
data.brdf_slope_o2a=h5read(l2lt_path,'/Retrieval/albedo_slope_o2a');
data.brdf_slope_sco2=h5read(l2lt_path,'/Retrieval/albedo_slope_sco2');
data.brdf_slope_wco2=h5read(l2lt_path,'/Retrieval/albedo_slope_wco2');
end
