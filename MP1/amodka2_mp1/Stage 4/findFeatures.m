function [feature_matrix, slices] = findFeatures(d)
    zcd = dsp.ZeroCrossingDetector
    time_slice = 400;

    data = makeContinous(d);
    
    time = data(:,1);
    accx = data(:,2);
    accy = data(:,3);
    accz = data(:,4);
    acc = sqrt(accx.^2 + accy.^2+ accz.^2);
    acc = smooth(acc,75);
   
    caccz= horzcat(time,acc);

    figure;
    plot(caccz(:,1),caccz(:,2));
    
    %caccz = horzcat(horzcat(horzcat(time, accy),accz),acc);
    len = size(caccz,1);
    a = 1.1;
    b = 2.1;
    c = [a b];

    feature_matrix = [];
    slices = [];
    i=1;
    while(i+time_slice<len)
        dslice = caccz(i:i+time_slice,2:end);
        slices = [slices; dslice'];
        
        f1 = mean(dslice);
        f2 = median(dslice);
        f3 = max(dslice);
        f4 = zcd(dslice);
        f5 = var(dslice);
        feat = [double(f1) double(f2) double(f3) double(f4) double(f5)];
        %features = [mean(dslice) var(dslice(:,1)) var(dslice(:,2)) var(dslice) zcd(dslice(:,1))];
        feature_matrix = [feature_matrix; feat];
        i = i+time_slice;
    end
    
end
