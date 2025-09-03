function [data_strat,data_ice,data_water,data_so,data_du,data_ss,data_bc,data_oc] = F_ReadStaticAerosolParam(static_aerosol_path)

data_strat.extinction = h5read(static_aerosol_path,'/strat/Properties/extinction_coefficient');
data_strat.phase_function = h5read(static_aerosol_path,'/strat/Properties/phase_function_moment');
data_strat.scatter = h5read(static_aerosol_path,'/strat/Properties/scattering_coefficient');
data_strat.wave_number = h5read(static_aerosol_path,'/strat/Properties/wave_number');

data_ice.extinction = h5read(static_aerosol_path,'/ice_cloud_MODIS6_deltaM_1000/Properties/extinction_coefficient');
data_ice.phase_function = h5read(static_aerosol_path,'/ice_cloud_MODIS6_deltaM_1000/Properties/phase_function_moment');
data_ice.scatter = h5read(static_aerosol_path,'/ice_cloud_MODIS6_deltaM_1000/Properties/scattering_coefficient');
data_ice.wave_number = h5read(static_aerosol_path,'/ice_cloud_MODIS6_deltaM_1000/Properties/wave_number');

data_water.extinction = h5read(static_aerosol_path,'/wc_008/Properties/extinction_coefficient');
data_water.phase_function = h5read(static_aerosol_path,'/wc_008/Properties/phase_function_moment');
data_water.scatter = h5read(static_aerosol_path,'/wc_008/Properties/scattering_coefficient');
data_water.wave_number = h5read(static_aerosol_path,'/wc_008/Properties/wave_number');

data_so.extinction = h5read(static_aerosol_path,'/asu/Properties/extinction_coefficient');
data_so.phase_function = h5read(static_aerosol_path,'/asu/Properties/phase_function_moment');
data_so.scatter = h5read(static_aerosol_path,'/asu/Properties/scattering_coefficient');
data_so.wave_number = h5read(static_aerosol_path,'/asu/Properties/wave_number');

data_du.extinction = h5read(static_aerosol_path,'/adu/Properties/extinction_coefficient');
data_du.phase_function = h5read(static_aerosol_path,'/adu/Properties/phase_function_moment');
data_du.scatter = h5read(static_aerosol_path,'/adu/Properties/scattering_coefficient');
data_du.wave_number = h5read(static_aerosol_path,'/adu/Properties/wave_number');

data_ss.extinction = h5read(static_aerosol_path,'/ass/Properties/extinction_coefficient');
data_ss.phase_function = h5read(static_aerosol_path,'/ass/Properties/phase_function_moment');
data_ss.scatter = h5read(static_aerosol_path,'/ass/Properties/scattering_coefficient');
data_ss.wave_number = h5read(static_aerosol_path,'/ass/Properties/wave_number');

data_bc.extinction = h5read(static_aerosol_path,'/bc/Properties/extinction_coefficient');
data_bc.phase_function = h5read(static_aerosol_path,'/bc/Properties/phase_function_moment');
data_bc.scatter = h5read(static_aerosol_path,'/bc/Properties/scattering_coefficient');
data_bc.wave_number = h5read(static_aerosol_path,'/bc/Properties/wave_number');

data_oc.extinction = h5read(static_aerosol_path,'/oc/Properties/extinction_coefficient');
data_oc.phase_function = h5read(static_aerosol_path,'/oc/Properties/phase_function_moment');
data_oc.scatter = h5read(static_aerosol_path,'/oc/Properties/scattering_coefficient');
data_oc.wave_number = h5read(static_aerosol_path,'/oc/Properties/wave_number');

end