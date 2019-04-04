close all;
clear all;
%d = readtable('./WALKING_02-50-19_095040_600cm.csv');

%d = readtable('./Amod_04-38-18_08:38:58_Peak2.csv');
%d = readtable('./Amod_04-39-18_08:39:30_Peak3.csv');
%d = readtable('./Amod_04-16-18_09:16:14_Peak4.csv');
%d = readtable('./Amod_04-19-18_09:19:38_Peak5.csv');

%d = readtable('./Amod_05-01-18_12:01:15_NewData.csv');
d = readtable('./CompaseDataCollection_03-05-19_07:05:07_1.csv');

data = notContinous2(d);
time = data(:,1)./10^6;
gyro = data(:,7);
az = data(:,15);
compass_az = data(:,15);
compass_az=mod(compass_az+180,360);

%-180..0, -90..90, 0..180, 90..270, 180..360;


abs_gyro = abs(gyro);
[pks, locs] = findpeaks(abs_gyro, 'MinPeakHeight', 2, 'MinPeakDistance', 800);
pks = pks(1:14);

locs = locs(1:14);
deg = [0,90,180,90,0,270,180,270,360,270,180,90,0,90,180];
timepoints = [0 time(locs)'];


%{
time_array=[];
for i=1:length(timepoints)
        if(i==1)
            for j=1:timepoints(i)
                time_array=[time_array deg(1)];
            end
        else
            for k=1:(timepoints(i)-timepoints(i-1))
                time_array=[time_array deg(i)];
            end
        end
end
  %} 

mari_result = vertical(timepoints', deg');
figure();
%scatter(time, compass_az(locs));
plot(mari_result(:,1), mari_result(:,2),'LineWidth',2);
hold on;
scatter(time,compass_az, 1, 'MarkerFaceColor', [1 0 0]);
scatter(mari_result(:,1), mari_result(:,2),'MarkerFaceColor',[0 0 1]);
title('Fluctuations in Magnetic Compass values');
xlabel('Time (ms)');
ylabel('Degrees (0 - 360)');
legend('Compass - Ground Truth', 'Compass - Measured', '90 degree Turns')
%{
figure;
plot(1:length(abs_gyro), abs_gyro);
hold on;
scatter(locs, pks, 'v'); 

figure;
plot(time,time_array)


%}


%{

figure;
plot((1:length(result)), result);
hold on;
scatter(locs, pks, 'v');
title('Step detection (after low-pass filtering)');
xlabel('Time');
ylabel('Acceleration');

[pks, locs] = findmypeak(result, 10.8, 70);
disp(length(pks));

figure;
plot((1:length(result)), result);
hold on;
scatter(locs, pks, 'v');
title('Step detection (after low-pass filtering)-2');
xlabel('Time');
ylabel('Acceleration');
%}

