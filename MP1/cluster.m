close all;
clear all;

idling_data = readtable('./data/IDLE_02-51-19_08:51:13_0cm.csv');

jumping_data = readtable('./data/JUMPING_02-57-19_08:57:55_0cm.csv');

running_data = readtable('./data/RUNNING_02-02-19_09:02:19_1000cm.csv');

stairs_data = readtable('./data/STAIRS_02-03-19_09:03:31_1000cm.csv');

walking_data = readtable('./data/WALKING_02-50-19_095040_600cm.csv');


%{
idling_data = readtable('./pdata/IDLING_10-17-18_10:17:16_0cm.csv');

jumping_data = readtable('./pdata/JUMPING_10-15-18_10:15:43_0cm.csv');

running_data = readtable('./pdata/RUNNING_10-15-18_10:15:07_1000cm.csv');

stairs_data = readtable('./pdata/STAIRS_10-16-18_10:16:45_200cm.csv');

walking_data = readtable('./pdata/WALKING_10-13-18_10:13:48_1000cm.csv');
%}

[idling_matrix, idling_slices] = findFeatures(idling_data);
[jumping_matrix, jumping_slices] = findFeatures(jumping_data);
[running_matrix, running_slices] = findFeatures(running_data);
[stairs_matrix, stairs_slices] = findFeatures(stairs_data);
[walking_matrix, walking_slices] = findFeatures(walking_data);

%Mean
figure;
scatter(1:length(jumping_matrix),jumping_matrix(:,1),10,[1 0 0]);
hold on;
scatter(1:length(idling_matrix),idling_matrix(:,1),10,[1 1 0]);
hold on;
scatter(1:length(running_matrix),running_matrix(:,1),10,[0 0 1]);
hold on;
scatter(1:length(walking_matrix),walking_matrix(:,1),10,[0 0 0]);
hold on;
scatter(1:length(stairs_matrix),stairs_matrix(:,1),10,[0 1 0]);
title('Mean');
legend({'Jumping', 'Idling', 'Running', 'Walking', 'Stairs'});


%Median
figure;
scatter(1:length(jumping_matrix),jumping_matrix(:,2),10,[1 0 0]);
hold on;
scatter(1:length(idling_matrix),idling_matrix(:,2),10,[1 1 0]);
hold on;
scatter(1:length(running_matrix),running_matrix(:,2),10,[0 0 1]);
hold on;
scatter(1:length(walking_matrix),walking_matrix(:,2),10,[0 0 0]);
hold on;
scatter(1:length(stairs_matrix),stairs_matrix(:,2),10,[0 1 0]);
title('Median');
legend({'Jumping', 'Idling', 'Running', 'Walking', 'Stairs'});


%Max
figure;
scatter(1:length(jumping_matrix),jumping_matrix(:,3),10,[1 0 0]);
hold on;
scatter(1:length(idling_matrix),idling_matrix(:,3),10,[1 1 0]);
hold on;
scatter(1:length(running_matrix),running_matrix(:,3),10,[0 0 1]);
hold on;
scatter(1:length(walking_matrix),walking_matrix(:,3),10,[0 0 0]);
hold on;
scatter(1:length(stairs_matrix),stairs_matrix(:,3),10,[0 1 0]);
title('Max');
legend({'Jumping', 'Idling', 'Running', 'Walking', 'Stairs'});


%Zero
figure;
scatter(1:length(jumping_matrix),jumping_matrix(:,4),10,[1 0 0]);
hold on;
scatter(1:length(idling_matrix),idling_matrix(:,4),10,[1 1 0]);
hold on;
scatter(1:length(running_matrix),running_matrix(:,4),10,[0 0 1]);
hold on;
scatter(1:length(walking_matrix),walking_matrix(:,4),10,[0 0 0]);
hold on;
scatter(1:length(stairs_matrix),stairs_matrix(:,4),10,[0 1 0]);
title('Zero crossing');
legend({'Jumping', 'Idling', 'Running', 'Walking', 'Stairs'});


%Variance
figure;
scatter(1:length(jumping_matrix),jumping_matrix(:,5),10,[1 0 0]);
hold on;
scatter(1:length(idling_matrix),idling_matrix(:,5),10,[1 1 0]);
hold on;
scatter(1:length(running_matrix),running_matrix(:,5),10,[0 0 1]);
hold on;
scatter(1:length(walking_matrix),walking_matrix(:,5),10,[0 0 0]);
hold on;
scatter(1:length(stairs_matrix),stairs_matrix(:,5),10,[0 1 0]);
title('Variance');
legend({'Jumping', 'Idling', 'Running', 'Walking', 'Stairs'});


figure;
scatter3(idling_matrix(:,3), idling_matrix(:,1), idling_matrix(:,5), 10, [1 1 0]);
hold on;
scatter3(jumping_matrix(:,3), jumping_matrix(:,1), jumping_matrix(:,5), 10, [1 0 0]);
hold on;
scatter3(running_matrix(:,3), running_matrix(:,1), running_matrix(:,5), 10, [0 0 1]);
hold on;
scatter3(stairs_matrix(:,3), stairs_matrix(:,1), stairs_matrix(:,5), 10, [0 1 0]);
hold on;
scatter3(walking_matrix(:,3), walking_matrix(:,1), walking_matrix(:,5), 10, [0 0 0]);
hold on;
title('3D clusters');
legend({'Idling', 'Jumping', 'Running', 'Stairs', 'Walking'});
xlabel('Max');
ylabel('Mean');
zlabel('Variance');














