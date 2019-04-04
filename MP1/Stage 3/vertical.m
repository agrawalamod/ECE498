function allPoints = vertical(time, second)
[length, l] = size(time);
allPoints = (1:length+length-1)';

allPoints(1,1)=time(1);
allPoints(1,2)=second(1);

i = 2;
j = 2;
while i<length+1

        allPoints(j,1) = time(i);
       allPoints(j,2) = second(i-1);
       j=j+1;
       allPoints(j,1) = time(i);
       allPoints(j,2) = second(i);
       j=j+1;
        

    i=i+1;
end




end