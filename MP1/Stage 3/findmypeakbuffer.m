function [pks, locs] = findmypeakbuffer(data)
    pks = [];
    locs = [];
    idx=1;
    buffersize = 2000;
    buffer=[];

    while(idx+buffersize<length(data))
        
        buffer = data(idx:idx+buffersize);
        
        i = 250;
        while(i<length(buffer)-250)
            if(mean(buffer(i-249:i))<buffer(i) && buffer(i)>mean(buffer(i:i+249)) && buffer(i)>=10.5)
                    pks = [pks buffer(i)];
                    locs = [locs idx+i];
                    i = i+250;
            else
                i = i+1;
            end
        end
        idx=locs(length(locs));
        
    end
end
    