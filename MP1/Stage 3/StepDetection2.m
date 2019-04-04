close all;
clear all;
%d = readtable('./WALKING_02-50-19_095040_600cm.csv');

%d = readtable('./Amod_04-38-18_08:38:58_Peak2.csv');
%d = readtable('./Amod_04-39-18_08:39:30_Peak3.csv');
%d = readtable('./Amod_04-16-18_09:16:14_Peak4.csv');
%d = readtable('./Amod_04-19-18_09:19:38_Peak5.csv');

%d = readtable('./Amod_05-01-18_12:01:15_NewData.csv');
d = readtable('./Amod_03-51-19_02:51:56_DataCol3.csv');

data = notContinous(d);
time = data(:,1);
accx = data(:,2);
accy = data(:,3);
accz = data(:,4);
acc = sqrt(accy.^2 + accz.^2);

figure;
plot(1:length(acc), acc);
hold on;
title('Raw Accelerometer data');
xlabel('Time');
ylabel('Acceleration');

result = smooth(acc,50);
%result = acc;

%[pks,locs] = findpeaks(result,'MinPeakHeight',10.5,'MinPeakDistance',400);
[pks,locs] = findpeaks(result, 'MinPeakHeight', 10.8, 'MinPeakDistance', 50);
disp(length(pks));




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






