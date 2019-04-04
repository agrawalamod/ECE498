close all;
clear all;
d = readtable('./WALKING_02-50-19_095040_600cm.csv');

data = makeContinous(d);
time = data(:,1);
accx = data(:,2);
accy = data(:,3);
accz = data(:,4);
acc = sqrt(accy.^2 + accz.^2);

figure;
plot(time, acc);
hold on;
title('Raw Accelerometer data');
xlabel('Time');
ylabel('Acceleration');

result = smooth(acc,150);


[pks,locs] = findpeaks(result,'MinPeakHeight',10.5,'MinPeakDistance',500);

figure;
plot(time, result);
hold on;
scatter(locs, pks, 'v');
title('Step detection (after low-pass filtering)');
xlabel('Time');
ylabel('Acceleration');






