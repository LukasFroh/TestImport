function siteDataOut = imp_convertAllInsituData2OneTable(input,siteDataIn,finalSensorStructName,finalTTName)

% Chosen variable to evaluate
evalVar = input.var2ScaleInsitu{:};
% Time2Eval
t2e = input.time2Eval;

% Identify site names
if iscell(siteDataIn(1).name)
    sites       = [siteDataIn(:).name];
elseif ischar(siteData(1).name)
    sites       = {siteDataIn(:).name};
end

% Initialize siteData struct
siteDataOut             = siteDataIn;

% Loop over all sites
for iField = 1:numel(sites)

    % If finalSensorStructName is no timetable, do sensor priority sorting
    if ~istimetable(siteDataIn(iField).(finalSensorStructName))

        % Get all data names in current final live data struct
        currFields          = fieldnames(siteDataIn(iField).(finalSensorStructName));

        % Cell with most current timesteps
        tsCell = cell(numel(currFields),1);

        for cfi = 1:numel(currFields)
            currSens = currFields{cfi};

            % Identify corresponding cleaned timetable name
            if strcmpi(currSens,'dwrHIS')
                cleanedTableName = 'hisCleaned';
                currSensInit = 'dwr'; % Sensor name with his/hiw/gps
            elseif strcmpi(currSens,'dwrHIW')
                cleanedTableName = 'hiwCleaned';
                currSensInit = 'dwr'; % Sensor name with his/hiw/gps
            elseif strcmpi(currSens,'dwrGPS')
                cleanedTableName = 'cleaned';
                currSensInit = 'dwr'; % Sensor name with his/hiw/gps
            else
                cleanedTableName = 'cleaned';
                currSensInit = currSens; % Sensor name with his/hiw/gps
            end

            % Identify whether current sensor struct is empty or not
            if isempty(siteDataIn(iField).(currSensInit).(cleanedTableName))
                tsCell{cfi} = datetime(NaT,'TimeZone','UTC');
                continue
            end

            % Identify last valid non-nan var
            notNanIdx = find(~isnan(siteDataIn(iField).(currSensInit).(cleanedTableName).(evalVar)));
            % If valid datapoints are available
            if ~isempty(notNanIdx) > 1
                % Find closest timestep to time2eval t2e
                [~,timeIdx] = min( abs( t2e - siteDataIn(iField).(currSensInit).(cleanedTableName).Time(onlyValidIdx) ) );
                tsCell{cfi} = siteDataIn(iField).(currSensInit).(cleanedTableName).Time(timeIdx);
                % If only nan or no datapoints are available
            else
                tsCell{cfi} = siteDataIn(iField).(currSensInit).(cleanedTableName).Time(end);
            end

        end

        % Identify most recent timestep
        if all(isnat([tsCell{:}]))
            % No valid sensor available. Create timetable with NaN entry for current timestep and set chosenSensor to none
            nTimesteps                                  = nan(numel(siteDataIn(iField).time),1);
            siteDataOut(iField).(finalTTName)           = timetable(siteDataIn(iField).time,nTimesteps,'VariableNames',{'VHM0'});
            siteDataOut(iField).('chosenSensor')        = 'none';
        else
            % Identify sensor to use (most recent time mrt)
            [~,mrt] = min(abs( t2e - [tsCell{:}] ));
            finalSensorName = currFields{mrt};
            if contains(finalSensorName,'dwr')
                finalChosenSensor = 'dwr';
            else
                finalChosenSensor = finalSensorName;
            end

            % Set final timetable
            siteDataOut(iField).(finalTTName)           = siteDataIn(iField).(finalSensorStructName).(finalSensorName);
            % Set chosenSensor to dwr
            siteDataOut(iField).('chosenSensor')        = finalChosenSensor;
        end

    end
end

end