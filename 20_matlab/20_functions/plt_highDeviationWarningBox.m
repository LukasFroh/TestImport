function a = plt_highDeviationWarningBox(ax,input,siteNames,deviations)

% Position: left, bottom, width, height
unit        = 'normalized';
ax.Units    = unit;

% Fontsize
legFS       = input.fsAxis;
% Warning threshold
thresh      = input.warningThresh;
% Identify which sites exceed deviation threshold
excdIdx     = abs(deviations) > thresh;
excdSiteNames = {siteNames{excdIdx}};

% Create final error string and include site name that exceeds threshold
if numel(excdSiteNames) < 2
    excdPltString = excdSiteNames{:};
else
    for i = 1:numel(excdSiteNames)

        if i == 1
            excdPltString = excdSiteNames{i};
        else
            excdPltString = strcat([excdPltString,' / ',excdSiteNames{i}]);
        end
    end
end

% Add '<' and '>' to string
excdPltString = strcat('$<$',excdPltString,'$>$');

% Final warning string
str2Plot = {['Warning! Rel. deviation of following sites exceeds threshold (' num2str(thresh) '\%): ', excdPltString, newline, 'This may be due to erroneous insitu or ', upper(input.wamModel2Eval) ,' values and can lead to an incorrect visualization.']};

% Get actual position of axes with plotboxpos function
pos         = arrayfun(@plotboxpos, ax, 'uni', 0);
dim         = cellfun(@(x) x.*[1 1 1 1], pos, 'uni',0);

% Identify position based on warnBoolVec
% This warning infobox has priority vs plt_missingCrucialSitesWarningBox --> No if / else condition needed
% Dimensions always top 20% height of the axes
dim{:}(2)   = dim{:}(2) + dim{:}(4) - 0.2*dim{:}(4);
dim{:}(4)   = 0.2*dim{:}(4);

% Plot Warning
a           = annotation('textbox',dim{1},'String',str2Plot,'FitBoxToText','off','BackgroundColor',[0.95,0.95,0.95],'EdgeColor',[.1,.1,.1],'Color',[0.8902, 0.2902, 0.2000],'FontSize',legFS,'VerticalAlignment','mid','HorizontalAlignment','left','FontWeight','bold','Interpreter','latex');

end
