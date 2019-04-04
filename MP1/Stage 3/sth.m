function contVal = sth(data)
[lgth,l1] = size(data);
lastTimeStamp = data(lgth, 1);
contVal = (1:lastTimeStamp)';

n = 1;
i = 1;
while and(n <= lgth-1, i<=lastTimeStamp)
  
   while contVal(i,1) < data(n+1,1)
           contVal(i,2)=data(n,2);
       i=i+1;
   end
   n = n+1;    
end
for xyz = 2:4
    contVal(lastTimeStamp,xyz)=data(n,xyz);
end

end