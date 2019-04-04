function [pks, locs] = findmypeak(data, MinHeight, MinDist)
    pks = [];
    locs = [];
    midpnt = MinDist/2;
    i=midpnt;
    while(i<length(data)-midpnt)
        %disp(i);
        if(mean(data(i-(midpnt-1):i))<data(i) && data(i)>mean(data(i:i+(midpnt-1))))
            if(data(i) >= MinHeight)
                pks = [pks data(i)];
                locs = [locs i];
                i = i+midpnt;
            else
                i=i+1;
            end
            
        else
            i = i+1;
        end
    end
    %{
    i=250;
    while(i<length(data)-250)
        %disp(i);
        if(mean(data(i-249:i))<data(i) && data(i)>mean(data(i:i+249)))
            if(data(i) >= MinHeight)
                pks = [pks data(i)];
                locs = [locs i];
                i = i+250;
            else
                i=i+1;
            end
            
        else
            i = i+1;
        end
    end
    %}
end