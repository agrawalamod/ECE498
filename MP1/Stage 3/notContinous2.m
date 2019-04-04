function final_data = makeContinous(data)
%data_acc = data(strcmp(data.sensor_change,'android.sensor.accelerometer'),:);
%data_acc = data(strcmp(data.sensor_change,'K330 3-axis Accelerometer'),:);
data_acc = data(strcmp(data.sensor_change, 'MPL Game Rotation Vector'),:);
data_acc = table2array(data(1:end,1:21));
data_acc = horzcat(data_acc(:,1) - data_acc(1,1), data_acc(:,2:end));

%last_ts = data_acc(length(data_acc),1);

final_data = data_acc;