% logreader.m
% Use this script to read data from your micro SD card

clear;
%clf;

filenum = '010'; % file number for the data from the tankroom
infofile = strcat('INF', filenum, '.TXT');
datafile = strcat('LOG', filenum, '.BIN');

%% map from datatype to length in bytes
dataSizes.('float') = 4;
dataSizes.('ulong') = 4;
dataSizes.('int') = 4;
dataSizes.('int32') = 4;
dataSizes.('uint8') = 1;
dataSizes.('uint16') = 2;
dataSizes.('char') = 1;
dataSizes.('bool') = 1;

%% read from info file to get log file structure
fileID = fopen(infofile);
items = textscan(fileID,'%s','Delimiter',',','EndOfLine','\r\n');
fclose(fileID);
[ncols,~] = size(items{1});
ncols = ncols/2;
varNames = items{1}(1:ncols)';
varTypes = items{1}(ncols+1:end)';
varLengths = zeros(size(varTypes));
colLength = 256;
for i = 1:numel(varTypes)
    varLengths(i) = dataSizes.(varTypes{i});
end
R = cell(1,numel(varNames));

%% read column-by-column from datafile
fid = fopen(datafile,'rb');
for i=1:numel(varTypes)
    %# seek to the first field of the first record
    fseek(fid, sum(varLengths(1:i-1)), 'bof');
    
    %# % read column with specified format, skipping required number of bytes
    R{i} = fread(fid, Inf, ['*' varTypes{i}], colLength-varLengths(i));
    eval(strcat(varNames{i},'=','R{',num2str(i),'};'));
end
fclose(fid);

%% Process your data here
%accelX = accelX(1400:2300)
%accelY = accelY(1400:2300)
%accelZ = accelZ(1400:2300)


%Scale each column to convert from teensy units to meters/second^2
scale = .01;
accelZscaled = accelZ * scale;
accelXscaled = accelX * scale;
accelYscaled = accelY * scale;

%Statistics for uncertainty line: Zero in Z
% this code was not used for plotting but we used it later for the
% statistical analysis, and just kept it in the same script but commented
% it out to make it easier for ourselves

%xbar = mean(accelZscaled); % sample mean
%confLevel = 0.95; % confidence level
%S = std(accelZscaled); % Standard deviation
%N = length(accelZscaled); % Count
%df= N-1;
%ESE = S/sqrt(N); % Estimated Standard Error
%t1 = %find using table%;
%lambda = t1*ESE; % 1/2 of the confidence interval;

%Uncertainty line
%upperBound = xbar + lambda;
%lowerBound = xbar - lambda;

% Plot all three acceleration data 

figure
plot(accelXscaled,'-b')
xlim([1400 1900])
hold on
plot(accelYscaled,'-g')
xlim([1400 1900])
hold on
plot(accelZscaled,'-r')
xlim([1400 1900])

% Mean and CI lines for Zero in Z
%yline(xbar,'b-','Mean Z')
%yline(upperBound,'k--','CI upper')
%yline(lowerBound,'k--','CI lower')

hold off
ylabel('Acceleration (m/s^2) ')
xlabel('Sample Number')

legend('X data','Y data','Z data')



