function ax = plt_spatialPlot(ax,input,cmDeep,lonInput,latInput,varInput,cfLevels,GSHHG,fsAxis,coastColor,edgeColor,gridType)

%% Adjust lat/lon boundaries
lonStep                 = 0.5;
latStep                 = 0.25;
[lonLim,latLim]         = deal(zeros(1,2));
lonLim(1)               = floor(input.lonLim(1)/lonStep) * lonStep;
lonLim(2)               = ceil(input.lonLim(end)/lonStep) * lonStep;
latLim(1)               = floor(input.latLim(1)/latStep) * latStep;
latLim(2)               = ceil(input.latLim(end)/latStep) * latStep;

cwamLonLim              = [6.18, 9];        % Actual limits: [6.173611, 8.9930553]
cwamLatLim              = [53.25, 55.25];   % Actual limits: [53.2541695, 55.2458344]
ewamLonLim              = [5.5, 9];
ewamLatLim              = [53.25, 55.25];

% For cwam input
if strcmpi(input.wamModel2Eval,'cwam')
    if lonLim(1) < cwamLonLim(1)
        lonLim(1) = floor(cwamLonLim(1)/lonStep) * lonStep + lonStep/2;
    end
    if lonLim(2) > 1.01 * cwamLonLim(2)
        lonLim(2) = ceil(cwamLonLim(2)/lonStep) * lonStep - lonStep/2;
    end
    if latLim(1) < cwamLatLim(1)
        latLim(1) = floor(cwamLatLim(1)/latStep) * latStep + latStep/2;
    end
    if latLim(2) > cwamLatLim(2)
        latLim(2) = ceil(cwamLatLim(2)/latStep) * latStep - latStep/2;
    end
end
% For ewam input
if strcmpi(input.wamModel2Eval,'ewam')
    % When rounded limits smaller/larger than existing wam boundaries, Adjust by a half step. Increase eastern limit by 1%, because there is coastline and no wam data. (CWAM 8.99->9)
    if lonLim(1) < ewamLonLim(1)
        lonLim(1) = floor(ewamLonLim(1)/lonStep) * lonStep + lonStep/2;
    end
    if lonLim(2) > 1.01 * ewamLonLim(2)
        lonLim(2) = ceil(ewamLonLim(2)/lonStep) * lonStep - lonStep/2;
    end
    if latLim(1) < ewamLatLim(1)
        latLim(1) = floor(ewamLatLim(1)/latStep) * latStep + latStep/2;
    end
    if latLim(2) > ewamLatLim(2)
        latLim(2) = ceil(ewamLatLim(2)/latStep) * latStep - latStep/2;
    end
end

% Set axis properties
set(ax,'defaultTextInterpreter','latex')
ax.FontSize             = fsAxis;
ax.XLim                 = lonLim;
ax.XTick                = lonLim(1):lonStep:lonLim(2);
ax.YLim                 = latLim;
ax.YTick                = latLim(1):latStep:latLim(2);
ax.XTickLabel           = arrayfun(@(x) sprintf('%.2f',ax.XTick(x)),1:numel(ax.XTick),'UniformOutput',false);
ax.YTickLabel           = arrayfun(@(x) sprintf('%.2f',ax.YTick(x)),1:numel(ax.YTick),'UniformOutput',false);
ax.XTickLabel           = strcat(ax.XTickLabel,'$^{\circ}$E');
ax.YTickLabel           = strcat(ax.YTickLabel,'$^{\circ}$N');
ax.XLabel.Interpreter   = 'latex';
ax.XAxis.TickLabelInterpreter = 'latex';
ax.YLabel.Interpreter   = 'latex';
ax.YAxis.TickLabelInterpreter = 'latex';
ax.XLabel.String        = 'Longitude';
ax.YLabel.String        = 'Latitude';
ax.TickDir              = 'both';
ax.Box                  = 'on';

% Set colormap
% colormap(cmDeep)

% Plot spatial information
% contourf(ax,lonInput,latInput,varInput,cfLevels)
hOut                            = contourfnu(lonInput,latInput,varInput,cfLevels,cmDeep,'eastoutside',false,'contourf');
hOut.hc.Label.FontSize          = fsAxis;
hOut.hc.Label.Interpreter       = 'latex';
hOut.hc.TickLabelInterpreter    = 'latex';
hOut.hc.Label.String            = 'Significant Wave Height $H_s$ [m]';
hOut.h.LineStyle                = ':';
% Set Colorbar location to bottom outside
hOut.hc.Location                = 'southoutside';
lat_lon_proportions(ax)
% LineWdith for coastlines and plot frame
lw                              = 1;

% Plot coastlines
for cli = 1:numel(GSHHG.clFieldnames)
    patch(ax,GSHHG.sets.(GSHHG.clFieldnames{cli}).lon,GSHHG.sets.(GSHHG.clFieldnames{cli}).lat,coastColor,'EdgeColor',edgeColor,'LineWidth',lw)
end

% if ax.XTickLabelRotation > 0
%     ax.XTickLabelRotation                  = 90;
% end

%% Grid options
if strcmpi(gridType,'on')
    xline(ax.XTick,'--')
    yline(ax.YTick,'--')
    % out.Xtick = ax.XTick;
    % out.YTick = ax.YTick;
    % save('C:\Users\LuFI_LF\seadrive_root\froehlin\Meine Bibliotheken\output_Seegangsmodul\out.mat','out')
end

% Plot frame
yline(ax.YLim(1),'LineWidth',lw)
yline(ax.YLim(2),'LineWidth',lw)
xline(ax.XLim(1),'LineWidth',lw)
xline(ax.XLim(2),'LineWidth',lw)


end