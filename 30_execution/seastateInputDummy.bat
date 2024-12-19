:: %%%%%%%% Input file for seastate Module
echo off

:::::::::::::: Dummy mode ::::::::::::::::::::
:: Set the variable to 1 to enable Dummy Mode, or to 0 to disable it. In dummy mode, always the same date (2024/03/22 21:45:00) will be evaluated. 
SET d1=1

:::::::::::::: Set Paths ::::::::::::::::::::
:: Paths must be specified in the format {'...'}
:: Path to insitu files
SET p1={'...\50_dummyData\20_insitu\'}
:: Path to Header files
Set p2={'...\10_inputFiles\10_headerFiles\'}
:: Path to GSHHG files
SET p3={'...\10_inputFiles\20_coastlineFiles\'}
:: Path to wam directory. Directory contains two folders: <\cwam> containing all cwam .nc-files & <\ewam> containing all ewam .nc-files
SET p4={'...\50_dummyData\10_forecast\'}
:: Path to siteOverview .xlsx
SET p5={'...\10_inputFiles\30_siteOverview\'}
:::: Output folders p6-p9 (may be outside the repository)
:: Path to log folder
SET p6={'...\50_dummyData\30_output\10_logs'}
:: Path to figure folder
SET p7={'...\50_dummyData\30_output\20_figures'}
:: Path to exportData folder
SET p8={'...\50_dummyData\30_output\30_data'}
:: Path to colormap folder
SET p9={'...\10_inputFiles\40_colormaps'}

:::::::::::::: Insitu settings ::::::::::::::::::::
:: Define sites that should be considered as cellstring (Matlab format). This input is initially recorded as 'char' in Matlab and converted to a cellstring in the Matlab function
:: 'DBU' and 'BO1' not within cwam boundaries
:: All sites:
:: SET i1={'AV0', 'DBU','BUD', 'ELB', 'FN1', 'FN3', 'HEL', 'HEO', 'LTH', 'NO1', 'WES', 'NOR', 'NOO','BO1'}
:: CWAM default:
SET i1={'AV0', 'BUD', 'ELB', 'FN1', 'FN3', 'HEO', 'LTH', 'NO1', 'NOR', 'NOO'}
:: EWAM default:
:: SET i1={'AV0', 'DBU','BUD', 'ELB', 'FN1', 'FN3', 'HEL', 'HEO', 'LTH', 'NO1', 'NOR', 'NOO','BO1'}
:: Which insitu seaste variable should be imported (as Cellstring, see above, default: 'VHM0')
SET i2={'VHM0'}
:: Minimum final quality flag for insitu seastate data (Default: 2)
SET i3=2
:: Specify WAM dataset. Choose between <cwam> and <ewam>
SET i4=cwam
:: Set wam variables that should be imported (Cellstring). Choose between {'energy_per','mean_wave_dir','sea_dir','sea_mean_per','sea_peak_per','sea_whight','sign_whight','swell_dir','swell_mean_per','swell_peak_per','swell_whight','wind_dir','wind_speed'}
SET i5={'sign_whight'}

:::::::::::::: Spatial settings ::::::::::::::::::::
:: Minimum latitude limit (Default values | CWAM: 53.2541695, EWAM: 53.25)
SET i6=53.2541695
::SET I6=53.25
:: Maximum latitude limit (Default values | CWAM: 55.2458344, EWAM: 55.25)
SET i7=55.2458344
::SET I7=55.25
:: Minimum longitude limit (Default values | CWAM: 6.1736112, EWAM: 5.5)
SET i8=6.1736112
::SET i8=5.5
:: Maximum longitude limit (Default values | CWAM: 8.9930553, EWAM: 9)
SET i9=8.9930553
::SET i9=9
:: Resolution Longitude vector (Default values | CWAM: 203, EWAM: 36)
SET i10=203
::SET i10=36
:: Resolution Latitude vector (Default values | CWAM: 240, EWAM: 41)
SET i11=240
::SET i11=41
:: GSHHG Coastline dataset. Choose between <'gshhs_c.b'> (crude), <'gshhs_l.b'> (low), <'gshhs_i.b'> (intermediate), <'gshhs_h.b'> (high), <'gshhs_f.b'> (full, default option)
:: Wessel, P., & Smith, W. H. F. (1996). A global, self-consistent, hierarchical, high-resolution shoreline database. In Journal of Geophysical Research: Solid Earth (Vol. 101, Issue B4, pp. 8741–8743). American Geophysical Union (AGU). https://doi.org/10.1029/96jb00104
:: Mapping Toolbox available? SET i12={'gshhs_f.b'}
SET i12={'GSHHG.mat'}

:::::::::::::: Scale settings ::::::::::::::::::::
:: Hs insitu parameter name
Set s1={'VHM0'}
:: Hs wam parameter name
Set s2={'sign_whight'}
:: How many data points per km interpolation length? (default: 1)
Set s3=1

:::::::::::::: Figure settings ::::::::::::::::::::
:: Colorbar type: 'auto' (automatically scales up to max value) or 'fixed' (colorbar interval [0,10])
SET f1=fixed
:: Choose plot type between: <'wam'> (only WAM), <'adj'> (only adjusted)', <'both'>, <'wamInfo'>, <'adjInfo'> (default: adjInfo)
SET f2=adjInfo
:: Choose type for visualizing absolute/relative deviation. Choose between <'heatmap'> and <'barplot'>
SET f3=heatmap
:: Choose figure resolution (dpi)
SET f4=300
:: Choose figure type (only Image, vector output not yet included)
SET f5=.png
:: Visualisation of lat/lon grid. Choose between <on> and <off>
SET f6=on
:: Choose sequential "scientific colormap" for seastate map visualization by Fabio Crameri, https://www.fabiocrameri.ch/colourmaps/
SET f7={'lipari'}
:: Choose diverging "scientific colormap" for statistics visualization by Fabio Crameri, https://www.fabiocrameri.ch/colourmaps/
Set f8={'bam'}
:: Flip colormap order upside down? Choose between <flip> and <noFlip>
SET f9=flip
:: Set general fontsize of axes object (ticks, ticklabel, x- & y-label)
Set f10=11
:: Set fontsize for site text at each location in plot, respectively
Set f11=12
:: Set fontsize for plot title (date)
Set f12=13
:: Set markerSize for site indication
Set f13=75
:: Choose if additional figure with higher resolution for small Hs should be created and exported (1 for yes, 0 for no)
Set f14=1
:: Define upper limit for high resolution colormap (white2green). Default: 1.5
Set f15=1.5

:::::::::::::: Export settings ::::::::::::::::::::
:: Export figure(s) to specified folder p7? (1 for yes, 0 for no)
SET e1=1
:: Export data (grid data for latitude, longitude, adjusted variable) as .mat file to folder specified folder p8? (1 for yes, 0 for no)
SET e2=1
:: Export data (grid data for latitude, longitude, adjusted variable) as .zip file to folder specified folder p8? (1 for yes, 0 for no)
SET e3=1

:::::::::::::: LuFI testing ::::::::::::::::::::
:: Manual time shift of the time to be evaluated in the past (in hours). Matlab variable is defined as hours as double.
:: Leave default value "0" for normal use
SET l1="24" 

.\seastateModule_v1_7.exe "%p1%" "%p2%" "%p3%" "%p4%" "%p5%" "%p6%" "%p7%" "%p8%" "%p9%" "%i1%" "%i2%" "%i3%" "%i4%" "%i5%" "%i6%" "%i7%" "%i8%" "%i9%" "%i10%" "%i11%" "%i12%" "%s1%" "%s2%" "%s3%" "%f1%" "%f2%" "%f3%" "%f4%" "%f5%" "%f6%" "%f7%" "%f8%" "%f9%" "%f10%" "%f11%" "%f12%" "%f13%" "%f14%" "%f15%" "%l1%" "%d1%" "%e1%" "%e2%" "%e3%"> batchLog.txt