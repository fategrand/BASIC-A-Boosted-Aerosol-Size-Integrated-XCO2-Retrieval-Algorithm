----------------------
BASIC analyse data
----------------------
This repository stores all data used by the BASIC algorithm along with the relevant analysis codes. 
All codes are written in MATLAB format, and the stored data are saved as matrices in MATLAB's .mat format.
Specifically, the /BASIC/+os/ folder contains self-developed MATLAB functions that 
can be called by analysis scripts located in the /BASIC/ directory. 
The /BASIC/data/ folder includes data matrices for five individual TCCON sites and one combined matrix containing data from all sites. 
These data comprise the XCO₂ retrieval results of the algorithms discussed in the paper, 
forward model spectral fitting results, aerosol optical properties, microphysical parameter results, and more. 
All matrices are stored in the format of N rows by 48 columns. 
The information represented by each column is as follows.

----------------------
data colum name                                
----------------------
std_xco2 tcc_xco2 BASIC_xco2 my_flag l2_flag sounding_id month ST_xco2 aerosol_type 
     1        2      3       4        5         6        7        8      9
BASIC_aod  l2std_total_aod  ice_aod  wt_aod  st_aod  cloud_flag r0  sigma
     10           11            12      13      14        15     16    17
ext_arr  scat_arr  std_oa  std_wc  std_sc  std_spec 
  18-23     24-29     30      31      32       33
basic_oa  basic_wc  basic_sc  basic_spec ST_oa ST_wc ST_sc ST_spec l2lt_xco2
  34         35       36         37        38     39     40      41        42
coarse_aod lt_du lt_ss pred_aerosol_type tccon_code  pred_BASIC_xco2
    43      44     45          46            47              48
aerosol_type index('bc','du','oc','so','ss','water')
                     1    2    3    4    5     6
site_code index('XH','JS','HF','TK','RJ')
                  1    2    3    4    5
----------------------

----------------------
Algorithm retrieve code
----------------------
The ACOS retrieval code used as the algorithmic foundation for this study 
is open-source and available at GitHub: 
https://github.com/nasa/RtRetrievalFramework

----------------------
GEOSmie code
----------------------
 The GEOSmie computational tool is available at GitHub: 
 https://github.com/GEOS-ESM/GEOSmie
