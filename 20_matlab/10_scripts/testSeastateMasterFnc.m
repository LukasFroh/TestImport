%% Test seastateMasterFnc in Matlab Application

clear,clc,close all
restoredefaultpath

%% :::: Dummy Mode :::
% Activate ("1") or deactivate ("0") dummy Mode. Input must be given as string!
dummyBool           = "0";

tIn = datetime(2022,02,28,06,30,00,'TimeZone','UTC');

tOut = datetime(2022,02,28,18,00,00,'TimeZone','UTC');

tNow = datetime('now','TimeZone','UTC');

% Define manual timeshift (one value or multiple values for looping)
for ti = 24.5
    % for ti = floor( hours(tNow-tOut) ) : 0.5: ceil( hours(tNow-tIn) )

    dataPath            = char("{'C:\Users\LuFI_LF\OneDrive\LuFI\04_Projekte\03_OpenRAVE\30_Daten\01_ftpBSH_sync\'}");
    % dataPath            = char("{'C:\Users\LuFI_LF\OneDrive\LuFI\04_Projekte\03_OpenRAVE\30_Daten\00_NewStructure\'}");
    headerPath          = char("{'C:\Users\LuFI_LF\seadrive_root\froehlin\Meine Bibliotheken\GitLab\Seegangsmodul\10_inputFiles\10_headerFiles\'}");
    coastlinePath       = char("{'C:\Users\LuFI_LF\seadrive_root\froehlin\Meine Bibliotheken\GitLab\Seegangsmodul\10_inputFiles\20_coastlineFiles\'}");
    siteOverviewPath    = char("{'C:\Users\LuFI_LF\seadrive_root\froehlin\Meine Bibliotheken\GitLab\Seegangsmodul\10_inputFiles\30_siteOverview\'}");
    wamDataPath         = char("{'D:\OpenRAVE_DWD_WAM_Forecast\'}");
    logPath             = char("{'C:\Users\LuFI_LF\seadrive_root\froehlin\Meine Bibliotheken\output_Seegangsmodul\10_logs'}");
    figPath             = char("{'C:\Users\LuFI_LF\seadrive_root\froehlin\Meine Bibliotheken\output_Seegangsmodul\20_figures'}");
    expDataPath         = char("{'C:\Users\LuFI_LF\seadrive_root\froehlin\Meine Bibliotheken\output_Seegangsmodul\30_data'}");
    % figPath             = char("{'C:\Users\LuFI_LF\seadrive_root\Lukas Fr\Meine Bibliotheken\GitLab\vessel_msdv\40_figures\cwamAdjustedOutput'}");
    % expDataPath         = char("{'C:\Users\LuFI_LF\seadrive_root\Lukas Fr\Meine Bibliotheken\GitLab\vessel_msdv\40_figures\cwamAdjustedOutput'}");
    cmPath              = char("{'C:\Users\LuFI_LF\seadrive_root\froehlin\Meine Bibliotheken\GitLab\Seegangsmodul\10_inputFiles\40_colormaps'}");
    seastateVars2Eval   = char("{'VHM0'}");

    % Change paths for dummy mode
    if strcmp(dummyBool,"1")
        dataPath        = char("{'C:\Users\LuFI_LF\seadrive_root\froehlin\Meine Bibliotheken\GitLab\Seegangsmodul\50_dummyData\20_insitu\'}");
        wamDataPath     = char("{'C:\Users\LuFI_LF\seadrive_root\froehlin\Meine Bibliotheken\GitLab\Seegangsmodul\50_dummyData\10_forecast\'}");
        logPath         = char("{'C:\Users\LuFI_LF\seadrive_root\froehlin\Meine Bibliotheken\GitLab\Seegangsmodul\50_dummyData\30_output\10_logs'}");
        figPath         = char("{'C:\Users\LuFI_LF\seadrive_root\froehlin\Meine Bibliotheken\GitLab\Seegangsmodul\50_dummyData\30_output\20_figures'}");
        expDataPath     = char("{'C:\Users\LuFI_LF\seadrive_root\froehlin\Meine Bibliotheken\GitLab\Seegangsmodul\50_dummyData\30_output\30_data'}");
    end

    minQF               = "2";
    wamModel2Eval       = 'cwam';
    wamVars             = char("{'sign_whight'}");
    % site2Imp            = char("{'AV0', 'DBU','BUD', 'ELB', 'FN1', 'FN3', 'HEL', 'HEO', 'LTH', 'NO1', 'WES', 'NOR', 'NOO','BO1'}");

    if strcmp(wamModel2Eval,'cwam')
        site2Imp        = char("{'AV0', 'BUD', 'ELB', 'FN1', 'FN3', 'HEO', 'LTH', 'NO1', 'NOR', 'NOO', 'WES'}");
        latLimMin       = "53.2541695";
        latLimMax       = "55.2458344";
        lonLimMin       = "6.1736112";
        lonLimMax       = "8.9930553";
        rasterSizeLat   = "240";
        rasterSizeLon   = "203";
    elseif strcmp(wamModel2Eval,'ewam')
        site2Imp        = char("{'AV0', 'DBU','BUD', 'ELB', 'FN1', 'FN3', 'HEO', 'LTH', 'NO1', 'NOR', 'NOO','BO1','WES'}");
        latLimMin       = "53.25";
        latLimMax       = "55.25";
        lonLimMin       = "5.5";
        lonLimMax       = "9";
        rasterSizeLat   = "41";
        rasterSizeLon   = "36";
    end

    gshhgInputFile      = char("{'GSHHG.mat'}");
    var2ScaleInsitu     = char("{'VHM0'}");
    var2ScaleWam        = char("{'sign_whight'}");
    interpLineLength    = "1";
    cbType              = 'fixed';
    pltType             = 'adjInfo';
    statType            = 'heatmap';
    figRes              = "300";
    figType             = '.png';
    cmName              = char("{'lipari'}");
    cmStatsName         = char("{'bam'}");
    cmFlip              = 'flip';
    gridType            = 'on';
    % fsAxis              = "18";                 % Font size axes object
    % fsSites             = "15";                 % Font size site text
    % fsTitle             = "40";                 % Font size title
    % siteMarkerSize      = "50";                 % Marker size for site indication
    fsAxis              = "11";                 % Font size axes object
    fsSites             = "12";                 % Font size site text
    fsTitle             = "13";                 % Font size title
    siteMarkerSize      = "75";                 % Marker size for site indication
    boolHighResCM       = "1";                  % Boolean whether additional figure with higher Hs resolution should be plotted or not
    highResUpLimit      = "1.5";                % Upper limit for higher resolution colormap
    exportFigBool       = "1";
    exportDataMatBool   = "1";
    exportDataZipBool   = "1";
    timeShift           = string(ti);


    %% execution
    % Add path to functions
    addpath(genpath('C:\Users\LuFI_LF\seadrive_root\froehlin\Meine Bibliotheken\GitLab\Seegangsmodul\20_matlab'))

    % Execution of master function
    seastateMasterFnc(dataPath, headerPath, coastlinePath, wamDataPath, siteOverviewPath, logPath, figPath, expDataPath, cmPath, ... % Path input
        site2Imp, seastateVars2Eval, minQF,...                                                      % Seastate input
        wamModel2Eval, wamVars, ...                                                                 % WAM input
        latLimMin, latLimMax, lonLimMin, lonLimMax, rasterSizeLat, rasterSizeLon, ...               % Spatial settings
        gshhgInputFile, ...                                                                         % Coastline settings
        var2ScaleInsitu, var2ScaleWam, interpLineLength, ...                                        % Scale settings
        cbType, pltType, statType, figRes, figType, gridType, cmName, cmStatsName, cmFlip, fsAxis, fsSites, fsTitle, siteMarkerSize, boolHighResCM,  highResUpLimit,...   % Plot settings
        timeShift, ...                                                                              % Manual time shift in hours as double (only for LuFI testing purposes)
        dummyBool, ...                                                                              % Activate/Deactivate dummy mode
        exportFigBool, exportDataMatBool, exportDataZipBool)                                        % Booleans whether figures/data should be saved / exported


end