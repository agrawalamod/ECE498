function final_data = makeContinous(data)
data_acc = data(strcmp(data.sensor_change,'android.sensor.accelerometer'),:);
%data_acc = data(strcmp(data.sensor_change,'K330 3-axis Accelerometer'),:);
data_acc = table2array(data_acc(2:end,1:4));
data_acc = horzcat(data_acc(:,1) - data_acc(1,1), data_acc(:,2:end));

last_ts = data_acc(length(data_acc),1);

final_data=[];
i=1;
new_index=0;

while(i<length(data_acc))
    accx=data_acc(i,2);
    accy=data_acc(i,3);
    accz=data_acc(i,4);
    while(new_index<data_acc(i+1,1))
        final_data = [final_data; new_index accx accy accz];
        new_index=new_index+1;
    end
    i=i+1;
end
